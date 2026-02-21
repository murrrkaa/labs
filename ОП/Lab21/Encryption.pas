PROGRAM Encryption(INPUT, OUTPUT);
CONST
  Len = 20;
TYPE
  Str = ARRAY [1 .. Len] OF ' ' .. 'Z';
  Chiper = ARRAY [' ' .. 'Z'] OF CHAR;
  Length = 0 .. Len;
VAR
  Msg: Str;
  Code: Chiper;
  MsgLen: Length;
  ChipherLetter: SET OF CHAR;
PROCEDURE Initialize(VAR Code: Chiper);
VAR
  F: TEXT;
  Ch1, Ch2: CHAR;
BEGIN {Initialize}
  ASSIGN(F, 'Chipher.txt');
  RESET(F);
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Ch1);
      IF NOT EOLN(F)
      THEN
        BEGIN
          READ(F, Ch2);
          Code[Ch1] := Ch2;
          ChipherLetter := ChipherLetter + [Ch1];
          WHILE NOT EOF(F)
          DO
            BEGIN
              READ(F, Ch1);
              READ(F, Ch2);
              ChipherLetter := ChipherLetter + [Ch1];
              Code[Ch1] := Ch2;
              READLN(F)
            END
        END
    END  
  ELSE
    WRITELN 
END; {Initialize}
PROCEDURE ReadMsg(VAR Msg: Str; VAR MsgLen: Length);
BEGIN
  MsgLen := 0;
  WHILE (NOT EOLN) AND (MsgLen < Len)
  DO
    BEGIN
      MsgLen := MsgLen + 1;
      READ(Msg[MsgLen]);
      WRITE(Msg[MsgLen])
    END;
  READLN;
  WRITELN
END;

PROCEDURE Encode(VAR S: Str);
VAR
  Index: 1 .. MsgLen;
BEGIN {Encode}
  FOR Index := 1 TO MsgLen
  DO
    IF S[Index] IN ChipherLetter
    THEN
      WRITE(Code[S[Index]])
    ELSE
      WRITE(S[Index]);
  WRITELN
END; {Encode}


BEGIN {Encryption}
  Initialize(Code);
  WHILE NOT EOF(INPUT)
  DO
    BEGIN
      ReadMsg(Msg, MsgLen);
      Encode(Msg)
    END
END.  {Encryption}

