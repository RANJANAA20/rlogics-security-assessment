
#!/usr/bin/env bash

# Kubernetes Security Checker
# Usage: ./k8s-check.sh file1.yaml [file2.yaml ...]

# Check if yq is installed
if ! command -v yq >/dev/null 2>&1; then
    echo "ERROR: Please install yq v4"
    exit 2
fi

# Check if files were provided
if [[ $# -eq 0 ]]; then
    echo "Usage: ./k8s-check.sh <file.yaml> [file2.yaml ...]"
    exit 2
fi

# Check each YAML file
for file in "$@"; do
    if [[ ! -f "$file" || ! -r "$file" ]]; then
        echo "ERROR: Cannot read file: $file"
        exit 2
    fi

    # Validate YAML syntax
    if ! yq eval '.' "$file" >/dev/null 2>&1; then
        echo "ERROR: Invalid YAML: $file"
        exit 2
    fi

    echo "Checking: $file"
    issues=0

    # 1. Privileged containers
    if yq -e '.. | select(has("privileged") and .privileged == true)' \
        "$file" >/dev/null 2>&1; then
        echo "HIGH: Privileged container"
        issues=1
    fi

    # 2. Root execution
    if yq -e '.. | select(has("runAsUser") and .runAsUser == 0)' \
        "$file" >/dev/null 2>&1; then
        echo "HIGH: Container configured to run as root"
        issues=1
    fi

    # 3. Host filesystem mount
    if yq -e '.. | select(has("hostPath"))' \
        "$file" >/dev/null 2>&1; then
        echo "HIGH: hostPath mount detected"
        issues=1
    fi

    # 4. Host networking
    if yq -e '.. | select(has("hostNetwork") and .hostNetwork == true)' \
        "$file" >/dev/null 2>&1; then
        echo "HIGH: Host networking enabled"
        issues=1
    fi

    # 5. Missing CPU or memory limits
    if yq -e '
        .. | select(has("containers")) | .containers[] |
        select(.resources.limits.cpu == null or
               .resources.limits.memory == null)
    ' "$file" >/dev/null 2>&1; then
        echo "MEDIUM: CPU or memory limit missing"
        issues=1
    fi

    # 6. Missing container securityContext
    if yq -e '
        .. | select(has("containers")) | .containers[] |
        select(.securityContext == null)
    ' "$file" >/dev/null 2>&1; then
        echo "MEDIUM: Container securityContext missing"
        issues=1
    fi

    # Final result for this file
    if [[ "$issues" -eq 1 ]]; then
        echo "RESULT: FAIL"
    else
        echo "RESULT: PASS"
    fi
    echo
done

# Return failure if any file has a security finding
if [[ "$issues" -eq 1 ]]; then
    exit 1
fi

exit 0
