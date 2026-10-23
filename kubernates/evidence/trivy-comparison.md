# Trivy Kubernetes Misconfiguration Scan

## Tool
Trivy v0.75.0

## Unsafe baseline
File: review-input/assessment-web-unsafe.yaml
Results: 5 misconfigurations, all HIGH severity.

Findings:
1. KSV-0009: hostNetwork is enabled.
2. KSV-0014: readOnlyRootFilesystem is not enabled.
3. KSV-0017: privileged container is enabled.
4. KSV-0118: default security context allows root privileges.
5. KSV-0121: hostPath mounts the host root filesystem.

The baseline was scanned as a file only. It was never deployed.

## Hardened resources
Files: hardened/

Results: 0 misconfigurations reported by this Trivy scan.

Security improvements:
- Removed host networking and hostPath access.
- Disabled privileged execution.
- Configured a non-root user.
- Enabled a read-only root filesystem.
- Dropped Linux capabilities and disabled privilege escalation.
- Added seccomp and resource requests/limits.
- Used a dedicated service account with token automounting disabled.
- Added a NetworkPolicy.
- Pinned the container image by digest.

## Interpretation and limitations
The scan demonstrates that the hardened YAML passes the applicable
misconfiguration checks in this Trivy version. A zero-finding result
does not prove complete security. It does not replace runtime testing,
image vulnerability scanning, admission enforcement, or continuous
monitoring. The reported five findings are the checks that failed;
other weaknesses may require separate manual review or additional tools.
