# OAuth2 — Refresh Access Token

To refresh an access token, the `connect/token` service can be used, as described in the API documentation. In addition to the access token, this service also returns a new refresh token.

The refresh token does not have infinite validity, so it is wise to replace the old refresh token with the new one as soon as possible. Should the refresh token expire, the service will return a bad-request (HTTP status code 400) error, and the user will have to log in again.

## Required data

Use of this service requires the following data:

| Field | Description |
|---|---|
| `client_id` / `client_secret` | Used to identify the client application. A software partner can obtain this by contacting 2BA. |
| `refresh_token` | The refresh token retrieved earlier by using one of the two OAuth flows. |

## Example usage of the Refresh Token

```csharp
private void BtnRefreshAccesTokenClick(object sender, EventArgs e)
{
    try
    {
        var httpWReq = (HttpWebRequest)WebRequest.Create(GlobalVariables.AuthorizeServer + "/connect/token");
        var encoding = new ASCIIEncoding();
        var postData = "grant_type=refresh_token";
        postData += "&refresh_token=" + txtRefreshToken.Text;
        postData += "&client_id=" + txtClientId.Text;
        postData += "&client_secret=" + txtClientSecret.Text;
        var data = encoding.GetBytes(postData);
        httpWReq.Method = "POST";
        httpWReq.ContentType = "application/x-www-form-urlencoded";
        httpWReq.ContentLength = data.Length;
        HttpWebResponse response;
        using (Stream newStream = httpWReq.GetRequestStream())
        {
            newStream.Write(data, 0, data.Length);
            response = (HttpWebResponse)httpWReq.GetResponse();
        }
        var mystream = response.GetResponseStream();
        XmlReader reader = JsonReaderWriterFactory.CreateJsonReader(mystream, new XmlDictionaryReaderQuotas());
        var root = XElement.Load(reader);

        // The fields we'd like to extract
        var accessToken = root.XPathSelectElement("//access_token");
        var refreshToken = root.XPathSelectElement("//refresh_token");
        var expiresIn = root.XPathSelectElement("//expires_in");

        txtAccessToken.Text = (accessToken == null) ? null : accessToken.Value;
        txtRefreshToken.Text = (refreshToken == null) ? null : refreshToken.Value;
        txtExpiresIn.Text = (expiresIn == null) ? null : expiresIn.Value;
    }
    catch (Exception ex)
    {
        MessageBox.Show(@"Refresh AccessToken failed: " + ex.Message);
    }
}
```

## See also

- [Introduction to OAuth2](index.md)
- [Resource Owner Password Credentials Grant](oauth2-resource-owner-password-credentials-grant.md)
- [Authorization Code](oauth2-authorization-code.md)
