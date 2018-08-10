codeunit 50121 MyLib
{
    procedure CommitToDatabase(RecordAction: Option Undefined, Insert, Modify, Delete; Rec: Record Contact): Boolean;
    begin
        // TODO
        exit(false);
    end;

    procedure ValidateStep(
        Step: Option StepInfo,StepAddress,Finish,ValidateAll;
        Rec: Record "Contact")
        Valid: boolean;
    begin
        Valid := true;
        // TODO
    end;

    procedure GetHTMLStyle() result: Text;
    begin
        result := '<style> body{   font-family: Tahoma, Times, serif; font-size:12px }'
        + 'h1 { margin-bottom : 2px; margin-top:5px; font-size:14px; font-weight:bold }'
        + 'h2 { margin-bottom : 2px; margin-top:5px; font-size:12px; font-weight:bold }'
        +' div#content{ margin: 10px;} '
        +' div#left{ width: 50%; float:left;} '
        +' div#right{ margin-left: 50%; margin-top:-15px; } '
        + '</style>';
    end;

    procedure GetInfoText() InfoText: Text;
    var
        txtSummary : TextConst DEU='Zusammenfassung', ENU='Summary';
        txtAssistantCaption: TextConst DEU='Der Assistent hilft dir, einen neuen Kontakt anzulegen.', ENU='The assistant will help you to create a new contact.';
        txtAlreadyExists: TextConst DEU='Du solltest bereits geprüft haben, ob der Kontakt bereits angelegt wurde.', ENU='You should have already checked that the contact does not exist yet.';
        txtSteps: TextConst DEU='Folgende Schritte sind durchzuführen', ENU='The following steps are necessary';
        txtHostAddress: TextConst DEU='Adresse', ENU='Address of contact';
    begin
        InfoText := '';
        InfoText += GetHTMLStyle();
        InfoText += '<div class="content"';
        InfoText += '<h1>' + txtAssistantCaption + '</h1><br/>';
        InfoText += txtAlreadyExists + '<br/><br/>';
        InfoText += txtSteps + ':';
        InfoText += '<ol>';
        InfoText += '<li>' + txtHostAddress + '</li>';
        InfoText += '<li>' + txtSummary + '</li>';
        InfoText += '</ol>';
        InfoText += '</div>';
    end;

    procedure GetSummaryText() summary : Text;
    var
        txtSummary : TextConst DEU='Zusammenfassung', ENU='Summary';
        txtVerify: TextConst DEU='Bitte prüfe die Daten bevor du speicherst.', ENU='Please verify the data before saving.';
    begin
        summary := '';
        summary += GetHTMLStyle();
        summary += '<div class="content"';
        summary += '<h1>' + txtSummary + '</h1><br/><i>' + txtVerify + '</i><br><br> ' +'<div id=left>';
        summary += '</div>';
        summary += '</div>';
    end;
}