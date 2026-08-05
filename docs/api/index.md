# API Reference

This section documents all available 2BA API endpoints.

## Versioning

The API is versioned via the URL path. The current stable version is **v1**:

```
https://api.2ba.nl/v1/
```

Breaking changes will be released under a new version (e.g., `/v2/`) with a deprecation period for the previous version.

## Request format

- All requests must include `Authorization: Bearer <token>` — see [Authentication](../getting-started/authentication.md)
- Request bodies use `Content-Type: application/json`
- Dates follow [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) (`YYYY-MM-DD` / `YYYY-MM-DDTHH:MM:SSZ`)

## Response format

All responses return JSON. Successful responses use `2xx` status codes. Errors follow this structure:

```json
{
  "error": {
    "code": "RESOURCE_NOT_FOUND",
    "message": "The requested resource could not be found.",
    "details": {}
  }
}
```

## Endpoints

<!-- Add endpoint pages here as the API grows -->
!!! info "Documentation in progress"
    [helpdesk@2ba.nl](mailto:helpdesk@2ba.nl)
