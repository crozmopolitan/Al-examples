// Test for FlowFields and Option

page 50111 "Test"
{
    PageType = List;
    SourceTable = "MyTestData";
    UsageCategory = Lists;
    ApplicationArea = All;
    CaptionML = DEU='Data Test',
                ENU='Data Test';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                }
                field("Type";Rec."Type")
                {
                }
                field(StatusOption; Rec.StatusOption)
                {
                }
            }
        }
    }
}