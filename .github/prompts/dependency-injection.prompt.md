---
description: Review and improve dependency injection according to Spring Boot best practices
---

Review the selected code focusing on dependency injection.

Validate:

- constructor-based injection
- immutability of dependencies
- proper use of Lombok @RequiredArgsConstructor
- Spring bean lifecycle compatibility
- testability
- adherence to repository conventions

Identify:

- field injection
- unnecessary injections
- circular dependencies
- hidden coupling
- over-injected services

Preferred style:

```java
@RequiredArgsConstructor
@Service
public class DocumentService {

    private final S3Service s3Service;
    private final KafkaProducer kafkaProducer;

}
```

Avoid:

```java
@Autowired
private S3Service s3Service;
```

Provide:

## Findings

## Recommended Improvements

## Refactored Code

## Test Impact

Follow repository-specific stereotypes and conventions whenever applicable.