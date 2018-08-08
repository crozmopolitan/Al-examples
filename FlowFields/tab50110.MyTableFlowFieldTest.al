table 50110 MyTableFlowFieldTest
{
    fields
    {
        field(1;"No.";Code[20])
        {
        }

        field(2; "Type"; Code[20])
        {}

        field(3;StatusFF;Boolean)
        {
            CaptionML=ENU='Test?',DEU='Test?';
            CalcFormula=exist(MyTestData where ("No." = field("No."), Type = field(Type), "StatusOption"=filter(<>"Test3"), "StatusOption"=filter(<>"Test5")));
            FieldClass=FlowField;
            Description='FlowField auf EXISTS (MyTestData)';
            Editable=false;
            NotBlank=true;
        }
    }

}