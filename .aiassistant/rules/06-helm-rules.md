# Helm Rules

Before proposing chart changes:

- Run `bash bamako-scripts/helm-chart/validate-helm.sh`.
- Confirm `helm lint` and template rendering for test, inte, and prod.
- Prefer values files and external configuration over hardcoded settings.
- Preserve generated secrets-file conventions and the `int` → `inte` chart naming convention.
- Review OpenShift security context, probes, resources, and rollout behavior.
