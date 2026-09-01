# AWS S3 Rules

Documents in S3 are business-critical. When changing S3 code:

- Preserve bucket and object-key structure.
- Preserve metadata, retention, and lifecycle behavior.
- Verify upload, download, delete, and retention handling.
- Use the AWS SDK v2 services already used by `core/service/aws/s3`.
- Keep test, inte, and prod configuration externalized.
- Never hardcode credentials, bucket names, or account-specific endpoints.
