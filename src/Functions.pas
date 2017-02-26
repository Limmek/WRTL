unit Functions;

interface

uses SettingsTelldusLive,
Winapi.Windows, System.SysUtils, shlobj, MainForm, SettingsForm, Registry, Inifiles;

function GetAppVersionStr: string;

function LocalAppDataPath: string;
function LocalAppDataConfigPath: string;
function LocalAppDataConfigFile: string;

function CheckConfigExist: Boolean;
function SelectedTabbItem: string;

implementation

function SelectedTabbItem: string;
begin
    if FormMain.PageControl1.TabIndex=0 then
      Result := copy(FormMain.listbox1.items[FormMain.listbox1.itemindex],4,9)
    else
      Result := copy(FormMain.listbox2.items[FormMain.listbox2.itemindex],4,9);
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

end.
