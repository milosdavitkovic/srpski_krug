# S3 Rules

- Use the existing AWS SDK v2 abstractions under `core/service/aws/s3`; do not mix SDK v1 and v2 in new code.
- Preserve the intentional internal/external bucket split, key structure, metadata, expiry, copy behavior, and print/PDF semantics.
- Keep SDK calls out of controllers, facades, and domain-style logic; use the existing S3 service interfaces.
- Use IAM roles and externalized stage configuration. Never hardcode credentials, bucket names, account IDs, or endpoints.
- Encrypt objects, use secure transport, and preserve configured versioning/lifecycle/retention policies.
- Handle transient failures with bounded, configured retries and make uploads/copies safe for retries.
- Validate object keys and content metadata. Do not use raw client filenames as keys.
- Test internal and external paths separately, including presigned URL expiry and failure cleanup.

✅ Good

```java
public interface AwsS3UploadService {
    UploadResult upload(UploadDocument document);
}

@RequiredArgsConstructor
class DefaultPdfFacade {
    private final AwsS3UploadService uploadService;
}
```

❌ Bad

```java
@Service
class DocumentService {
    private final S3Client s3Client;

    void upload(String fileName, RequestBody body) {
        s3Client.putObject(requestFor(fileName), body);
    }
}
```

