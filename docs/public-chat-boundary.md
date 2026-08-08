# Public chat experiment boundary

This decision is intentionally recorded so the public chat experiment does not accidentally become a
PersonalWeb Spring AI feature or expose Cloudflare OS.

## Required architecture

```text
Public website widget
  -> dedicated public Cloudflare Worker
  -> OpenAI API (server-side secret)

Private Cloudflare OS at os.thonbecker.biz
  -> Cloudflare Access
  -> learning, administration, Gatekeepers, approvals, and future private tools
```

The public Worker and the private Workshop are separate surfaces. Do not embed the Workshop, remove its
Access protection, or make its admin and Gatekeeper UI public just to support the widget.

## Initial scope

- General questions about Thon's public work, projects, and services
- No booking lookup or booking creation
- No database, AWS, Nextcloud, or private-file access
- No API key in browser code, HTML, GitHub, or tracked configuration
- Basic request size, abuse, and cost controls
- Structured request logs and Cloudflare analytics may count usage, but do not store message content or identifying data

The public Worker may use Cloudflare primitives such as Workers, KV, rate limiting, observability, and
AI Gateway where appropriate. It must not be confused with the PersonalWeb Spring AI integration, which is
not the chosen implementation for this experiment.

## Before deployment

1. Remove or leave disabled any uncommitted Spring AI chat implementation in PersonalWeb.
2. Build the public Worker in the `cloudflare-os-personal` repository.
3. Test the Worker with a dedicated restricted OpenAI project/key.
4. Add the widget to the website only after the Worker passes secret-leak and abuse checks.
5. Keep Cloudflare OS Access-protected throughout the experiment.

## Deployment and secret setup

The repository deployment script deploys this Worker separately as `thonbecker-public-chat` at
`chat.thonbecker.biz`. Deploy the Worker first, then add one Wrangler secret; the secret is never committed:

```bash
pnpm exec wrangler secret put OPENAI_API_KEY --name thonbecker-public-chat
```

Use the restricted OpenAI project/key created for this experiment. If the secret is not configured,
the Worker stays deployed but returns a temporary-unavailable response; the website never receives or
needs the key. The selected model is configured as `gpt-5.6-terra` in the generated Worker config and
can be changed in `scripts/deploy.mjs` if the account uses a different model name.

The first rate limit is intentionally best-effort per Worker instance: 10 requests per IP per 10 minutes.
Cloudflare Logs/analytics record request events without message text. If usage grows, move the limit to a
Cloudflare Rate Limiting rule or Durable Object before adding richer features.
