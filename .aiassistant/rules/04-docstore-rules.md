# Document Storage Rules

Before changing storage or document-processing logic, trace and verify:

1. Upload and retrieval paths
2. Metadata persistence
3. Hot-folder and generated-artifact handling
4. Audit logging and failure cleanup

Generated operations must be idempotent. Do not introduce duplicate uploads, Kafka sends, or hot-folder artifacts.
Preserve the distinction between internal and external S3 services.
