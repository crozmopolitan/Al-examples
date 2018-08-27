page 50130 "Http Request Card"
{
    PageType = Card;
    SourceTable = "Contact";

    // set our own page caption
    DataCaptionExpression = 'Test HTTP Requests';

    layout
    {
        area(content)
        {
            group(GroupName)
            {
                field(test;test)
                {
                   MultiLine = true; 
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Webpage")
            {
                trigger OnAction();
                begin
                    test := HttpRequestsLib.LoadWebpage('https://kontocheck.solidcharity.com');
                end;
            }

            action("Get Webpage with GET parameters")
            {
                trigger OnAction();
                begin
                    test := HttpRequestsLib.LoadWebpage('https://kontocheck.solidcharity.com/index.php?kto=648489890&blz=50010517');
                end;
            }

            action("Get Webpage with POST parameters")
            {
                trigger OnAction();
                var
                    post_names: List of [Text];
                    post_values: List of [Text];
                begin
                    post_names.Add('test1');
                    post_values.Add('1111');
                    post_names.Add('test2');
                    post_values.Add('2222');
                    test := HttpRequestsLib.PostRequest(
                        'https://al-examples.solidcharity.com/post.php?get1=4711&get2=0815',
                        post_names,
                        post_values);
                end;
            }

            action("Consume Web Service with Basic Authentication")
            {
                trigger OnAction();
                var
                    post_names: List of [Text];
                    post_values: List of [Text];
                begin
                    post_names.Add('test1');
                    post_values.Add('1111');
                    post_names.Add('test2');
                    post_values.Add('2222');
                    test := HttpRequestsLib.PostRequestWithBasicAuth(
                        'https://al-examples.solidcharity.com/protected/post.php?get1=4711&get2=0815',
                        post_names,
                        post_values,
                        'myusername',
                        'topsecret');
                end;
            }
        }
    }
    
    var
        test : Text;
        HttpRequestsLib: Codeunit HttpRequest;
}