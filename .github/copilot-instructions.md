Make sure that the following points are true.

For GitHub Workflows:
- permissions are set to `{}` for the workflow and overridden for each job where needed
- all jobs have timeouts set (timeout-minutes)
- versions of github actions are pinned to a specific commit unless the action belongs to one of: the same organization (global-synchronizer-foundation), official GitHub Actions
- shell snippets (under `run:`) don't have workflow templated variables (in the form of `${{ somevariable }}`) and environment variables are used instead

For shell scripts:
- conforms to ShellCheck
