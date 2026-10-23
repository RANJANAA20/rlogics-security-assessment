
#!/usr/bin/env bash

set -u

SCRIPT="./k8s-check.sh"
passed=0
failed=0

run_test() {
    local name="$1"
    local file="$2"
    local expected="$3"

    "$SCRIPT" "$file" >/dev/null 2>&1
    actual=$?

    if [[ "$actual" -eq "$expected" ]]; then
        echo "PASS: $name"
        ((passed += 1))
    else
        echo "FAIL: $name (expected exit $expected, got $actual)"
        ((failed += 1))
    fi
}

run_test "Secure manifest" "examples/secure.yaml" 0
run_test "Risky manifest" "examples/risky.yaml" 1

echo "not: [valid YAML" > /tmp/invalid-k8s.yaml
run_test "Invalid YAML" "/tmp/invalid-k8s.yaml" 2
run_test "Missing file" "examples/missing.yaml" 2

echo
echo "Tests passed: $passed"
echo "Tests failed: $failed"

[[ "$failed" -eq 0 ]]
