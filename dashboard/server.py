#!/usr/bin/env python3
"""
web3-mkt-agents Dashboard Server
Serves the dashboard and provides API endpoints to read/write RAG files on VPS.

Usage:
  python3 server.py --port 8765 --token YOUR_SECRET_TOKEN

SSH tunnel from your local machine:
  ssh -L 8765:localhost:8765 user@YOUR_VPS_IP
  Open: http://localhost:8765

Security:
  - Binds to 127.0.0.1 by default (never exposed to public internet)
  - File access uses strict allowlist — only the 23 known RAG filenames
  - URL-decode applied before validation (defeats %2F / %2E%2E bypass)
  - Auth token checked on every /api/* request
  - Rate limiting: 60 API requests per minute per IP
  - Request body capped at 512 KB
"""

import argparse
import json
import time
from collections import defaultdict
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path
from urllib.parse import urlparse, unquote

# ── Config ────────────────────────────────────────────────────────────────────
OPENCLAW_DIR      = Path.home() / ".openclaw"
RAG_TEMPLATES_DIR = Path(__file__).parent.parent / "rag-templates"
MAX_BODY_BYTES    = 512 * 1024
RATE_LIMIT        = 60
RATE_WINDOW       = 60

# Strict allowlist — ONLY these exact filenames may be read or written.
ALLOWED_RAG_FILES = {
    "brand-voice.md", "kpi-targets.md", "alert-thresholds.md",
    "crisis-sop.md", "competitor-intel.md", "seo-keywords.md",
    "community-faq.md", "community-moderator-guidelines.md", "channel-config.md",
    "bd-icp.md", "bd-email-templates.md", "bd-event-targets.md",
    "security-impersonation-keywords.md", "security-phishing-patterns.md", "security-trusted-ips.md",
    "finance-budget-plan.md", "finance-vendor-list.md",
    "eco-icp.md", "eco-event-formats.md",
    "content-style-guide.md", "social-meme-templates.md",
    "routing-rules.md", "agent-registry.md",
}

RAG_WORKSPACE_MAP = {
    "brand-voice.md":                     ["workspace-social","workspace-content","workspace-eco","workspace-community"],
    "kpi-targets.md":                     ["workspace-pm","workspace-data"],
    "alert-thresholds.md":                ["workspace-data"],
    "crisis-sop.md":                      ["workspace-pm","workspace-community"],
    "competitor-intel.md":                ["workspace-data"],
    "seo-keywords.md":                    ["workspace-data"],
    "community-faq.md":                   ["workspace-community"],
    "community-moderator-guidelines.md":  ["workspace-community"],
    "channel-config.md":                  ["workspace-community"],
    "bd-icp.md":                          ["workspace-bd"],
    "bd-email-templates.md":              ["workspace-bd"],
    "bd-event-targets.md":                ["workspace-bd"],
    "security-impersonation-keywords.md": ["workspace-security"],
    "security-phishing-patterns.md":      ["workspace-security"],
    "security-trusted-ips.md":            ["workspace-security"],
    "finance-budget-plan.md":             ["workspace-finance"],
    "finance-vendor-list.md":             ["workspace-finance"],
    "eco-icp.md":                         ["workspace-eco"],
    "eco-event-formats.md":               ["workspace-eco"],
    "content-style-guide.md":             ["workspace-content"],
    "social-meme-templates.md":           ["workspace-social"],
    "routing-rules.md":                   ["workspace-pm"],
    "agent-registry.md":                  ["workspace-pm"],
}

AUTH_TOKEN  = None
_rate_store = defaultdict(list)


def _safe_filename(raw: str):
    """URL-decode then validate against allowlist. Returns name or None."""
    decoded = unquote(raw)       # defeats %2F, %2E%2E, etc.
    name    = Path(decoded).name # strip any path components
    return name if name in ALLOWED_RAG_FILES else None


def _check_rate(ip: str) -> bool:
    now   = time.time()
    cutoff = now - RATE_WINDOW
    _rate_store[ip] = [t for t in _rate_store[ip] if t > cutoff]
    if len(_rate_store[ip]) >= RATE_LIMIT:
        return False
    _rate_store[ip].append(now)
    return True


class Handler(BaseHTTPRequestHandler):

    def log_message(self, fmt, *args):
        ip = self.client_address[0]
        print(f"[{time.strftime('%H:%M:%S')}] {ip} {fmt % args}")

    def _json(self, code, data):
        body = json.dumps(data).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", len(body))
        self.send_header("Access-Control-Allow-Origin", "http://localhost:8765")
        self.end_headers()
        self.wfile.write(body)

    def _file(self, path, ctype):
        if not path.exists():
            self.send_response(404); self.end_headers(); return
        body = path.read_bytes()
        self.send_response(200)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", len(body))
        self.end_headers()
        self.wfile.write(body)

    def _auth(self) -> bool:
        if AUTH_TOKEN and self.headers.get("X-Dashboard-Token","") != AUTH_TOKEN:
            self._json(401, {"error": "Unauthorized"}); return False
        return True

    def _rate(self) -> bool:
        if not _check_rate(self.client_address[0]):
            self._json(429, {"error": "Rate limit exceeded"}); return False
        return True

    def do_OPTIONS(self):
        self.send_response(204)
        self.send_header("Access-Control-Allow-Origin", "http://localhost:8765")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type, X-Dashboard-Token")
        self.end_headers()

    def do_GET(self):
        path = urlparse(self.path).path

        if path in ("/", "/index.html"):
            self._file(Path(__file__).parent / "index.html", "text/html; charset=utf-8")
            return

        if not self._rate() or not self._auth():
            return

        if path == "/api/rag/list":
            files = []
            for fname, wss in RAG_WORKSPACE_MAP.items():
                deployed = any((OPENCLAW_DIR/ws/"rag"/fname).exists() for ws in wss)
                files.append({"filename": fname, "workspaces": wss,
                               "deployed": deployed,
                               "has_template": (RAG_TEMPLATES_DIR/fname).exists()})
            self._json(200, {"files": files}); return

        if path.startswith("/api/rag/read/"):
            fname = _safe_filename(path[len("/api/rag/read/"):])
            if not fname:
                self._json(400, {"error": "File not in allowlist"}); return
            content = source = None
            for ws in RAG_WORKSPACE_MAP.get(fname, []):
                p = OPENCLAW_DIR / ws / "rag" / fname
                if p.exists():
                    content = p.read_text(encoding="utf-8"); source = "workspace"; break
            if content is None:
                tp = RAG_TEMPLATES_DIR / fname
                if tp.exists():
                    content = tp.read_text(encoding="utf-8"); source = "template"
            if content is None:
                self._json(404, {"error": "File not found"}); return
            self._json(200, {"filename": fname, "content": content, "source": source}); return

        self._json(404, {"error": "Not found"})

    def do_POST(self):
        if not self._rate() or not self._auth():
            return
        path = urlparse(self.path).path

        if path.startswith("/api/rag/write/"):
            fname = _safe_filename(path[len("/api/rag/write/"):])
            if not fname:
                self._json(400, {"error": "File not in allowlist"}); return
            length = int(self.headers.get("Content-Length", 0))
            if length > MAX_BODY_BYTES:
                self._json(413, {"error": "Body too large"}); return
            if length == 0:
                self._json(400, {"error": "Empty body"}); return
            try:
                body = json.loads(self.rfile.read(length))
            except Exception as e:
                self._json(400, {"error": f"Invalid JSON: {e}"}); return
            content = body.get("content", "")
            if not isinstance(content, str):
                self._json(400, {"error": "'content' must be a string"}); return

            written = []
            for ws in RAG_WORKSPACE_MAP.get(fname, []):
                d = OPENCLAW_DIR / ws / "rag"
                d.mkdir(parents=True, exist_ok=True)
                (d / fname).write_text(content, encoding="utf-8")
                written.append(str(d / fname))
            tpl_updated = False
            if RAG_TEMPLATES_DIR.exists():
                (RAG_TEMPLATES_DIR / fname).write_text(content, encoding="utf-8")
                tpl_updated = True
            self._json(200, {"ok": True, "filename": fname,
                             "written_to": written, "template_updated": tpl_updated})
            return

        self._json(404, {"error": "Not found"})


def main():
    global AUTH_TOKEN
    ap = argparse.ArgumentParser(description="web3-mkt-agents Dashboard Server")
    ap.add_argument("--port",  type=int, default=8765)
    ap.add_argument("--host",  type=str, default="127.0.0.1")
    ap.add_argument("--token", type=str, default="")
    args = ap.parse_args()

    if not args.token:
        print("\n⚠️  WARNING: No --token set. API is unprotected.")
        print("   Generate one: openssl rand -hex 32\n")
    if args.host == "0.0.0.0":
        print("\n⚠️  WARNING: Binding to 0.0.0.0 exposes dashboard to the network.")
        print("   Use SSH tunnel instead (see README).\n")

    AUTH_TOKEN = args.token or None
    server = HTTPServer((args.host, args.port), Handler)
    print(f"\n🤖  web3-mkt-agents Dashboard")
    print(f"    http://localhost:{args.port}")
    print(f"    Auth:  {'enabled' if AUTH_TOKEN else 'DISABLED'}")
    print(f"    Limit: {RATE_LIMIT} req/min/IP")
    print(f"\n    SSH tunnel: ssh -L {args.port}:localhost:{args.port} user@VPS_IP\n")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nStopped.")

if __name__ == "__main__":
    main()
