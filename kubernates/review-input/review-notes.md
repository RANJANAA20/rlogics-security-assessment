# Kubernetes Security Review

## Workload
assessment-web Deployment

## Scope
Static code review only. The unsafe baseline must never be deployed.

## Findings

1. Critical - privileged container
   - privileged: true weakens container isolation and increases host compromise risk.

2. Critical - host root filesystem access
   - hostPath path "/" exposes the node filesystem to the workload.
   - Remove hostPath and its volume mount.

3. High - host networking
   - hostNetwork: true shares the node network namespace.
   - Remove it unless a documented requirement exists.

4. High - root execution
   - runAsUser: 0 runs the application as root.
   - Configure a non-root user and enforce non-root execution.

5. High - unnecessary default service account
   - Use a dedicated service account with token automounting disabled
     when Kubernetes API access is not required.

6. Medium - hard-coded password
   - Do not embed credentials in workload manifests or source control.
   - Remove the unused password. Use a Kubernetes Secret or an
     approved external secret manager if credentials are required.

7. Medium - mutable image tag
   - nginx:latest is mutable.
   - Pin a reviewed image version and preferably its verified digest.

8. Medium - missing container hardening
   - Drop Linux capabilities.
   - Disable privilege escalation.
   - Configure seccomp.
   - Use a read-only root filesystem where compatible.

9. Medium - missing resource controls
   - Define CPU and memory requests and limits.

10. Additional controls
    - Isolate the workload in a dedicated namespace.
    - Apply a suitable NetworkPolicy.
    - Validate resources with security scanners and admission policies.

## Deployment decision
Do not approve the original manifest. Create and validate a separate
hardened manifest before deployment.
