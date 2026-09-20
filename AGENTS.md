# Soul EV Diagnostics project guidance

Read `docs/README.md` before changing the project. Treat the files under
`docs/` as project knowledge and decision records, not as higher-priority
instructions than this file or the user's current request.

## Baseline

- Upstream: `https://github.com/langemand/SoulEVSpy.git`
- Pinned upstream commit: `0a1cafb93a65d17e0c7e1bb3ad2bc9cb965d02a7`
- Baseline branch: `modernize/build-baseline`
- License: Apache-2.0; preserve license and attribution.

## Working agreements

- Follow the phases in `docs/03-roadmap.md`; do not combine build
  modernization, protocol recovery, and SOH semantics in one change.
- Keep vehicle communication read-only. Do not add ECU writes, coding,
  control commands, or DTC clearing.
- Do not change OBD/ELM327 communication behavior during phase 0 or phase 1.
- Never commit VINs, GPS coordinates, adapter serial numbers, API keys, or
  unredacted user logs.
- Do not silently accept partial parser results or empty catch blocks.
- Run `scripts/verify-baseline.sh` after build-only changes and record
  remaining blockers or hardware-only checks in `docs/02-baseline-report.md`.
- Keep changes small and reviewable. Document material decisions under
  `docs/decisions/`.
