# Introduction — 2BA WCF API Webservices

The 2BA Webservices are elementary, lightweight and fast services to allow your systems to integrate with the 2BA database. We offer services to search our database, retrieve product or article details, and services to, for example, download your selection profiles automatically.

Our webservice is not intended for bulk downloads — it is intended to update a targeted number of articles quickly. For bulk downloads we recommend direct downloads or the use of 2BA selection profiles.

## Access

An application (the client) wishing to communicate with the services requires a `ClientId` and accompanying `ClientSecret`. Each application requires its own `ClientId`. The `ClientId` and secret of the application are used in conjunction with the username and password during authentication. With the `ClientId` name we can identify the application or organisation who uses our webservices. Your software might already have a `ClientId` and secret in use — please contact your software partner.

If you want to use Webservices you will need a `ClientId`/secret and a 2BA username/password.

Are you a software developer and not yet registered with 2BA? [Register with 2BA](https://www.2ba.nl/en/about-2ba/what-does-2ba-offer/for-software-suppliers/register/){ target=_blank }. After you register, we can send you a letter of intent, which, when signed and received by us, the `ClientId` and `ClientSecret` can be requested.

Registered 2BA clients can request a `ClientId` and `ClientSecret` for use with the 2BA webservice via this [form](https://www.2ba.nl/en/documentation/request-clientid-and-clientsecret-for-use-with-2ba-web-service/){ target=_blank }.

## Security

To secure our Webservices, we use the [open standard OAuth2](../oauth2/index.md). In a nutshell, this means that a previously acquired "accesstoken" is sent in an HTTP header when invoking the service. The authentication can be built manually, but there are plenty of libraries available for this purpose.

!!! note
    OAuth2 / identity is shared across 2BA products (not just the WCF API). See the [OAuth2 / Identity](../oauth2/index.md) section for the full introduction and flow examples.

View the code examples for authorizing and invoking the Webservices:

- [Example 1: Resource Owner Password Credentials Grant](../oauth2/oauth2-resource-owner-password-credentials-grant.md)
- [Example 2: Authorization Code](../oauth2/oauth2-authorization-code.md)

## Structure

The structure of a service URL is:

```
http(s)://api.2ba.nl/<major versionnumber>/<protocol>/<servicename>
```

## Further resources

- [API Version 1 (Swagger)](https://api.2ba.nl/1/docs/index.html?url=/1/docs/swagger.json){ target=_blank }
- [Error codes](wcf-error-codes.md)
- [JSON service request example](wcf-example-json-request.md)
- [Information for suppliers](https://www.2ba.nl/documentatie/webservices/information-for-suppliers/){ target=_blank }
- [Reference architecture](https://www.2ba.nl/documentatie/webservices/reference-architecture/){ target=_blank }
- [Changelog](https://www.2ba.nl/documentatie/webservices/changelog/){ target=_blank }
