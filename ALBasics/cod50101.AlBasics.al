codeunit 50101 MyLibrary
{
    procedure HelloWorld();
    begin
        Message('Hello World from the code unit!');
    end;

    procedure UnixTimeToDateTime(unixtime: BigInteger): DateTime;
    var
        myDate: Date;
        myTime: Time;
        strTime: Text;
        seconds: Integer;
        minutes: Integer;
        hours: Integer;
        days: Integer;
    begin
        seconds := unixtime mod 60;
        unixtime := unixtime div 60;
        minutes := unixtime mod 60;
        unixtime := unixtime div 60;
        hours := unixtime mod 24;
        unixtime := unixtime div 24;
        days := unixtime;
        myDate := DMY2DATE(1,1,1970);
        while (days > 0) do
        begin
            myDate := CalcDate('<+1D>', myDate);
            days -= 1;
        end;
        strTime += Format(hours) + ':' + Format(minutes) + ':' + Format(seconds);
        Evaluate(myTime, strTime);
        exit(CreateDateTime(myDate, myTime));
    end;

    procedure DateTimeToUnixTime(dt: DateTime): BigInteger;
    var
        myDate: Date;
        myTime: Time;
        strTime: Text;
        seconds: Integer;
        minutes: Integer;
        hours: Integer;
        days: Integer;
    begin
        myTime := DT2Time(dt);
        Evaluate(hours, Format(myTime, 0, '<Hours24,2>'));
        Evaluate(minutes, Format(myTime, 0, '<Minutes,2>'));
        Evaluate(seconds, Format(myTime, 0, '<Seconds,2>'));
        seconds := hours*60*60+minutes*60+seconds;

        days := 0;
        myDate := DMY2DATE(1,1,1970);
        while (myDate < DT2Date(dt)) do
        begin
            myDate := CalcDate('<+1D>', myDate);
            days += 1;
        end;

        exit(days*24*60*60 + seconds);
    end;
}