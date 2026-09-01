# Tekton Awareness

Before proposing a change, check that it can pass the repository's Java, Helm, Docker, and Tekton contract validation.
Use `bash bamako-scripts/verify-fast.sh` for the fast path and `bash bamako-scripts/verify-tekton-continuous.sh` for the full local path.

Avoid introducing failing tests, dependency-resolution issues, security findings, invalid chart renders, or Docker packaging mismatches.
