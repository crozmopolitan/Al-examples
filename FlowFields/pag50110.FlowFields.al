// Test for FlowFields and Option

page 50110 "Test FlowFields"
{
    PageType = List;
    SourceTable = "MyTableFlowFieldTest";
    UsageCategory = Lists;
    ApplicationArea = All;
    CaptionML = DEU='FlowField Test',
                ENU='FlowField Test';

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
                field(OptionFlowField; Rec.OptionFF)
                {
                }

                field(DateFlowField; Rec.DateFF)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateTestData)
            {
                Promoted = true;
                PromotedCategory = New;
                trigger OnAction();
                var
                    testRec: Record MyTestData;
                    flowRec: Record MyTableFlowFieldTest;
                    i: Integer;
                begin
                    for i := 1 to 5 do
                    begin
                        Clear(testRec);
                        testRec."No." := format(i);
                        testRec.Type := 'TEST';
                        case i of
                            1: testRec.StatusOption := testRec.StatusOption::Test1;
                            2: testRec.StatusOption := testRec.StatusOption::Test2;
                            3: testRec.StatusOption := testRec.StatusOption::Test3;
                            4: testRec.StatusOption := testRec.StatusOption::Test4;
                            5: testRec.StatusOption := testRec.StatusOption::Test5;
                        end;
                        testRec.MyDate := CreateDateTime(DMY2Date(31,i,2017), 0T);
                        testRec.Insert();

                        Clear(flowRec);
                        flowRec."No." := testRec."No.";
                        flowRec.Type := testRec.Type;
                        flowRec.MyDate := CreateDateTime(DMY2Date(31,i,2017), 0T);
                        flowRec.Insert();
                    end;

                    Clear(flowRec);
                    flowRec."No." := format(6);
                    flowRec.Type := 'Test';
                    flowRec.MyDate := CreateDateTime(DMY2Date(31,6,2017), 0T);
                    flowRec.Insert();
                end;
            }
            action(ViewTestData)
            {
                Promoted = true;
                PromotedCategory = New;
                RunObject = page "Test";
            }
        }
    }
}