// Some examples for coding with AL

pageextension 50121 "Customer List Ext." extends "Customer List"
{
    trigger OnOpenPage();
    var myAssistant: Page "Example Assistant";
    begin
        myAssistant.Run();
        error('');
    end;
}