# Authentication

The 2BA API uses **OAuth 2.0 Client Credentials** for machine-to-machine authentication.

## Obtaining an access token

Send a `POST` request to the token endpoint with your credentials:

```http
POST https://auth.2ba.nl/oauth/token
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials
&client_id=YOUR_CLIENT_ID
&client_secret=YOUR_CLIENT_SECRET
```

A successful response returns a bearer token:

```json
{
  "access_token": "eyJ...",
  "token_type": "Bearer",
  "expires_in": 3600
}
```

## Using the token

Include the token in the `Authorization` header of every API request:

```http
GET https://api.2ba.nl/v1/products
Authorization: Bearer eyJ...
```

## Token expiry

Tokens are valid for **1 hour**. Request a new token before it expires or when you receive a `401 Unauthorized` response.

!!! warning "Keep credentials secret"
    Never expose your `client_secret` in client-side code or public repositories.
