table 50110 MyTableFlowFieldTest
{
    fields
    {
        field(1;"No.";Code[20])
        {
        }

        field(2; "Type"; Code[20])
        {}

        field(3; "MyDate"; DateTime)
        {}

        field(4;OptionFF;Boolean)
        {
            CaptionML=ENU='Option?',DEU='Option?';
            CalcFormula=exist(MyTestData where ("No." = field("No."), Type = field(Type), "StatusOption"=filter(<>"Test3"), "StatusOption"=filter(<>"Test5")));
            FieldClass=FlowField;
            Description='FlowField auf EXISTS (MyTestData)';
            Editable=false;
            NotBlank=true;
        }

        field(5;DateFF;Boolean)
        {
            CaptionML=ENU='Date?',DEU='Date?';
            FieldClass=FlowField;
            //CalcFormula=exist(MyTestData where ("No." = field("No."), Type = field(Type), MyDate = filter (> field("MyDate"))));
            CalcFormula=exist(MyTestData where ("No." = field("No."), Type = field(Type), MyDate = field("MyDate")));
            //CalcFormula=exist(MyTestData where (MyDate = filter (> field("MyDate"))));
            //CalcFormula=exist(MyTestData where (MyDate >= field("MyDate"))));
            //CalcFormula=exist(MyTestData where (MyDate = field("MyDate")));
            Description='FlowField auf EXISTS (MyTestData)';
            Editable=false;
            NotBlank=true;
        }
    }

}