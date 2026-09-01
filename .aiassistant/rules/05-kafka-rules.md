# Kafka Rules

When changing producers or message handling, verify:

- Message schema and backward compatibility
- Environment-specific topic configuration
- Retry and failure behavior
- Logging and operational visibility

Never silently swallow exceptions. Failed processing must be logged with enough context to identify the request and flow.
