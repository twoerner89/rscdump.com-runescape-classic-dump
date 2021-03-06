unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IdComponent, IdTCPConnection, IdTCPClient, IdBaseComponent,
  StdCtrls, FGINT, XPMan;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    txtUser: TEdit;
    txtPass: TEdit;
    chkReconnect: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    txtCoords: TEdit;
    txtSleep: TMemo;
    chkServerMessages: TCheckBox;
    txtHost: TEdit;
    txtPort: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    txtReconnectPause: TEdit;
    cmbWorld: TComboBox;
    XPManifest1: TXPManifest;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure txtSleepKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbWorldChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


const LongString: string = 'All RuneScape code and data, including this message, '+
                           'are copyright 2003 Jagex Ltd. Unauthorised reproduction '+
                           'in any form is strictly prohibited.  The RuneScape network '+
                           'protocol is copyright 2003 Jagex Ltd and is protected by '+
                           'international copyright laws. The RuneScape network protocol '+
                           'also incorporates a copy protection mechanism to prevent '+
                           'unauthorised access or use of our servers. Attempting to break, '+
                           'bypass or duplicate this mechanism is an infringement of the '+
                           'Digital Millienium Copyright Act and may lead to prosecution. '+
                           'Decompiling, or reverse-engineering the RuneScape code in any '+
                           'way is strictly prohibited. RuneScape and Jagex are registered '+
                           'trademarks of Jagex Ltd. You should not be reading this message, '+
                           'you have been warned...';


type array256 = array[0..255]of Integer;
const WeirdArrayClient: array256 = (
      435, 634, 126, 745, 242, 783, 465, 754, 168, 457, 
        855, 473, 745, 457, 178, 544, 124, 51, 542, 13, 
        741, 865, 945, 167, 467, 351, 467, 979, 637, 562, 
        417, 686, 32, 3, 4, 5, 6, 7, 8, 9, 
        40, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        50, 572, 52, 3, 4, 5, 6, 7, 8, 9, 
        60, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        70, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        80, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        90, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        100, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        110, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        120, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        130, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        140, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        150, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        160, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        170, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        180, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
        500, 251, 750, 950, 700, 245, 560, 782, 817, 345, 
        653, 11, 234, 754, 365, 753, 123, 734, 317, 124, 
        174, 175, 845, 734, 185, 643, 458, 21, 865, 317, 
        563, 237, 683, 643, 643, 176, 754, 175, 464, 545, 
        734, 127, 988, 735, 112, 377, 43, 213, 754, 334, 
        346, 851, 274, 162, 754, 174, 483, 173, 863, 748, 
        347, 274, 568, 167, 784, 217
    );
  WeirdArrayServer:array256 = (
        124,373,863,542,754,874,126,774,277,0,0,0,
        0,0,0,0,0,273,0,934,0,0,0,0,0,453,551,248, 
        707,753,286,185,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,344,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,115,655,265,612,257,978,163,473,88,13,722, 
        417,756,564,532,644,0,0,764,646,263,753,615, 
        864,127,653,126,757,153,734,34,723,674,276, 
        979,765,253,247,75,156,734,126,36,176,562,175, 
        363,762,186,279,781,274,328,666,565,279,752, 
        876,418,327,612,587,0
    );



const server_crypt_e: Integer = 3141592;
      server_crypt_d: Integer = 0;
      server_crypt_c: Integer = 3141592;
      server_crypt_b: Integer = 0;
      client_crypt_e: Integer = 3141592;
      client_crypt_d: Integer = 0;
      client_crypt_c: Integer = 3141592;
      client_crypt_b: Integer = 0;


type
  TSWThread = class(TThread)
  private

  protected
    procedure Execute; override;
  public
    TCP1: TidTCPClient;
    constructor Create();

  end;


var
  Form1: TForm1;
  everconnected: Boolean;
  Th: TSWThread;


implementation

{$R *.DFM}






function UserHash(s: string): Int64;
var
  s1: string;
  i: Integer;
begin
  result:= 0;
  s1:= '';
  for i:= 1 to Length(s) do
  begin
    if(s[i] in ['a'..'z','0'..'9'])then
      s1:= s1 + s[i]
    else
    if(s[i] in ['A'..'Z'])then
      s1:= s1 + chr((ord(s[i])+97)-65)
    else
      s1:= s1 + ' ';
  end;
  s1:= trim(s1);
  if(Length(s1)>12)then s1:= copy(s1,1,12);
  for i:= 1 to length(s1) do
  begin
    result:= result * 37;
    if(s[i] in ['a'..'z'])then
      result:= result + ord(s[i])+1-97
    else
    if(s[i] in ['0'..'9'])then
      result:= result + ord(s[i])+27-48;

  end;

end;


function CommandLength(AllCommand: string): Integer;
var l : Integer;
begin
  if(Length(AllCommand)<1)then
    l:= 100 //doesn;t really matter how much
  else
    l:= Ord(AllCommand[1]);
  if(l>=160)then
  begin
    if(Length(AllCommand)>1)then
      l:= (l-160)*256 + Ord(AllCommand[2]) + 1;
  end;
  result:= l;
end;


function CmdPos(S: string): Integer;
begin
  result:= -1;
  If(Length(S)>1)and(CommandLength(S) = Length(S)-1)Then
  begin
    if(Length(S) > 2)then
          result:= 3
    else
          result:= 2;
  end;
end;

procedure DecryptCommandIn(var S: string);
var i_18_, i_19_, i_20_, i: Integer;
    position: Integer;
begin
      If(Length(S)>1)and(CommandLength(S) = Length(S)-1)Then
      begin

        position:= CmdPos(S);
        i:= Ord(S[position]);
	i_18_ := (i - server_crypt_e) and $ff;
	i_19_ := WeirdArrayClient[i_18_];
	server_crypt_d := (server_crypt_d + i_19_) mod Length(LongString);
	i_20_:= Ord(LongString[server_crypt_d + 1]);
	server_crypt_e := (server_crypt_e * 3 + i_20_ + i_19_) and $ffff;
	S[position]:= Chr(i_18_);
      end else begin
      end;
end;


procedure EncryptCommandForServer(var S: string);
var c1, i1, j1: Integer;
    position: Integer;
begin
      If(Length(S)>1)and(CommandLength(S) = Length(S)-1)Then
      begin
        position:= CmdPos(S);
        i1 := Ord(S[position]);
        S[position] := Chr(byte(i1 + server_crypt_c));
        j1 := WeirdArrayServer[i1];
        server_crypt_b := (server_crypt_b + j1) mod Length(LongString);
        c1 := Ord(LongString[server_crypt_b + 1]);
        server_crypt_c := (server_crypt_c * 3 + c1 + j1) and $ffff;

      end else begin
        //DebugTextAdd('!!!!!!!Wrong S='+Hexy(S)+', all is lost!!!');
        //TIdMappedPortThread(LastThread).Connection.Disconnect;
        //LastThread:= nil;
      end;
end;


function PasswordHash(s1: string; i1: cardinal; bigint, bigint1: string): string;
var
  abyte1: string[15];
  s: string;
  biginteger, biginteger1, biginteger2, biginteger3: TFGint;
  k1, f: byte;
  c: cardinal;
begin
  result:= '';
  k1:= 0;
  while(k1 <= length(s1))do
  begin
    abyte1[1]:= Chr(1+Random(127));
    abyte1[2]:= Chr(Random(256));
    abyte1[3]:= Chr(Random(256));
    abyte1[4]:= Chr(Random(256));
    abyte1[5]:= Chr(Byte(i1 shr 24));
    abyte1[6]:= Chr(Byte(i1 shr 16));
    abyte1[7]:= Chr(Byte(i1 shr 8));
    abyte1[8]:= Chr(Byte(i1));
    for f:= 1 to 7 do
    begin
      if(k1 + f <= Length(s1))then
        abyte1[8 + f]:= s1[k1 + f]
      else
        abyte1[8 + f]:= Chr(32);
    end;
    Base10StringToFGInt('0', biginteger2);

    for f:= 1 to 15 do
    begin
      FGIntMulByInt(biginteger2, biginteger2, 256);
      Base10StringToFGInt('1', biginteger);
      FGIntMulByInt(biginteger, biginteger, Ord(abyte1[f]));
      FGIntAdd(biginteger2, biginteger, biginteger2);
    end;
    FGIntToBase10String(biginteger2, s);
    Base10StringToFGInt(bigint, biginteger);
    Base10StringToFGInt(bigint1, biginteger1);
    FGIntModExp( biginteger2, biginteger, biginteger1, biginteger3);
    FGIntToBase10String(biginteger3, s);
    s:= '';
    while(biginteger3.Number[0] > 1)or(biginteger3.Number[1] <> 0)do
    begin
      FGIntDivByInt(biginteger3, biginteger3, 256, c);
      s:= chr(c) + s;
    end;
    result:= result + Chr(Length(s));
    result:= result + s;

    k1:= k1 + 7;
  end;
end;

procedure CmdToEnd(var S:String);
var f:Integer;
    c: Char;
Begin
  For f:= Length(S) DownTo 2 Do Begin
    c:= S[f-1];
    S[f-1]:= S[f];
    S[f]:= c;
  End;
  S:= Chr(Length(S)) + S;
End;

function Hexy(S: String):String;
var f: Integer;
Begin
  result:='';
  For f:=1 to Length(S) Do Begin
    result:= result + IntToHex(Ord(S[f]), 2) + ' ';
  End;
End;


function LoginCommand(user, password: string; sessionID: cardinal): string;
var
  vers: word;
  sid: word;
  cid: cardinal;
  cmd: string;
  uhash: Int64;
begin
  uhash:= UserHash(user);
  while(Length(password)<20)do
    password:= password + ' ';
  password:= PasswordHash(password, sessionID, '18439792161837834709', '192956484481579778191558061814292671521');
  vers:= 178;
  sid:= 0;
  cid:= 0;
  //vers, sid, uhash, passhash, cid
  cmd:= #0;
  cmd:= cmd + chr(byte(vers shr 8));
  cmd:= cmd + chr(byte(vers));
  cmd:= cmd + chr(byte(sid shr 8));
  cmd:= cmd + chr(byte(sid));
  cmd:= cmd + chr(byte(uhash shr 56));
  cmd:= cmd + chr(byte(uhash shr 48));
  cmd:= cmd + chr(byte(uhash shr 40));
  cmd:= cmd + chr(byte(uhash shr 32));
  cmd:= cmd + chr(byte(uhash shr 24));
  cmd:= cmd + chr(byte(uhash shr 16));
  cmd:= cmd + chr(byte(uhash shr 8));
  cmd:= cmd + chr(byte(uhash));
  cmd:= cmd + password;
  cmd:= cmd + chr(byte(cid shr 24));
  cmd:= cmd + chr(byte(cid shr 16));
  cmd:= cmd + chr(byte(cid shr 8));
  cmd:= cmd + chr(byte(cid));
  CmdToEnd(cmd);
  result:= cmd;

end;


function DecompressCoords(a, b, c: Byte):String;
var X, Y: Word;
Begin
  X:= a;        //aaaaaaaa bbbbbbbb cccccccc
  X:= X shl 3;  //xxxxxxxx xxxyyyyy yyyyyyyy
  X:= X or Byte((b and $E0) shr 5);
  Y:= b and $1F;
  Y:= Y shl 8;
  Y:= Y or c;
  result:= IntToStr(X) + ',' + IntToStr(Y);
End;


procedure TForm1.Button1Click(Sender: TObject);

begin
  everconnected:= False;
  Th:= TSWThread.Create;
  Button2.Enabled:= True;
  Button1.Enabled:= False;

  repeat
    Application.ProcessMessages;
  until(Th.Terminated);
  Button2.Enabled:= False;
  Button1.Enabled:= True;
  memo1.lines.add('== Disconnected');
  Th.Free;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  EverConnected:= False;
  Th.TCP1.Disconnect;
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
  Memo1.Lines.add(PasswordHash('zzzzzz              ', 1739150954, '18439792161837834709', '192956484481579778191558061814292671521'));
end;

procedure TForm1.txtSleepKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  s: string;
begin

  if(Key = 13)then
  begin
    s:= txtSleep.Text;
    s:= lowercase(s);
    if(s<>'')then
    begin
      s:= #$C1 + s;
      CmdToEnd(s);
      memo1.Lines.Add('>> ' + Hexy(s));
      EncryptCommandForServer(s);
      if(Th<>nil)and(Th.TCP1.Connected)then
      begin
        Th.TCP1.WriteBuffer(s[1], Length(s), True);
      end;
    end;
    txtSleep.Text:= '';
  end else
  begin
    txtSleep.Text:= txtSleep.Text + Chr(Key);
  end;
end;


constructor TSWThread.Create();
begin
  FreeOnTerminate := False;
  inherited Create(False);
end;


procedure TSWThread.Execute;
var
  s, password, user: string;
  f: Integer;
  c: Cardinal;
  AllCommand: string;
  Command: string;
  cc: Char;
  cmd: Byte;


begin
  TCP1:= TidTCPClient.Create(nil);
  TCP1.Host:= Form1.txtHost.Text;
  TCP1.Port:= StrToInt(Form1.txtPort.Text);
  EverConnected:= False;
  repeat
    if(EverConnected)then
      Sleep(StrToInt(Form1.txtReconnectPause.Text)*1000);
    f:= 0;
    try            //209.120.137.227   43595

      server_crypt_e:= 3141592;
      server_crypt_d:= 0;
      server_crypt_c:= 3141592;
      server_crypt_b:= 0;
      client_crypt_e:= 3141592;
      client_crypt_d:= 0;
      client_crypt_c:= 3141592;
      client_crypt_b:= 0;
      AllCommand:= '';

      TCP1.Connect;
      Form1.memo1.lines.add('== Connected');

      if(TCP1.Connected)then
      begin
        EverConnected:= True;
        c:= TCP1.ReadCardinal;
        Form1.Memo1.Lines.Add('<< Seed: ' + IntToStr(c));
        password:= Form1.txtPass.Text;
        user:= Form1.txtUser.Text;
        s:= LoginCommand(user, password, c);
        EncryptCommandForServer(s);
        Form1.memo1.Lines.Add('>> ' + Hexy(s));
        TCP1.WriteBuffer(s[1], Length(s), True);
      end;

      while(TCP1.Connected)do
      begin
        f:= f + 1;
        if(f = 20)then
        begin
          Sleep(50);
          f:= 0;
        end;

        begin
  //        TCP1.ReadChar
          s:= TCP1.ReadChar;
          AllCommand:= AllCommand + s;

          if(AllCommand<>'')and(CommandLength(AllCommand) < Length(AllCommand))then
          begin
            Command:= Copy(AllCommand, 1, CommandLength(AllCommand)+1);
            Delete(AllCommand, 1, CommandLength(AllCommand)+1);
            DecryptCommandIn(Command);
//            Form1.memo1.Lines.Add('<< ' + Hexy(Command));
            for f:=2 To Length(Command)-1 Do
            Begin
              cc:= Command[f];
              Command[f]:= Command[f+1];
              Command[f+1]:= cc;
            End;
            cmd:= Ord(Command[2]);
            if(cmd = $FF)then
            begin
              Form1.txtCoords.Text:= DecompressCoords(Ord(Command[3]), Ord(Command[4]), Ord(Command[5]));
            end;
            if(cmd = $08)then
            begin
              s:= Copy(Command,3,Length(Command));
              if(Form1.chkServerMessages.Checked)then
              begin
                Form1.Memo1.Lines.Add('Server: ' + s);
              end;
            end;
          end;

//          if(s<>'')then
//            memo1.Lines.Add('<< ' + Hexy(s));
        end;

      end;
    except
    end;
  until(not Form1.chkReconnect.Checked)or(not EverConnected);
  Terminate;
end;



procedure TForm1.cmbWorldChange(Sender: TObject);
var s: string;
    f: Integer;
    Space: Boolean;
begin
  s:= Trim(cmbWorld.Items[cmbWorld.ItemIndex]);
  Space:= false;
  for f:= Length(s) downto 1 do
  begin
    if(Space)then s[f]:= ' ';
    if(s[f] = ' ')then Space:= True;
  end;
  s:= Trim(s);
  txtPort.Text:= '';
  txtHost.Text:= '';
  for f:= Length(s) downto 1 do
  begin
    if(s[f] in ['0'..'9'])then
      txtPort.Text:= s[f] + txtPort.Text
    else begin
      txtHost.Text:= Copy(s, 1, f-1);
      break;
    end;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  cmbWorld.ItemIndex:= 0;
  cmbWorldChange(nil);
end;

end.
