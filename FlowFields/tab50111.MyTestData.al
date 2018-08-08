table 50111 MyTestData
{
    fields
    {
        field(1;"No.";Code[20])
        {
        }

        field(2;"Type";Code[20])
        {
        }

        field(3;StatusOption;Option)
        {
            OptionMembers = Test1,Test2,Test3,Test4,Test5;
        }

    }

    keys
    {
        key(pk; "No.", "Type")
        {
        }
    }

}