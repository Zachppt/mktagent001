# Phishing Patterns
<!--
  Used by Security Agent: phishing_scan() via Google Safe Browsing + WHOIS
  List your official domain and the typosquat patterns to check.
  Delete these comment blocks before deploying.
-->

## Official Domain

- **Primary domain**: [yourproject.io]
- **All official subdomains**: app, docs, blog, api, status

---

## Typosquat Patterns to Check

<!-- Agent generates these variants and checks them weekly via WHOIS -->

### Character substitution
- [yourproject].io → [yourpr0ject].io (zero for o)
- [yourproject].io → [yourproiect].io (i for j)
- [yourproject].io → [youproject].io (missing letter)

### TLD variants (check all)
- [yourproject].com
- [yourproject].net
- [yourproject].org
- [yourproject].xyz
- [yourproject].app
- [yourproject].finance
- [yourproject].ai

### Prefix/suffix variants
- [yourproject]-app.io
- [yourproject]-airdrop.io
- [yourproject]-official.io
- [yourproject]-support.io
- [yourproject]-claim.io
- get-[yourproject].io
- [yourproject]-token.io

---

## Suspicious Email Patterns

### Spoofed sender domains to watch for
- [yourproject]-support@gmail.com
- noreply@[yourproject]-team.io
- [yourproject].official@proton.me
- [Any pattern that looks like your domain but isn't]

### Red flag email content patterns
- "Claim your [TOKEN_SYMBOL] tokens"
- "Verify your wallet to receive airdrop"
- "Your account has been selected"
- "Urgent: security verification required"
- Any email requesting private key or seed phrase

---

## Known Phishing Sites (already identified)

| Domain | First Seen | Status | Action Taken |
|--------|-----------|--------|-------------|
| [domain] | [date] | [reported / taken down / active] | [what was done] |

---

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
