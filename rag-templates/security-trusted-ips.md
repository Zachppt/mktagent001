# Trusted IPs
<!--
  Used by Security Agent: account_audit() and api_audit()
  List all IP ranges that should NOT trigger security alerts.
  Delete these comment blocks before deploying.
-->

## Trusted IP Ranges

### Team / Office
| IP / Range | Description |
|-----------|-------------|
| [xxx.xxx.xxx.xxx] | [e.g. Founder home office] |
| [xxx.xxx.xxx.0/24] | [e.g. Office network range] |

### Infrastructure
| IP / Range | Description |
|-----------|-------------|
| [xxx.xxx.xxx.xxx] | VPS — primary server |
| [xxx.xxx.xxx.xxx] | VPS — backup server |
| [xxx.xxx.xxx.0/24] | [CI/CD pipeline IP range — e.g. GitHub Actions] |

### Known API Services
| IP / Range | Description |
|-----------|-------------|
| [Notion API egress range] | Notion API calls |
| [Google API egress range] | Google services |

---

## How to Add a New Trusted IP

1. Identify the IP in an audit_alert() notice
2. Confirm with the team member or service it belongs to
3. Add to this file with description
4. Re-run `account_audit()` manually to clear the flag

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
