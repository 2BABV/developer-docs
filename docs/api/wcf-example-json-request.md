# Example: JSON Service Request

You need a valid Access Token before accessing the 2BA web services.

1. **One time:** Acquire the Refresh and Access Token using OAuth2 Flow 1 (Resource Owner Password Credentials Grant) or OAuth2 Flow 2 (Authorization Code). Store the tokens.
2. **Continuously:** Only retrieve a new access token when it has expired, using the Refresh Token service. Store the Access Token.
3. Invoke the desired service, supplying the Access Token in the request header.

## C# code example

```csharp
private void GetProductJson()
{
    var request = (HttpWebRequest)WebRequest.Create(GlobalVariables.ResourceServer + "/json/product/details/" + this.txtGTIN.Text);
    request.Method = "GET";
    request.Headers.Add("Authorization", "Bearer " + _accessToken);
    var response = (HttpWebResponse)request.GetResponse();

    // Use your own preferred JSON parser here.
    XmlReader reader = JsonReaderWriterFactory.CreateJsonReader(response.GetResponseStream(), new XmlDictionaryReaderQuotas());
    var root = XElement.Load(reader);

    // The fields we'd like to extract
    var id = root.XPathSelectElement("//ID");
    var manufacturerGLN = root.XPathSelectElement("//ManufacturerGLN");
    var manufacturerName = root.XPathSelectElement("//ManufacturerName");

    txtId.Text = (id == null) ? null : id.Value;
    txtManufacturerGLN.Text = (manufacturerGLN == null) ? null : manufacturerGLN.Value;
    txtManufacturerName.Text = (manufacturerName == null) ? null : manufacturerName.Value;
}
```
