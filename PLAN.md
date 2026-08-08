# Cloudflare OS Migration Plan

## Goal

Run a private AI workspace on Cloudflare Workers for personal-website operations while keeping the existing Spring Boot application on Lightsail as the source of truth.

## Target architecture

```text
os.thonbecker.biz
  Cloudflare OS Workshop + Access
        |
        `--> Custom Gatekeeper Worker
                |
                `--> authenticated HTTPS admin API
                        |
                        `--> personal-website on Lightsail
                                |
                                `--> RDS, S3, MediaConvert, OpenAI, Nextcloud
```

Cloudflare OS will not replace the personal-website container, Docker Compose, ECR, RDS, or AWS media-processing services.

## Phase 1 — Deploy the workspace

- [ ] Create a private GitHub repository named `cloudflare-os-personal`.
- [ ] Use `cloudflare-os-starter` as the deployment wrapper.
- [ ] Pin the upstream Cloudflare OS submodule to a reviewed commit.
- [ ] Configure the Cloudflare account ID and Worker names in `deployment.jsonc`.
- [ ] Create a Cloudflare Access application for `os.thonbecker.biz`.
- [ ] Deploy with `pnpm check` and `pnpm deploy`.
- [ ] Confirm login, `/admin`, KV, R2, and Worker logs.

## Phase 2 — Define a safe personal-website API

Add a narrow, read-only API to the Spring Boot application:

- `GET /api/assistant/bookings`
- `GET /api/assistant/booking-conflicts`
- `GET /api/assistant/video-processing/{id}`

Requirements:

- Authenticate with a dedicated service credential.
- Return only the fields needed by the assistant.
- Do not expose database credentials, AWS credentials, or arbitrary URL execution.
- Log every request with the calling capability and resource ID.

## Phase 3 — Build the custom Gatekeeper

- [ ] Start from the starter's custom Gatekeeper package.
- [ ] Implement booking and video-status read operations.
- [ ] Add request validation, time-range limits, and user authorization.
- [ ] Deploy the Gatekeeper before enabling it in Cloudflare OS.
- [ ] Verify that observations appear in Worker logs.

## Phase 4 — First gadget

Build a private booking operations gadget that can:

- List upcoming bookings.
- Identify schedule conflicts.
- Draft customer replies.

Keep all actions read-only at first. Do not add cancellation, payment, publishing, or deployment mutations until the read path is proven.

## Phase 5 — Add approved side effects

Add one operation at a time, each with explicit approval:

- [ ] Create or update a booking.
- [ ] Send a customer email.
- [ ] Approve skateboard video publication.
- [ ] Trigger a deployment.

The Gatekeeper must record the proposed action, affected resource, user, timestamp, and final approval or rejection.

## Phase 6 — CI/CD

- [ ] Store the Cloudflare API token in GitHub Actions secrets.
- [ ] Run `pnpm check` on pull requests.
- [ ] Run `pnpm deploy` only from `main`.
- [ ] Keep personal-website deployment in its existing Lightsail workflow.
- [ ] Pin and review Cloudflare OS upgrades before changing the submodule.
- [ ] Keep a rollback procedure using Worker deployment history.

## Cutover strategy

There is no immediate production cutover. The existing application remains live throughout:

1. Deploy Cloudflare OS separately.
2. Add read-only API endpoints.
3. Connect the Gatekeeper.
4. Test with real data in a private Access-protected workspace.
5. Add approved mutations gradually.
6. Keep the personal website as the business-logic authority.

## Security boundaries

- Cloudflare OS receives no AWS access keys.
- The Gatekeeper receives only the dedicated personal-website API credential.
- The personal website continues to own RDS, S3, MediaConvert, OpenAI, and Nextcloud integrations.
- Public customers never access the Cloudflare OS hostname.
- Cloudflare OS is treated as early-access software; review upgrades before deployment.
