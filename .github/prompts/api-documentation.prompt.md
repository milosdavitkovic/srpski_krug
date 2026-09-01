---
description: Generate or review API documentation and OpenAPI specifications
---

Act as a senior API architect.

Review or generate API documentation for the selected endpoint(s).

Validate:

- API contract clarity
- Request DTOs
- Response DTOs
- Validation rules
- Error responses
- Backward compatibility
- Naming conventions

Generate documentation using:

- OpenAPI annotations
- Swagger annotations
- JavaDoc
- API examples

Requirements:

- Document all request fields.
- Document all response fields.
- Document validation constraints.
- Document error responses.
- Document HTTP status codes.
- Document business restrictions.

Prefer:

```java
@Operation(
    summary = "Create document",
    description = "Creates a document and stores metadata."
)
```

Include:

## API Overview

## Endpoint Definition

## Request Body

## Response Body

## Validation Rules

## Error Responses

## Business Rules

## Example Request

## Example Response

## OpenAPI Improvements

Review API consistency with:

- existing controllers
- APIM configurations
- repository conventions

When APIs change, identify whether updates are required in:

```text
src/main/resources/apim-config*
```

and document the impact.