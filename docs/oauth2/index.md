# Introduction to OAuth2

For the security of our products (**Unifeed**, **Webservices**, and other 2BA APIs), we use the open standard OAuth2. The OAuth2 standard is a widely accepted standard used by many software parties, with an abundance of libraries available.

With the OAuth2 authorization protocol, third-party applications can acquire limited access to our HTTP services. To access these services, the application needs client credentials (`client_id`/`client_secret`). To gain access to the data, the user additionally needs to be identified by their username and password.

More complete information about the OAuth2 specification can be found at the [OAuth2 website](http://oauth.net/2/){ target=_blank }.

!!! info "Shared across 2BA products"
    This identity/authorization layer is not specific to a single API — it secures the 2BA WCF API, Unifeed, and other services. Acquire your tokens once and reuse them across the services you are authorized for.

## Supported authorization flows

2BA supports 2 authorization flows from the OAuth spec:

- [Resource Owner Password Credentials Grant](oauth2-resource-owner-password-credentials-grant.md)
- [Authorization Code](oauth2-authorization-code.md)

### Steps

1. Choose one of the supported flows — pick the flow that best matches your situation.
2. Use the chosen flow to retrieve the Access Token / Refresh Token (one time).
3. Refresh the Access Token, if expired, using the Refresh Token.
4. Invoke the desired JSON service or Unifeed, providing the Access Token.

### Resource Owner Password Credentials Grant

Use this flow when there is a trusted relation between the application and the end user — for example, when the application is installed on the end user's computer. The end user enters their username and password directly in the application.

See [Resource Owner Password Credentials Grant](oauth2-resource-owner-password-credentials-grant.md) for details and example code.

### Authorization Code

Use this flow when there is no trusted relation between the application and the end user — for example, when the application resides on the internet. The user does **not** enter their 2BA credentials in a third-party application. Instead, the application redirects the user to the 2BA website, where the user enters their credentials, and 2BA returns an authorization code to the third-party application.

See [Authorization Code](oauth2-authorization-code.md) for details and example code.

## Parameters

| Parameter | Value |
|---|---|
| Authorization URL | `https://authorize.2ba.nl/connect/token` (the legacy `OAuth/Token` endpoint is also still supported) |
| client_id / client_secret | As received from 2BA |

## Examples

- [Resource Owner Password Credentials Grant](oauth2-resource-owner-password-credentials-grant.md)
- [Authorization Code](oauth2-authorization-code.md)
- [Refresh Access Token](oauth2-refresh-access-token.md)
