## Part B — OpenBao PKI Lab

### Objective

Demonstrate certificate issuance using OpenBao's PKI secrets engine, a restricted role, and short-lived X.509 certificates.

### Implementation

- Started OpenBao locally using its official container image in development mode.
- Enabled the PKI secrets engine at `pki/`.
- Generated a lab CA named `OpenBao Lab Root CA`.
- Created the `lab-app` role for `app.lab.example.com`.
- Restricted wildcard certificates, IP SANs, localhost certificates and subdomains.
- Set the role's maximum certificate TTL to one hour.
- Issued a certificate with a requested TTL of 15 minutes.
- Inspected the certificate subject, issuer, SAN and validity dates using OpenSSL.
- Verified the certificate against the lab CA using `openssl verify`.

### Verification evidence

**Certificate subject:** `CN=app.lab.example.com`

**Issuer:** `CN=OpenBao Lab Root CA`

**SAN:** `DNS:app.lab.example.com`

**Validity:** 12 October 2026, 07:02:07–07:17:37 UTC

**Chain verification:** `pki/app.crt: OK`

### Production redesign

**1. Root and intermediate CA hierarchy**

Keep the root CA offline or otherwise highly protected. Use it to sign an intermediate CA, and use the intermediate for routine certificate issuance. This limits exposure of the root signing key. Define CA rotation and compromise-response procedures.

**2. TLS and network security**

Expose OpenBao through HTTPS with valid TLS certificates. Restrict network access to authorised workloads and administrators. Do not use the local HTTP endpoint or development configuration in production.

**3. Durable storage and high availability**

Replace in-memory development storage with a supported, durable storage configuration. Configure high availability where required and monitor service health, storage capacity and availability.

**4. Authentication and least privilege**

Use an appropriate workload identity mechanism, such as Kubernetes service-account authentication. Avoid static root tokens. Bind workload identities to policies that grant access only to the necessary PKI role and issuance path.

**5. Certificate role restrictions**

Use separate roles for different applications. Restrict permitted DNS names, SANs, certificate usages and maximum TTLs. Ensure each workload can issue certificates only for its authorised identities.

**6. Audit logging**

Enable and protect OpenBao audit devices. Monitor authentication failures, policy changes, certificate issuance and administrative actions. Secure audit records against unauthorised modification.

**7. Backup and recovery**

Create protected backups of the durable storage and required recovery material. Test restoration, unseal or recovery procedures, CA recovery, and certificate reissuance. Protect backups and CA keys separately according to the threat model.

**8. Short-lived certificate lifecycle**

Automate renewal before expiry, monitor renewal failures, and ensure applications reload renewed certificates. Define a response for OpenBao outages and certificate compromise. Use revocation mechanisms where supported by the clients and infrastructure.

### Lab limitations

This is a disposable development-mode lab using a single lab CA. It does not demonstrate production high availability, durable storage, a protected root/intermediate hierarchy, production authentication or a complete recovery process.

The lab CA is used directly for issuance to demonstrate the mechanics. A production deployment should use a protected root and an intermediate CA for routine issuance.