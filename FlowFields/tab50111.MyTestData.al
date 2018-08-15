table 50111 MyTestData
{
    fields
    {
        field(1;"No.";Code[20])
        {
        }

        field(2;"Type";Option)
        {
            OptionCaptionML=ENU='MyType',DEU='MeinTyp';
            OptionMembers=MyType;
        }

        field(3; "MyDate"; DateTime)
        {}

        field(4;StatusOption;Option)
        {
            OptionMembers = Test1,Test2,Test3,Test4,Test5;
        }

    }

    keys
    {
        key(pk; "No.")
        {
        }
        key(typekey; "Type", "No.")
        {
        }
    }

}