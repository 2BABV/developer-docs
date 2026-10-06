# OAuth2 — Resource Owner Password Credentials Grant

All credentials (`client_id`/`client_secret` and `username`/`password`) are transmitted across a secure connection (HTTPS) to the 2BA Authorization Server. In response, the application receives an **Access Token** and a **Refresh Token**.

- The **Access Token** has limited validity and must be refreshed once expired.
- The **Refresh Token**, in principle, has unlimited validity and is only used across the secure connection to the 2BA Authorization Server.

With the Access Token, 2BA services can be invoked. Based on the Access Token, 2BA determines which application and user is accessing the service, and the appropriate rights. When the Access Token expires, the application uses the Refresh Token to request a new Access Token from the Authorization Server.

## Required data

To use the `connect/token` service, the following data is required:

| Field | Description |
|---|---|
| `client_id` / `client_secret` | Required to identify the client application. A software partner can obtain this by contacting 2BA. |
| `username` / `password` | Required to identify the end user on behalf of which the application makes the request. Further authorization is based on the user's rights. A user can obtain a username and password by contacting 2BA. |

## Example: Authentication (request Access Token and Refresh Token)

```csharp
using System.Runtime.Serialization.Json;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;

private void BtnLoginClick(object sender, System.EventArgs e)
{
    try
    {
        var httpWReq = (HttpWebRequest)WebRequest.Create(GlobalVariables.AuthorizeServer + "/connect/token");
        var encoding = new ASCIIEncoding();
        string postData = "grant_type=password";
        postData += "&username=" + txtUsername.Text;
        postData += "&password=" + txtPassword.Text;
        postData += "&client_id=" + txtClientId.Text;
        postData += "&client_secret=" + txtClientSecret.Text;
        byte[] data = encoding.GetBytes(postData);
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
        MessageBox.Show(@"Login failed: " + ex.Message);
    }
}
```

## See also

- [Introduction to OAuth2](index.md)
- [Refresh Access Token](oauth2-refresh-access-token.md)
- [Authorization Code](oauth2-authorization-code.md)
