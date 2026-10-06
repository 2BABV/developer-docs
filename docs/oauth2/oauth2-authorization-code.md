# OAuth2 — Authorization Code

The code examples below are C# code without making use of any specific OAuth library.

## Authorization Code flow

The OAuth2 "authorization code flow" has the advantage that the client application does not have to store the 2BA user's credentials. A coupling is established once per user, via the 2BA login page.

This process takes the following steps:

1. The application opens an (embedded) browser and navigates to the 2BA authorization server (<https://authorize.2ba.nl/>). This request contains the following parameters:

    | Field | Description |
    |---|---|
    | `response_type=code` | Specifies that the authorization server should return an authorization code. |
    | `client_id` | Used to identify the client application. A software partner can obtain this by contacting 2BA. |
    | `redirect_uri` | The URL to navigate to once the login procedure has completed. Required, and must conform to the http(s) scheme (e.g. `https://www.2ba.nl`). Can also be `localhost` (e.g. `http://localhost:8080`). This URL must be registered under your 2BA ClientId — send us an email with all needed `redirect_uri`s. |

    ```csharp
    var url = new Uri(string.Format("{0}/OAuth/Authorize?response_type=code&client_id={1}&redirect_uri={0}",
        Properties.Settings.Default.AuthorizeUrl,
        Globals.ClientId));
    this.WebBrowser1.Navigate(url);
    ```

2. The user enters their credentials using the login page.

3. Navigation returns to the URL specified by `redirect_uri` with the parameter `?code={authorization_code}`. This response can be parsed, for example:

    ```csharp
    private void WebBrowser1_Navigated(object sender, WebBrowserNavigatedEventArgs e)
    {
        // Look for the authorization code field
        const string SearchCondition = "/?code=";
        if (e.Url.PathAndQuery.StartsWith(SearchCondition))
        {
            var queryString = string.Join(string.Empty, e.Url.AbsoluteUri.Split('?').Skip(1));
            var parsedQuery = HttpUtility.ParseQueryString(queryString);
            this.Authorization_Code = parsedQuery["code"];
            this.DialogResult = DialogResult.OK;
            this.Close();
        }
    }
    ```

4. The token service (`connect/token`) is then invoked with a `grant_type` of `authorization_code` and the `code` parameter set to the authorization code retrieved earlier:

    ```csharp
    public static OAuthTokenResponse GetAccessToken(string authorizationCode)
    {
        var postData = "grant_type=authorization_code";
        postData += "&code=" + authorizationCode;
        postData += "&redirect_uri=" + Globals.RedirectUri;
        postData += "&client_id=" + Globals.ClientId;
        postData += "&client_secret=" + Globals.ClientSecret;

        // POST postData to {AuthorizeServer}/connect/token and parse the
        // access_token / refresh_token / expires_in fields from the JSON response.
    }
    ```

## See also

- [Introduction to OAuth2](index.md)
- [Resource Owner Password Credentials Grant](oauth2-resource-owner-password-credentials-grant.md)
- [Refresh Access Token](oauth2-refresh-access-token.md)
