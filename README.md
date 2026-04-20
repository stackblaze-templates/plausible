# Plausible [![Version](https://img.shields.io/badge/version-2-5850ec)](https://github.com/stackblaze-templates/plausible) [![Maintained by StackBlaze](https://img.shields.io/badge/maintained%20by-StackBlaze-blue)](https://stackblaze.com) [![Weekly Updates](https://img.shields.io/badge/updates-weekly-green)](https://github.com/stackblaze-templates/plausible/actions) [![License](https://img.shields.io/github/license/stackblaze-templates/plausible)](LICENSE) [![Deploy on StackBlaze](https://img.shields.io/badge/Deploy%20on-StackBlaze-orange)](https://stackblaze.com)

<p align="center"><img src="logo.png" alt="plausible" width="120"></p>

Simple and privacy-friendly web analytics. Lightweight (<1KB script), no cookies, fully GDPR/CCPA compliant.

> **Credits**: Built on [Plausible](https://plausible.io) by [Plausible Analytics](https://github.com/plausible). All trademarks belong to their respective owners.

## Local Development

```bash
docker compose up
```

See the project files for configuration details.

## Deploy on StackBlaze

[![Deploy on StackBlaze](https://img.shields.io/badge/Deploy%20on-StackBlaze-orange)](https://stackblaze.com)

This template includes a `stackblaze.yaml` for one-click deployment on [StackBlaze](https://stackblaze.com). Both options run on **Kubernetes** for reliability and scalability.

<details>
<summary><strong>Standard Deployment</strong> — Single-instance Kubernetes setup for startups and moderate traffic</summary>

<br/>

```mermaid
flowchart LR
    U["Customers"] -->|HTTPS| LB["Edge Network\n+ SSL"]
    LB --> B["Plausible\nElixir"]
    B --> DB[("PostgreSQL\nManaged DB")]
    B --> S3["ClickHouse\nEvent Storage"]

    style LB fill:#ff9800,stroke:#e65100,color:#fff
    style B fill:#0041ff,stroke:#002db3,color:#fff
    style DB fill:#4caf50,stroke:#2e7d32,color:#fff
    style S3 fill:#2196f3,stroke:#1565c0,color:#fff
```

**What you get:**
- Single Plausible instance on Kubernetes
- Managed PostgreSQL database
- Automatic SSL/TLS via StackBlaze edge network
- Managed ClickHouse for event storage
- Automated daily backups
- Zero-downtime deploys

**Best for:** Development, staging, and moderate-traffic production environments.

</details>

<details>
<summary><strong>High Availability Deployment</strong> — Multi-instance Kubernetes setup for business-critical production</summary>

<br/>

```mermaid
flowchart LR
    U["Customers"] -->|HTTPS| CDN["CDN\nStatic Assets"]
    CDN --> LB["Load Balancer\nAuto-scaling"]
    LB --> B1["Plausible #1"]
    LB --> B2["Plausible #2"]
    LB --> B3["Plausible #N"]
    B1 --> R[("Redis\nSessions + Cache")]
    B2 --> R
    B3 --> R
    B1 --> DBP[("PostgreSQL Primary\nRead + Write")]
    B2 --> DBP
    B3 --> DBR[("PostgreSQL Replica\nRead-only")]
    DBP -.->|Replication| DBR
    B1 --> S3["ClickHouse\nEvent Storage"]
    B2 --> S3
    B3 --> S3

    style CDN fill:#607d8b,stroke:#37474f,color:#fff
    style LB fill:#ff9800,stroke:#e65100,color:#fff
    style B1 fill:#0041ff,stroke:#002db3,color:#fff
    style B2 fill:#0041ff,stroke:#002db3,color:#fff
    style B3 fill:#0041ff,stroke:#002db3,color:#fff
    style R fill:#f44336,stroke:#c62828,color:#fff
    style DBP fill:#4caf50,stroke:#2e7d32,color:#fff
    style DBR fill:#66bb6a,stroke:#388e3c,color:#fff
    style S3 fill:#2196f3,stroke:#1565c0,color:#fff
```

**What you get:**
- Auto-scaling Plausible pods on Kubernetes behind a load balancer
- Redis for shared sessions, cache, and queue management
- PostgreSQL primary + read replica for high throughput
- CDN for static assets
- Managed ClickHouse cluster for event storage
- Automated failover and self-healing
- Zero-downtime rolling deploys

**Best for:** Production workloads, high-traffic applications, business-critical deployments.

</details>

---

## Security Configuration

Before exposing Plausible to the internet, set these environment variables — **never use the defaults in production**.

| Variable | Required | Description |
|---|---|---|
| `SECRET_KEY_BASE` | ✅ Yes | 64-character random secret. Generate: `openssl rand -base64 48` |
| `DATABASE_URL` | ✅ Yes | Full PostgreSQL connection string including a strong password |
| `BASE_URL` | ✅ Yes | Public HTTPS URL of your Plausible instance |

**Insecure defaults to change before production:**

- `SECRET_KEY_BASE` — the placeholder value in `docker-compose.yml` is not a secret; replace it.
- `POSTGRES_PASSWORD` — the default `plausible` password is well-known; use a strong unique password.
- `BASE_URL` — update to your real HTTPS domain so cookies are flagged `Secure`.

Copy `.env.example` to `.env`, fill in real values, and pass them to the containers. The `.env` file is excluded from version control by `.gitignore`.

---

### Maintained by [StackBlaze](https://stackblaze.com)

This template is actively maintained by StackBlaze. We perform **weekly automated checks** to ensure:

- **Up-to-date dependencies** — frameworks, libraries, and base images are kept current
- **Security scanning** — continuous monitoring for known vulnerabilities and CVEs
- **Best practices** — configurations follow current recommendations from upstream projects

Found an issue? [Open a ticket](https://github.com/stackblaze-templates/plausible/issues).
