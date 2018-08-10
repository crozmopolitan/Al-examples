// example for an Assistant
page 50122 "Example Assistant"
{
    CaptionML = ENU = 'Create Contact', DEU ='Einen Kontakt erfassen';
    PageType = NavigatePage;
    UsageCategory = None;
    SourceTable = "Contact";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(StepInfo)
            {
                Visible=StepInfoVisible;

                usercontrol(StartInfo;"Microsoft.Dynamics.Nav.Client.WebPageViewer")
                {
                    trigger ControlAddInReady(callbackUrl : Text)
                    begin
                        CurrPage.StartInfo.SetContent(myLib.GetInfoText());
                    end;
                }
            }
            group(StepAddress)
            {
                Visible=StepAddressVisible;
                InstructionalTextML = DEU='Hier soll die Adresse eingeben werden.',
                            ENU='Enter the address here.';

            }

            group(StepSummary)
            {
                Visible=StepSummaryVisible;
                usercontrol(Summary;"Microsoft.Dynamics.Nav.Client.WebPageViewer")
                {
                }
            }
        }
    }
actions
{
    area(processing)
    {
        action(ActionCancel)
        {
            ApplicationArea = All;
            CaptionML=ENU = 'Cancel', DEU='Abbrechen';
            Enabled=CancelActionEnabled;
            Visible=CancelActionEnabled;
            Image=Cancel;
            InFooterBar=true;
            trigger OnAction();
            begin
                CurrPage.Close();
            end;
        }
        action(ActionBack)
        {
            ApplicationArea = All;
            CaptionML=ENU = 'Back', DEU='Zurück';
            Enabled=BackActionEnabled;
            Visible=BackActionEnabled;
            Image=PreviousRecord;
            InFooterBar=true;
            trigger OnAction();
            begin
                NextStep(TRUE);
            end;
        }
        action(ActionNext)
        {
            ApplicationArea = All;
            CaptionML=ENU = 'Next', DEU='Weiter';
            Enabled=NextActionEnabled;
            Image=NextRecord;
            InFooterBar=true;
            trigger OnAction();
            begin
                NextStep(FALSE);
            end;
        }
        action(ActionFinish)
        {
            ApplicationArea = All;
            CaptionML=ENU = 'Finish', DEU='Fertigstellen';
            Enabled=FinishActionEnabled;
            Visible=FinishActionEnabled;
            Image=Approve;
            InFooterBar=true;
            trigger OnAction();
            begin
                FinishAction;
            end;
        }
    }
}

trigger OnOpenPage();
var
    RandomString: Code[20];
begin
    Rec.Init();
    Rec."No." := '';
    Rec.Insert();
    ActivatePage(Step::StepInfo);
end;

var
    myLib: Codeunit MyLib;

    Step : Option StepInfo,StepAddress,Finish,ValidateAll;
    StepInfoVisible: Boolean;
    StepAddressVisible : Boolean;
    StepSummaryVisible : Boolean;
    FinishActionEnabled : Boolean;
    BackActionEnabled : Boolean;
    NextActionEnabled : Boolean;
    CancelActionEnabled: Boolean;

local procedure FinishAction();
var
    RecordAction: Option Undefined, Insert, Modify, Delete;
begin
  myLib.CommitToDatabase(RecordAction::Insert, Rec);
  CurrPage.Close();
end;

local procedure NextStep(Backwards : Boolean);
begin
  if (myLib.ValidateStep(Step, Rec)) then
  begin
    if Backwards then
        Step := Step - 1
    else
        Step := Step + 1;
  end;

  ActivatePage(Step);
end;

local procedure ActivatePage(PageNo : Integer);
begin
    Step := PageNo;
    StepInfoVisible := Step = step::StepInfo;
    StepAddressVisible := Step = step::StepAddress;
    StepSummaryVisible := Step = step::Finish;
    BackActionEnabled := PageNo > step::StepInfo;
    NextActionEnabled := PageNo < step::Finish;
    FinishActionEnabled := PageNo = step::Finish;
    CancelActionEnabled := PageNo <= step::StepAddress;

    if (Step = Step::StepAddress) then
    begin

    end;
    if (Step = step::Finish) then
    begin
        // need to set the content here, so that it will be refreshed each time we navigate between the steps
        CurrPage.Summary.SetContent(myLib.GetSummaryText());
    end;
end;


}