---
description: Review and improve error handling strategy
---

Act as a senior Spring Boot engineer.

Analyse the selected code for error handling.

Review:

- exception propagation
- exception translation
- REST error responses
- Kafka consumer failures
- batch processing failures
- AWS/S3 communication failures
- validation failures
- configuration errors

Validate:

- meaningful exception types
- proper logging
- retry behaviour
- recoverability
- user-facing error messages

Prefer:

- custom business exceptions
- centralized exception handling
- @RestControllerAdvice
- structured error responses

Avoid:

- catching Exception
- swallowed exceptions
- duplicated try/catch blocks
- logging and rethrowing identical exceptions

Provide:

## Current Issues

## Risks

## Recommended Exceptions

## Error Flow

## Refactored Example

## Additional Tests

Repository-specific rules:

- do not expose stack traces
- do not leak configuration details
- preserve existing exception hierarchy