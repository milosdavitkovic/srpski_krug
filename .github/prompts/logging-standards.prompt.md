---
description: Review logging quality and repository logging standards
---

Act as a senior production-support engineer.

Review all logging statements.

Validate:

- log level correctness
- message quality
- structured logging
- observability
- troubleshooting usefulness

Preferred logging style:

```java
LOG.info("Processing document {}", documentId);
```

Avoid:

```java
LOG.info("Processing document " + documentId);
```

Validate:

- INFO for business milestones
- DEBUG for technical diagnostics
- WARN for recoverable problems
- ERROR for failed processing

Never log:

- passwords
- tokens
- certificates
- credentials
- personal data
- full document contents

Review for:

- excessive logging
- missing logging
- duplicate logging
- poor message wording

Provide:

## Current Logging Assessment

## Missing Logs

## Incorrect Log Levels

## Security Concerns

## Refactored Logging

## Observability Improvements

When proposing logs include:

- correlationId
- messageId
- documentId
- processing duration

where applicable.