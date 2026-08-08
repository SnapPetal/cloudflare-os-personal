# Personal Cloudflare OS

This repository will deploy a private Cloudflare OS workspace for operating the personal website and related services.

## What this is

Cloudflare OS runs on Cloudflare Workers and provides the private AI workspace. It is separate from the Spring Boot application, which continues to run on Lightsail.

## Current status

This repository currently contains the migration and integration plan only. The Cloudflare OS starter will be added in the next step after the Cloudflare account and Access hostname are confirmed.

Read [PLAN.md](PLAN.md) for the staged rollout.

## Intended deployment

```text
os.thonbecker.biz
  Cloudflare OS + Cloudflare Access
        |
        `--> custom Gatekeeper Worker
                |
                `--> authenticated personal-website API on Lightsail
```

The deployment will use Wrangler and Cloudflare resources such as Workers, KV, and R2. It will not use Docker or ECR.

## First implementation target

Create a read-only booking assistant that can list upcoming bookings and identify conflicts. Mutating actions will be added only after the read-only integration is working.
