# Stipple MCP server

**Documents in. Answers your agents can act on.**

[Stipple](https://www.stipple.sh) is a hosted [MCP](https://modelcontextprotocol.io)
server for document work: forensic authenticity signals, structured field extraction,
Australian identity checks, adverse-media and sanctions screening, AU/NZ government
tender search, AI-written-text detection, and citation verification for research
reports.

No install, no signup — an anonymous free tier works immediately.

## Connect

```bash
claude mcp add --transport http stipple https://www.stipple.sh/mcp
```

Or in any MCP client config:

```json
{ "mcpServers": { "stipple": { "type": "http", "url": "https://www.stipple.sh/mcp" } } }
```

- **Endpoint:** `https://www.stipple.sh/mcp` (Streamable HTTP)
- Always the `www.` host — the apex domain redirects, and a POST through the redirect fails for non-browser clients.
- **Auth:** none required. An optional free API key (`POST /v1/keys`) gives a private credit allowance; send it as `Authorization: Bearer stp_...`.

## Tools (13)

| Tool | What it does | What it is NOT |
|---|---|---|
| `verify_document` | Forensic authenticity inspection of a PDF/image (URL or base64): `risk_band` + `inspection_quality` + evidence | A fraud verdict — it is a signal with the evidence behind it |
| `extract_fields` | Structured fields from a document: ad-hoc field lists, templates (payslip, tax invoice, bank statement, receipt, contract), tables, per-value grounding, redaction, layout, chunking, splitting | A judgment — values are what the document shows; absences come back in `not_found` |
| `verify_identity` | Australian identity check over a document set: AFP 100-point or AUSTRAC safe-harbour, with exactly what is missing | A forgery check — pair with `verify_document` |
| `check_pack` | Does a document set satisfy a checklist (named scheme or ad-hoc requirements)? | Approval — presence of the right types, not genuineness |
| `screen_adverse_media` | Adverse media + corroboration-gated sanctions/PEP screening of a person or organisation | A determination — "review", never "guilty"; "nothing found" is not a clean record |
| `find_tenders` | **Free.** Search open AU/NZ government tenders | — |
| `match_tenders` | Rank open tenders against what a company's own website says it does, with `why[]` and `gaps[]` | A win probability |
| `tender_sources` | **Free.** Where tender data comes from, and why a search can be empty | — |
| `detect_ai_text` | Probability a document's prose is AI-written, with the linguistic tells; abstains on non-prose | Calibrated truth — and style, not authenticity |
| `verify_references` | For a report: citations resolve and match, internal arithmetic recomputes, unsupported claims flagged | A truth verdict — it reports verification coverage |
| `check_document` | Has this exact file (sha256) been inspected already? Skips a paid call | — |
| `get_warrant` | Fetch a stored result bundle (JSON or Markdown) | — |
| `submit_feedback` | Thumbs up/down on a rating | — |

## Prompts (8)

Guided workflows shipped with the server: *Verify a document's authenticity* · *What
kind of document is this?* · *Run a 100-point identity check* · *Screen a person for
adverse media* · *Find tenders my company could bid for* · *Was this written by AI?* ·
*Fact-check a report URL* · *Fact-check pasted text*.

## How results read

Every inspection reports two independent axes: **`risk_band`** (how authentic the
document looks) and **`inspection_quality`** (how completely it could be inspected). A
clean phone photo of a real payslip is commonly `low` risk + `limited` quality — "nothing
looks tampered, but we couldn't read everything". Low coverage is not risk.

Identical documents are cached by content hash — resubmitting the same bytes returns the
stored result instantly and free.

## Credits

Anonymous callers share a free weekly allowance per IP. A free API key gets its own
allowance and metering. Tender search and source listing cost nothing. Details:
[stipple.sh/pricing](https://www.stipple.sh/pricing).

## Also available

- **REST API** — the same engines at `/v1/*`; OpenAPI contract at [`/openapi.json`](https://www.stipple.sh/openapi.json)
- **Agent docs** — [`/agents.md`](https://www.stipple.sh/agents.md) (short form [`/llms.txt`](https://www.stipple.sh/llms.txt))
- **Scoped servers** — `/mcp-aitext` (AI-text detection only) and `/mcp-verify` (reference verification only), for installs that want a single tool

---

Operated by Stipple AI Pty Ltd · [Privacy](https://www.stipple.sh/privacy) · [Terms](https://www.stipple.sh/terms)
