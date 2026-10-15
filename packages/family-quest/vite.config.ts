// Vite+ per-package settings. `test` is a task rather than a package.json script, matching the
// other wrapper Workers. See packages/custom-gatekeeper/vite.config.ts.

const ownDist = { pattern: '!dist/**', base: 'package' } as const

const vitestScratch = [
  { pattern: '!**/node_modules/.vite/**', base: 'workspace' },
  { pattern: '!**/node_modules/.vite-temp/**', base: 'workspace' },
  { pattern: '!**/.wrangler/**', base: 'workspace' },
] as const

export default {
  run: {
    tasks: {
      test: {
        command: 'vitest run && node scripts/build-srd.mjs --check',
        cache: {
          input: [{ auto: true }, ownDist, ...vitestScratch],
          output: [{ auto: true }, ownDist, ...vitestScratch],
        },
      },
    },
  },
}
