#!/bin/bash
echo "=== 1. Running Semgrep SAST ==="
semgrep scan --config auto app-or-lab-target/ --json > sast/semgrep-results.json || true

echo "=== 2. Running Trivy Filesystem Scan ==="
trivy fs app-or-lab-target/ --format json -o container-scan/trivy-fs-results.json

echo "=== 3. Building Docker Image ==="
docker build -t devsecops-lab:latest app-or-lab-target/

echo "=== 4. Running Trivy Container Image Scan ==="
trivy image devsecops-lab:latest --format json -o container-scan/trivy-image-results.json

echo "=== 5. Generating CycloneDX SBOM ==="
trivy fs app-or-lab-target/ --format cyclonedx -o container-scan/sbom.json

echo "=== 6. Signing SBOM with Cosign ==="
cosign sign-blob --key signing/cosign.key container-scan/sbom.json --bundle signing/sbom.sigstore.json

echo "=== Pipeline Execution Complete! ==="
