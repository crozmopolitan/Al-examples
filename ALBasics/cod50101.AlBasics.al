codeunit 50101 MyLibrary
{
    procedure HelloWorld();
    begin
        Message('Hello World from the code unit!');
    end;

    local procedure GetUTCOffset(): Integer;
    var
        lLocalTime: Time;
        lUTCTime: Time;
        lDateTimeTxt: Text;
        lTimeTxt: Text;
    begin
        EVALUATE(lLocalTime, '17:00');
        lDateTimeTxt := FORMAT(CREATEDATETIME(TODAY(), lLocalTime), 0, 9);
        lTimeTxt := COPYSTR(lDateTimeTxt, STRPOS(lDateTimeTxt, 'T') + 1);
        lTimeTxt := COPYSTR(lTimeTxt, 1, STRLEN(lTimeTxt) - 1);
        EVALUATE(lUTCTime, lTimeTxt);
        exit((lLocalTime - lUTCTime));
    end;

    procedure UnixTimeToDateTime(unixtime: BigInteger): DateTime;
    var
        myDate: Date;
        myTime: Time;
        strTime: Text;
        days: Integer;
        seconds: Integer;
    begin
        unixtime += GetUTCOffset()/1000;
        days := unixtime div (60*60*24);
        myDate := DMY2DATE(1,1,1970);
        while (days > 0) do
        begin
            myDate := CalcDate('<+1D>', myDate);
            days -= 1;
        end;
        seconds := unixtime mod (60*60*24);
        myTime := 000000T;
        myTime += seconds*1000;
        exit(CreateDateTime(myDate, myTime));
    end;

    procedure DateTimeToUnixTime(dt: DateTime): BigInteger;
    var
        myTime: Time;
        seconds: Integer;
        minutes: Integer;
        hours: Integer;
        days: Integer;
    begin
        dt -= GetUTCOffset();
        myTime := DT2Time(dt);
        Evaluate(hours, Format(myTime, 0, '<Hours24,2>'));
        Evaluate(minutes, Format(myTime, 0, '<Minutes,2>'));
        Evaluate(seconds, Format(myTime, 0, '<Seconds,2>'));
        days := (DT2Date(dt) - DMY2DATE(1,1,1970));
        exit (days*24*60*60 + hours*60*60 + minutes*60 + seconds);
    end;
}
