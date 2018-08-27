// Some examples for coding with AL

pageextension 50101 "Customer AL Basics" extends "Customer List"
{
    trigger OnOpenPage();
    begin
        TestStringVariable();
        TestIf();
        TestFormat();
        ParseToString();
        TestDate();
        TestUnixTime();
        TestCallWithOption();
        TestCallWithVarParameter();
        TestFunctions();
        TestCallProcedureInCodeUnit();
    end;

    local procedure TestStringVariable();
    var 
        myStringVariable: Text;
    begin
        myStringVariable := 'hello World';
        Message('displaying a string aka Text: ' + myStringVariable);
    end;

    local procedure TestIf();
    var 
        myIntVariable: Integer;
    begin
        myIntVariable := 77;
        if (myIntVariable < 77) then
        begin
            Message(Format(myIntVariable) + ' is less than 77');
        end
        else
        begin
            Message(Format(myIntVariable) + ' is not less than 77');
        end;
    end;

    local procedure TestFormat();
    var
        myIntVariable: Integer;
        myBoolVariable: Boolean;
        myOptionVariable: Option test1, test2, test3;
        myDateVariable: Date;
        myDateTimeVariable: DateTime;
    begin
        myIntVariable := 77;
        Message('We have a number ' + Format(myIntVariable));
        Message(StrSubstNo('We have another number %1',myIntVariable));
        myBoolVariable := false;
        Message('We have a boolean ' + Format(myBoolVariable));
        myOptionVariable := myOptionVariable::test1;
        Message('We have an option ' + Format(myOptionVariable));
        myDateVariable := Today;
        Message('Today is ' + Format(myDateVariable));
        myDateTimeVariable := CurrentDateTime;
        Message('Now is ' + Format(myDateTimeVariable));
    end;

    local procedure ParseToString();
    var
        myIntVariable: Integer;
        myStringVariable: Text;
    begin
        myStringVariable := '77';
        // StrToInt
        evaluate(myIntVariable, myStringVariable);
        if (myIntVariable = 77) then
        begin
            Message('the string contains an integer');
        end;
    end;

    local procedure TestDate();
    var
        myDateVariable: Date;
        myDateTimeVariable: DateTime;
        myOtherDateVariable: Date;
        myTimeVariable: Time;
        emptyDateTime: DateTime;
        emptyDate: Date;
    begin
        // just a date, with no time
        myDateVariable := Today;
        // time and date
        myDateTimeVariable := CurrentDateTime;

        // compare empty date time object
        if (emptyDateTime = 0DT) then
        begin
            Message('the date time has not been set yet');
        end;

        // compare empty date object
        if (emptyDate = 0D) then
        begin
            Message('the date has not been set yet');
        end;

        // compare a date time
        if (myDateTimeVariable < CurrentDateTime) then
        begin
            Message('Time flies!');
        end;

        // convert DateTime to Date
        if (DT2Date(myDateTimeVariable) > Today) then
        begin
            Message('we are around midnight');
        end;

        // get the time part
        myTimeVariable := DT2Time(myDateTimeVariable);
        Message('the current time is ' + Format(myTimeVariable));

        // set a constant date
        myOtherDateVariable := DMY2DATE(31,12,2017);
        
        // comparing the difference in days
        if (CalcDate('<+21D>', myOtherDateVariable) < DT2DATE(myDateTimeVariable)) then
        begin
            Message('the dates are more than 21 days apart.');
        end;
    end;

    procedure TestUnixTime();
    var
        myCodeUnit: Codeunit myLibrary;
        nowUnixTime: BigInteger;
        FormatString: Text;
        nowDateTime: DateTime;
    begin
        nowUnixTime := myCodeUnit.DateTimeToUnixTime(CurrentDateTime);
        Message('to unixtime: ' + Format(nowUnixTime));
        nowDateTime := myCodeUnit.UnixTimeToDateTime(nowUnixTime);
        // formatting the date time to string
        FormatString := '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>.<Thousands,3>';
        Message('from unixtime: ' + Format(nowDateTime, 0, FormatString));
    end;

    local procedure TestProcedureWithOption(myoption: Option testA, testB, testC);
    begin
        Message('called with option ' + Format(myoption));
    end;
    local procedure TestCallWithOption();
    var
        testoption: Option testA, testB, testC;
        testoption2: Option testC, testB, testA;
    begin
        TestProcedureWithOption(testoption::testA);

        // dangerous if Options are defined differently in the call and in the parameter:
        TestProcedureWithOption(testoption2::testA);
    end;

    local procedure TestProcedureWithVarParameter(var myInteger: Integer);
    begin
        myInteger := 77;
    end;
    local procedure TestCallWithVarParameter();
    var
        myInteger: Integer;
    begin
        myInteger := 88;
        TestProcedureWithVarParameter(myInteger);
        Message('this should be 77: ' + Format(myInteger));
    end;

    local procedure TestFunctionWithNamedResult() myResult: Boolean;
    begin
        myResult := true;
        myResult := false;
    end;

    local procedure TestFunctionWithUnnamedResult(): Boolean;
    begin
        exit(true);
        // will never get here.
    end;

    local procedure TestFunctions();
    begin
        Message('TestFunctionWithNamedResult ' + Format(TestFunctionWithNamedResult()));
        Message('TestFunctionWithUnnamedResult ' + Format(TestFunctionWithUnnamedResult()));
    end;

    local procedure TestCallProcedureInCodeUnit();
    var
        myCodeUnit: Codeunit myLibrary;
    begin
        myCodeUnit.HelloWorld();
    end;
}