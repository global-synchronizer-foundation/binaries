Make sure that the following points are true.

For GitHub Workflows:
- permissions are set to '{}' for workflow and overridden for each job where needed
- versions of github actions are pinned to a specific commit unless the action belongs to one of: the same organization (global-synchronizer-foundation), github official actions
- shell snippets (under `run:`) don't have templated variables and environment variables are used instead

For shell scripts:
- conforms ShellCheck
