RLogics Security Assessment

A hands-on DevSecOps, Kubernetes Security, Secrets Management, and AI Security assessment project focused on integrating security controls across the software delivery lifecycle.
This repository brings together practical security labs, configuration examples, automated checks, policy enforcement, and validation evidence to demonstrate how security can be incorporated into application development, CI/CD pipelines, container deployments, Kubernetes workloads, and AI-powered applications.

Project Objectives

- Integrate security checks into the software development and delivery lifecycle.
- Identify source-code, dependency, container-image, and application security issues.
- Demonstrate container image signing and verification.
- Apply Kubernetes hardening and admission policies.
- Manage certificates and short-lived database credentials using OpenBao.
- Explore controlled adversary emulation and security validation.
- Test local LLM and RAG applications against access-control failures and prompt injection.
- Maintain evidence and documentation for security reviews and compliance discussions.

Repository Structure

RLogics/
├── README.md
├── devsecops/
│   ├── app/
│   ├── sast/
│   ├── container-scan/
│   ├── dast/
│   ├── signing/
│   ├── pipeline/
│   └── evidence/
├── ai-security/
│   ├── application and API
│   ├── RAG components
│   ├── LLM security tests
│   └── Promptfoo configuration
├── caldera/
│   └── caldera-lab/
├── kubernates/
│   ├── review-input/
│   ├── hardened/
│   ├── policies/
│   └── evidence/
├── openbao/
│   ├── pki/
│   └── database-secrets/
└── architecture/

 Security Labs

1. DevSecOps and CI/CD Security

Objective: Integrate automated security checks into the application delivery process.

Tools and controls explored:

- Semgrep: Static Application Security Testing (SAST).
- Trivy: Container image and vulnerability scanning.
- OWASP ZAP: Dynamic Application Security Testing (DAST).
- Cosign: Container image signing and signature verification.
- SBOM: Software Bill of Materials generation and review.
- CI/CD: Security checks, pipeline integration, and release-gate concepts.

The lab explores how security findings can be collected and used to inform build and release decisions.

2. Kubernetes Security Hardening

Objective: Reduce workload risk through secure configurations and policy enforcement.

Key activities:

- Review unsafe Kubernetes manifests.
- Configure non-root containers and security contexts.
- Define resource requests and limits.
- Review host-level access and privileged container risks.
- Apply NetworkPolicy examples.
- Use Kyverno to enforce admission policies.
- Scan manifests and images with Trivy.
- Explore Cosign image signature verification.
- Maintain security review notes and validation evidence.

The lab distinguishes between preventive controls at admission time, detective controls during scanning and runtime monitoring, and corrective actions such as rollback or remediation.

3. OpenBao PKI and Database Secrets

Objective: Explore centralized secrets management and certificate issuance.

Key activities:

- Configure an OpenBao development lab.
- Explore PKI and application certificate issuance.
- Configure database secrets and credential leases.
- Understand short-lived database credentials and credential rotation.
- Consider failure scenarios such as OpenBao unavailability, expired leases, CA rotation, and incorrect policies.
- Explore workload authentication and least-privilege access.

Security note: Development tokens and local test credentials must not be reused in production.

 4. AI and LLM Application Security

Objective: Evaluate security risks in a local LLM application that uses retrieval-augmented generation (RAG).

Components explored:

- FastAPI application endpoints.
- Local inference using Ollama and Qwen 2.5 3B Instruct.
- Document retrieval and embeddings using ChromaDB and Sentence Transformers.
- Role-based access controls.
- A mock ticket tool with server-side authorization.
- Promptfoo-based security regression tests.

Security scenarios include:

- Prompt injection attempts.
- Unauthorized access to restricted documents.
- Attempts to retrieve synthetic administrative information.
- Role and access-control validation.
- Security regression testing against application APIs.

The lab focuses on enforcing authorization in the application rather than relying on the LLM prompt alone.

 5. Caldera Adversary Emulation

Objective: Explore controlled security validation using MITRE Caldera.

The lab contains a local Caldera environment for examining agents, abilities, adversary profiles, and operations.

Testing should remain confined to an isolated lab environment with authorized targets. Begin with benign discovery and validation activities before considering additional techniques.

 6. Security Architecture and Evidence

The architecture work brings together security controls across the software lifecycle:

- Build time: SAST, dependency checks, secrets scanning, IaC review, and image scanning.
- Artifact trust: SBOM generation, image signing, and verification.
- Admission time: Kubernetes policy enforcement and approved-image verification.
- Runtime: Workload monitoring, configuration-drift detection, and incident evidence.
- AI security: LLM testing, authorization validation, and prompt-injection regression tests.

The project also explores how security evidence can support discussions around ISO/IEC 27001, ISO/IEC 42001, and SOC 2.

