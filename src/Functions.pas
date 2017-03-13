unit Functions;

interface

uses SettingsTelldusLive,
Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes,
Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
shlobj, MainForm, SettingsForm, Registry, Inifiles, winInet, System.Net.HttpClient, TlHelp32;

function GetAppVersionStr: string;

function LocalAppDataPath: string;
function LocalAppDataConfigPath: string;
function LocalAppDataConfigFile: string;

function CheckConfigExist: Boolean;
function SelectedTabbItemID: string;
function SelectedTabbItemName: string;
function ExtractText(const Str: string; const Delim1, Delim2: char): string;
function ZeroFixTime(const Str:String):String;
function ZeroReturnOne(const I:Integer):Integer;
function TrimLeadingZeros(const S: string): string;

function MyMessageDlg(CONST Msg: string; DlgTypt: TmsgDlgType; button: TMsgDlgButtons;
  Caption: ARRAY OF string; dlgcaption: string): Integer;
function CheckVersion(const AURL: string): string;


implementation



function CheckVersion(const AURL: string): string;
var
  HttpClient: THttpClient;
  HttpResponse: IHttpResponse;
begin
  HttpClient := THTTPClient.Create;
  HttpClient.AllowCookies := False;
  try
    HttpResponse := HttpClient.Get(AURL);
    Result := HttpResponse.ContentAsString();
  finally
    HttpClient.Free;
  end;
end;

function ZeroReturnOne(const I:Integer):Integer;
begin
  if I = 0 then
    Result:= 1
  else
    Result := I
end;

function ZeroFixTime(const Str:String):String;
begin
  if Str.ToInteger <= 9 then
    Result:= '0'+Str
  else
    Result := Str
end;

function TrimLeadingZeros(const S: string): string;
var
  I, L: Integer;
begin
  L:= Length(S);
  I:= 1;
  while (I < L) and (S[I] = '0') do Inc(I);
  Result:= Copy(S, I);
end;

function ExtractText(const Str: string; const Delim1, Delim2: char): string;
var
  pos1, pos2: integer;
begin
  result := '';
  pos1 := Pos(Delim1, Str);
  pos2 := Pos(Delim2, Str);
  if (pos1 > 0) and (pos2 > pos1) then
    result := Copy(Str, pos1 + 1, pos2 - pos1 - 1);
end;

function SelectedTabbItemID: string;
var
s:String;
begin
    if FormMain.PageControl1.TabIndex=0 then begin
      //Result := copy(FormMain.listbox1.items[FormMain.listbox1.itemindex],4,9)
      s:= FormMain.listbox1.items[FormMain.listbox1.itemindex];
      s:= ExtractText(s,':','/');
      //FormMain.Memo1.Lines.Add(s);
      Result := s;
    end
    else  begin
      //Result := copy(FormMain.listbox2.items[FormMain.listbox2.itemindex],4,9);
      s:= FormMain.listbox2.items[FormMain.listbox2.itemindex];
      s:= ExtractText(s,':','/');
      //FormMain.Memo1.Lines.Add(s);
      Result := s;
    end;
end;

function SelectedTabbItemName: string;
var
s:String;
begin
    if FormMain.PageControl1.TabIndex=0 then begin
      //Result := copy(FormMain.listbox1.items[FormMain.listbox1.itemindex],4,9)
      s:= FormMain.listbox1.items[FormMain.listbox1.itemindex];
      s:= ExtractText(s,'/','.');
      //FormMain.Memo1.Lines.Add(s);
      Result := s;
    end
    else  begin
      //Result := copy(FormMain.listbox2.items[FormMain.listbox2.itemindex],4,9);
      s:= FormMain.listbox2.items[FormMain.listbox2.itemindex];
      s:= ExtractText(s,'/','.');
      //FormMain.Memo1.Lines.Add(s);
      Result := s;
    end;
end;

function LocalAppDataPath : string;
const
  SHGFP_TYPE_CURRENT = 0;
var
  path: array [0..MaxChar] of char;
begin
  SHGetFolderPath(0,CSIDL_LOCAL_APPDATA,0,SHGFP_TYPE_CURRENT,@path[0]);
  Result := StrPas(path);
end;

function LocalAppDataConfigPath : string;
begin
  Result := LocalAppDataPath+'\'+FormMain.Caption+'\';
end;

function LocalAppDataConfigFile : string;
begin
  Result := LocalAppDataPath+'\'+FormMain.Caption+'\'+FormMain.Caption+CONFIG_EXT;
end;

function CheckConfigExist: Boolean;
begin
  Result := False;
  if forcedirectories(LocalAppDataConfigPath) then begin
    if FileExists(LocalAppDataConfigFile) then
      Result := True
  end
end;

function GetAppVersionStr: string;
var
  Exe: string;
  Size, Handle: DWORD;
  Buffer: TBytes;
  FixedPtr: PVSFixedFileInfo;
begin
  Exe := ParamStr(0);
  Size := GetFileVersionInfoSize(PChar(Exe), Handle);
  if Size = 0 then
    RaiseLastOSError;
  SetLength(Buffer, Size);
  if not GetFileVersionInfo(PChar(Exe), Handle, Size, Buffer) then
    RaiseLastOSError;
  if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
    RaiseLastOSError;
  Result := Format('%d.%d.%d.%d',
    [LongRec(FixedPtr.dwFileVersionMS).Hi,  //major
     LongRec(FixedPtr.dwFileVersionMS).Lo,  //minor
     LongRec(FixedPtr.dwFileVersionLS).Hi,  //release
     LongRec(FixedPtr.dwFileVersionLS).Lo]) //build
end;

function MyMessageDlg(CONST Msg: string; DlgTypt: TmsgDlgType; button: TMsgDlgButtons;
  Caption: ARRAY OF string; dlgcaption: string): Integer;
var
  aMsgdlg: TForm;
  i: Integer;
  Dlgbutton: Tbutton;
  Captionindex: Integer;
begin
  aMsgdlg := createMessageDialog(Msg, DlgTypt, button);
  aMsgdlg.Caption := dlgcaption;
  aMsgdlg.BiDiMode := bdRightToLeft;
  aMsgdlg.Color := clWhite;
  Captionindex := 0;
  for i := 0 to aMsgdlg.componentcount - 1 Do
  begin
    if (aMsgdlg.components[i] is Tbutton) then
    Begin
      Dlgbutton := Tbutton(aMsgdlg.components[i]);
      if Captionindex <= High(Caption) then
        Dlgbutton.Caption := Caption[Captionindex];
      inc(Captionindex);
    end;
  end;
  Result := aMsgdlg.Showmodal;
end;

end.
