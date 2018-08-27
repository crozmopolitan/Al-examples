codeunit 50131 HttpRequest
{
    procedure LoadWebpage(url: Text) result: Text;
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
    begin
        result := 'error';
        if(Client.Get(url, Response)) then
        begin
            if (Response.IsSuccessStatusCode) then
            begin
                Response.Content.ReadAs(result);
            end
            else
            begin
                message('HTTP Status Code ' + Format(Response.HttpStatusCode));
            end
        end
        else
        begin
            message('HTTP Error ' + Format(Response.HttpStatusCode));
        end;
    end;

    procedure PostRequest(url: Text; post_names: List of [Text]; post_values: List of [Text]) result: Text;
    var
        Client: HttpClient;
        ContentHeaders: HttpHeaders;
        Content: HttpContent;
        Response: HttpResponseMessage;
        i: Integer;
        PostValues: Text;
    begin
        result := 'error';
        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');
        PostValues := '';
        for i := 1 to post_names.Count do
        begin
            PostValues += post_names.Get(i) + '=' + post_values.Get(i) + '&';
        end;
        Content.WriteFrom(PostValues);
        if(Client.Post(url, Content, Response)) then
        begin
            if (Response.IsSuccessStatusCode) then
            begin
                Response.Content.ReadAs(result);
            end
            else
            begin
                message('HTTP Status Code ' + Format(Response.HttpStatusCode));
            end
        end
        else
        begin
            message('HTTP Error ' + Format(Response.HttpStatusCode));
        end;
    end;

    procedure PostRequestWithBasicAuth(
        url: Text;
        post_names: List of [Text];
        post_values: List of [Text];
        username: Text;
        password: Text) result: Text;
    var
        Client: HttpClient;
        ContentHeaders: HttpHeaders;
        Content: HttpContent;
        Response: HttpResponseMessage;
        i: Integer;
        PostValues: Text;
        TempBlob: Record TempBlob temporary;
    begin
        result := 'error';
        TempBlob.WriteAsText(username + ':' + password,TextEncoding::Windows);
        Client.DefaultRequestHeaders.Add('Authorization', 'Basic ' + TempBlob.ToBase64String());

        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');
        PostValues := '';
        for i := 1 to post_names.Count do
        begin
            PostValues += post_names.Get(i) + '=' + post_values.Get(i) + '&';
        end;
        Content.WriteFrom(PostValues);
        if(Client.Post(url, Content, Response)) then
        begin
            if (Response.IsSuccessStatusCode) then
            begin
                Response.Content.ReadAs(result);
            end
            else
            begin
                message('HTTP Status Code ' + Format(Response.HttpStatusCode));
            end
        end
        else
        begin
            message('HTTP Error ' + Format(Response.HttpStatusCode));
        end;
    end;
}