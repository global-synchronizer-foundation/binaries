#!/bin/bash

set -euo pipefail

GSF_ENV=$1
GSF_DOCS=$2
SVS_MAJORITY="false"

gsf_version() {
    GSF_VERSION=$(curl -sSm5 "${GSF_DOCS}/info" | jq -r .sv.version)
}

check_svs_majority() {
    ALL_VERSIONS=$(curl -sSm5 "${GSF_DOCS}/versions" | \
      awk -F',' 'NR > 1 { gsub(/^ +| +$/, "", $3); print $3 }'
      )
    SVS_WITH_GSF_VERSION=$(echo "$ALL_VERSIONS" | grep -c "$GSF_VERSION")
    ALL_VERSIONS_COUNT=$(echo "$ALL_VERSIONS" | wc -l)
    echo "GSF ${GSF_ENV} version:               $GSF_VERSION"
    echo "SVs with GSF version:             $SVS_WITH_GSF_VERSION"
    echo "SVs needed for 2/3 majority:      $(((ALL_VERSIONS_COUNT +1) * 2 / 3))"
    echo "Total SVs:                        $ALL_VERSIONS_COUNT"
    echo "SVs with GSF version percentage:  $((SVS_WITH_GSF_VERSION * 100 / ALL_VERSIONS_COUNT))%"
    if [ "$SVS_WITH_GSF_VERSION" -lt "$(((ALL_VERSIONS_COUNT +1) * 2 / 3))" ]; then
        export SVS_MAJORITY="false"
        echo -e "[ERROR] Not enough SVs with GSF version for majority"
    else
        export SVS_MAJORITY="true"
        echo -e "[INFO] Enough SVs with GSF version for majority"
    fi
}

gsf_version
check_svs_majority

echo "svs_majority=$SVS_MAJORITY" >> "$GITHUB_OUTPUT"
