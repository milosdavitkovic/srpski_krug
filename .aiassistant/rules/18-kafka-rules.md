# Kafka Rules

- Kafka is producer-only here. Keep facade mapping in `facade.kafka` and Spring Kafka/template details in `core.service.kafka`.
- Preserve the configured topic, payload shape, correlation ID, SAP outbound ID, and backward compatibility.
- Treat event payloads as immutable after mapping; prefer stable DTOs/records where compatible with existing serialization.
- Use business-language event/payload names and explicit schema/version evolution. Do not rename fields or change types without a compatibility plan.
- Define duplicate-send/idempotency behavior and preserve the existing timeout, retry, and failure handling.
- Log safe send metadata such as topic, partition, offset, timestamp, and correlation context; never log the full payload.
- Respect conservative executor and batch settings; do not add unbounded parallel sends.

✅ Good

```java
public record PdfReadyEvent(
        String schemaVersion,
        String correlationId,
        String outboundId,
        String documentUrl) {
}
```

❌ Bad

```java
@Data
class StoreDocumentKafkaMessage {
    private Map<String, Object> payload;
    private String accessToken;
}
```

