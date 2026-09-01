# GitHub Copilot Instructions

## Purpose

Use these instructions for all Copilot-assisted work in this repository.

Optimize for:

- Small, safe, repository-aligned changes
- Maintainability
- Production readiness
- Testability
- Security
- Consistency with existing implementation

---

# Scope

This repository is a:

- Java 21 application
- Spring Boot 3.x service
- Maven-based project
- OpenShift/Kubernetes deployed workload
- Kafka-integrated solution
- SAP Marketing ecosystem component

Always prefer existing repository patterns over generic Spring Boot examples.

---

# Repository Architecture

Current package responsibilities:

| Package | Responsibility |
|----------|--------------|
| occ | REST controllers |
| facade | Orchestration and DTO mapping |
| core | Business services |
| core/service | Domain services |
| core/config | Spring configuration |
| core/batch | Batch processing |
| core/service/aws | AWS integrations |
| core/service/kafka | Kafka integrations |

Typical request flow:

```text
Controller
  ↓
Facade
  ↓
Service
  ↓
Repository / External System
```

Current DocStore flow:

```text
Controller
  →
DefaultHtaPlusFacade
  →
DefaultDocStoreFacade
  →
PDF/S3/Kafka Services
```

Do not bypass this architecture without explicit justification.

---

# MUST DO

## Code Changes

Prefer:

- Existing patterns
- Existing helper classes
- Existing interfaces
- Existing naming conventions
- Smallest relevant change

Before introducing a new class:

1. Search for an existing implementation.
2. Search in sibling packages.
3. Reuse repository standards.

---

## Dependency Injection

Use constructor injection only.

Preferred:

```java
@RequiredArgsConstructor
@Service
public class DocumentService {
    private final S3Service s3Service;
}
```

Avoid:

```java
@Autowired
private S3Service s3Service;
```

---

## Spring Components

Use existing repository stereotypes when applicable:

```java
@Facade
@UtilClass
@Properties
```

Do not replace existing stereotypes with standard Spring annotations without reason.

---

## Controller Design

Controllers must remain thin.

Controllers should:

- Accept requests
- Validate input
- Call facades/services
- Return responses

Controllers should NOT:

- Contain business logic
- Call repositories directly
- Implement orchestration

---

## Configuration

Prefer:

```java
@ConfigurationProperties
```

over:

```java
@Value
```

Follow existing profile handling:

```properties
spring.profiles.active=${STAGE}
```

Use:

- application.properties
- application-local.properties
- application-test.properties
- existing project convention

Never hardcode:

- URLs
- Bucket names
- Secrets
- Kafka brokers
- Environment names

---

# Logging

Use:

```java
private static final Logger LOG =
        LoggerFactory.getLogger(CurrentClass.class);
```

Use parameterized logging:

```java
LOG.info("Processing document {}", documentId);
```

Avoid:

```java
LOG.info("Processing document " + documentId);
```

Never log:

- Passwords
- Tokens
- Credentials
- Personal data
- Full document content

---

# Kafka Standards

When generating Kafka code:

- Use strongly typed DTOs
- Use existing topic configuration patterns
- Preserve correlation IDs
- Handle deserialization failures
- Implement proper error handling
- Respect retry strategy already present

Preferred flow:

```text
Producer
  →
Kafka Topic
  →
Consumer
  →
Facade
  →
Service
```

Do not introduce incompatible message formats.

---

# AWS and S3

Prefer AWS SDK v2.

Use existing implementations inside:

```text
core/service/aws/s3
```

Do not mix:

- AWS SDK v1
- AWS SDK v2

within the same implementation.

---

# Batch Processing

When changing batch functionality:

Review:

```text
HtaPlusBatchConfig
pdfSaveV3Job
```

Respect the existing job parameter limitation workaround:

```text
~2450 character payload limit
```

Before introducing async processing:

```java
SystemService.canCreateThreadSafely()
```

must be considered.

---

# REST API Standards

Follow REST conventions.

Use:

- Request DTOs
- Response DTOs
- Validation annotations
- Meaningful endpoint names

Example:

```java
@PostMapping
@ResponseStatus(HttpStatus.CREATED)
public DocumentResponse create(
        @Valid @RequestBody CreateDocumentRequest request) {
    return service.create(request);
}
```

Return appropriate status codes.

Do not expose stack traces.

---

# Exception Handling

Prefer centralized exception handling.

Use:

```java
@RestControllerAdvice
```

Generate structured error responses.

Avoid duplicate try/catch blocks.

---

# Testing

Use:

- JUnit 5
- Spring Boot Test
- Mockito
- AssertJ

For every new feature generate:

### Unit Tests

Validate:

- Happy path
- Validation failures
- Exception scenarios

### Integration Tests

Validate:

- REST endpoints
- Spring configuration
- Kafka integration where applicable

Prefer extending existing test patterns.

---

# OpenShift / Kubernetes Standards

Generated deployment changes should:

- Use readiness probes
- Use liveness probes
- Respect resource requests
- Respect resource limits
- Use environment variables
- Use ConfigMaps
- Use Secrets

Never hardcode:

- Namespace names
- Cluster-specific URLs
- Resource values

---

# APIM

APIM configuration is located in:

```text
src/main/resources/apim-config*
```

Whenever:

- APIs change
- DTO contracts change
- Paths change

review APIM configuration impact.

---

# Security

Apply OWASP secure coding principles.

Always:

- Validate external input
- Sanitize uploaded content
- Avoid unsafe deserialization
- Handle secrets securely

Never:

- Hardcode credentials
- Store secrets in code
- Disable security checks

---

# Decision Rules

When generating code:

1. Follow existing implementation.
2. Follow the nearest existing example.
3. Prefer consistency over innovation.
4. Prefer maintainability over clever solutions.
5. Prefer repository standards over generic Spring examples.

If required information is missing:

- Stop
- Explain what is missing
- Do not guess

---

# Build and Validation

Always use Maven Wrapper.

Examples:

```bash
./mvnw clean package
```

Windows:

```bash
./mvnw.cmd clean package
```

Local startup:

```bash
./mvnw spring-boot:run -DSTAGE=local
```

Validate only the impacted area whenever possible.

---

# Documentation

When generating code:

- Add JavaDoc for public APIs
- Explain non-obvious business logic
- Document integration assumptions

Use project documentation standards.

---

# Delegation

Use specialized repository tooling when appropriate:

- bamako-documentation
- bamako-unit-test
- bamako-script
- bamako-helm-chart
- bamako-helm-lint
- bamako-k8s-review
- bamako-argocd

---

# Output Expectations

Copilot responses should:

- Be concise
- Be implementation-oriented
- Reference exact files and paths
- Minimize changes
- Preserve existing architecture

Always generate production-ready code aligned with repository conventions.