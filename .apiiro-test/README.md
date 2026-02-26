# APIIRO Security Scanner Test Fixtures

**⚠️ DO NOT MERGE TO PRODUCTION**

This folder contains intentionally vulnerable code for testing APIIRO security scanning.

| Severity | Vulnerability Type | File |
|----------|-------------------|------|
| **HIGH** | Hardcoded secrets/API keys | All |
| **HIGH** | SQL Injection | All |
| **HIGH** | eval() with user input | vulnerabilities.ts |
| **MEDIUM** | Insecure random (Math.random) | vulnerabilities.ts |
| **MEDIUM** | Sensitive data in logs | All |
| **LOW** | Weak password validation | All |
| **LOW** | Insecure HTTP URL | vulnerabilities.ts |
| **LOW** | TODO/FIXME in code | vulnerabilities.ts |

Remove this folder before releasing to production.
