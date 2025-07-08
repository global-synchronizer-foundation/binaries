Make sure that the follownig is true.

For GitHub Workflows:
- permissions are set to '{}' for workflow and overridden for each job where needed
- shell snippets (under `run:`) don't have templated variables and environment variables are used instead

For shell scripts:
- conforms ShellCheck
