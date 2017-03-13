unit Procedures;

interface

uses
  MainForm, SettingsForm, Functions, SettingsTelldusLive,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Taskbar,
  IPPeerClient, REST.Client, REST.Authenticator.OAuth, Data.Bind.Components, Data.Bind.ObjectScope, JSON, DBXJSON,
  Vcl.Grids, Vcl.Menus, Math, Vcl.Buttons, Inifiles, Registry, shlobj, System.Notification, idhttp, Shellapi;

type
  PopupClickAPICommand = class(TObject)
  public
    class procedure Send(Sender: TObject);
  end;

procedure WriteConfig;
procedure ReadConfig;
procedure LoadSensorer;
procedure LoadDevices;
procedure RunOnStartup(WindowTitle,CommandLn: String; RunOnlyOnce: Boolean);
procedure RemoveOnStartup(WindowTitle,CommandLn: String; RunOnlyOnce: Boolean);
procedure ConsoleMessage(msg: String);
procedure ConsoleNewMessage(msg: String);
procedure Log(const Msg: string); overload;
procedure RunNotification(AlertMsg:String);
procedure DeleteCurrentRow(Grid: TStringGrid);

procedure StringGrid2File(StringGrid: TStringGrid; FileName: String);
procedure File2StringGrid(StringGrid: TStringGrid; FileName: String);

Procedure ShowChoiseMessage(fixedID,fixedName:String);

procedure AddHotKeyEnable(Handle:HWND; HotKey:Integer);
procedure AddHotKeyDisable(Handle:HWND; HotKey:Integer);


implementation

var
  Ini : TIniFile;
  JSONObject: TJSONObject;
  JSONArray: TJSONArray;
  //JSONValue : TJSONValue;
  devices: TJSONObject;
  fixedID,fixedName: String;

class procedure PopupClickAPICommand.Send(Sender: TObject);
begin
    fixedID := ExtractText(FormMain.ListBox2.Items[TMenuItem(Sender).MenuIndex],':','/');
    fixedName := ExtractText(FormMain.ListBox2.Items[TMenuItem(Sender).MenuIndex],'/','.');
    ShowChoiseMessage(fixedID,fixedName);
end;

procedure AddHotKeyEnable(Handle:HWND; HotKey:Integer);
var hkID:Integer;
begin
  hkID := HotKey;
  if HotKey = 0 then begin
    RegisterHotKey(Handle, hkID, MOD_CONTROL or MOD_ALT, VK_F1 );
  end;
  if HotKey = 1 then begin
    RegisterHotKey(Handle, hkID, MOD_CONTROL or MOD_ALT, VK_F2 );
  end;
  if HotKey = 2 then begin
    RegisterHotKey(Handle, hkID, MOD_CONTROL or MOD_ALT, VK_F3 );
  end;
  if HotKey = 3 then begin
    RegisterHotKey(Handle, hkID, MOD_CONTROL or MOD_ALT, VK_F4 );
  end;
end;


procedure AddHotKeyDisable(Handle:HWND; HotKey:Integer);
var hkID:Integer;
begin
  hkID := (100+HotKey);
  if HotKey = 0 then begin
    RegisterHotKey(Handle, hkID, MOD_SHIFT or MOD_ALT, VK_F1 );
  end;
  if HotKey = 1 then begin
    RegisterHotKey(Handle, hkID, MOD_SHIFT or MOD_ALT, VK_F2 );
  end;
  if HotKey = 2 then begin
    RegisterHotKey(Handle, hkID, MOD_SHIFT or MOD_ALT, VK_F3 );
  end;
  if HotKey = 3 then begin
    RegisterHotKey(Handle, hkID, MOD_SHIFT or MOD_ALT, VK_F4 );
  end;
end;

Procedure ShowChoiseMessage(fixedID,fixedName:String);
var
buttonSelected : Integer;
begin
    //buttonSelected := MessageDlg('Enable or Disable '+fixedName,mtCustom, [mbYes,mbNo],['Enable','Disable'], 0);
    buttonSelected := MyMessageDlg('What to do with '+fixedName, mtCustom, [mbYes, mbNo], ['Enable','Disable'], Application.Title);
    if buttonSelected = mrYes    then begin
      ConsoleMessage('ID: '+fixedID+' Name: '+fixedName);
      FormMain.RESTRequest1.Params.AddItem('id',fixedID);
      FormMain.RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_ON;
      try
        FormMain.RESTRequest1.Execute;
      finally
        ConsoleMessage(FormMain.RESTResponse1.JSONText);
        if FormSettings.CheckBox_WinNotification.Checked then
          RunNotification(fixedName+' Enabled');
      end;
    end;

    if buttonSelected = mrNo    then  begin
      ConsoleMessage('ID: '+fixedID+' Name: '+fixedName);
      FormMain.RESTRequest1.Params.AddItem('id',fixedID);
      FormMain.RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_OFF;
      try
        FormMain.RESTRequest1.Execute;
      finally
        ConsoleMessage(FormMain.RESTResponse1.JSONText);
        if FormSettings.CheckBox_WinNotification.Checked then
          RunNotification(fixedName+' Disabled');
      end;
    end;
end;


procedure StringGrid2File(StringGrid: TStringGrid; FileName: String);
var
  F: TextFile;
  x, y: Integer;
begin
  AssignFile(F, FileName);
  Rewrite(F);
  Writeln(F, StringGrid.ColCount);
  Writeln(F, StringGrid.RowCount);
  for x:=0 to StringGrid.ColCount-1 do
    for y:=0 to StringGrid.RowCount-1 do
      Writeln(F, StringGrid.Cells[x,y]);
  CloseFile(F);
end;

procedure File2StringGrid(StringGrid: TStringGrid; FileName: String);
var
  F: TextFile;
  Tmp, x, y: Integer;
  TmpStr: string;
begin
  AssignFile(F, FileName);
  Reset(F);
  Readln(F, Tmp);
  StringGrid.ColCount:=Tmp;
  Readln(F, Tmp);
  StringGrid.RowCount:=Tmp;
  for x:=0 to StringGrid.ColCount-1 do
    for y:=0 to StringGrid.RowCount-1 do
    begin
      Readln(F, TmpStr);
      StringGrid.Cells[x,y]:=TmpStr;
    end;
  CloseFile(F);
end;


procedure DeleteCurrentRow(Grid: TStringGrid);
var
  i: Integer;
begin
  for i := Grid.Row to Grid.RowCount - 2 do
    Grid.Rows[i].Assign(Grid.Rows[i + 1]);
  Grid.RowCount := Grid.RowCount - 1;
end;

procedure RunNotification(AlertMsg:String);
var
Notification: TNotification;
begin
  Notification := FormMain.NotificationCenter1.CreateNotification;
  try
    Notification.Name := Application.Title;
    Notification.Title := Application.Title;
    Notification.AlertBody := AlertMsg;
    Notification.FireDate := Now;

    { Send notification in Notification Center }
    FormMain.NotificationCenter1.PresentNotification(Notification);
    { also this method is equivalent if platform supports scheduling }
    //NotificationC.ScheduleNotification(Notification);
  finally
    Notification.DisposeOf;
  end;
end;


procedure Log(const Msg: string); overload;
var
  F: TextFile;
begin
    if not FileExists(LocalAppDataConfigPath+LOGFILE_FOLDER+DateToStr(now)+LOGFILE_EXT) then
      CreateDir(LocalAppDataConfigPath+LOGFILE_FOLDER);
    AssignFile(F, LocalAppDataConfigPath+LOGFILE_FOLDER+DateToStr(now)+LOGFILE_EXT);
    // Try to append to the file, which succeeds only if the file exists.
  {$IoChecks Off}
    Append(F);
  {$IoChecks On}
    if IOResult <> 0 then
      // The file does not exist, so create it.
      Rewrite(F);
    //WriteLn(F, DateTimeToStr(Now));
    WriteLn(F, Msg);
    CloseFile(F);
end;

procedure ConsoleMessage(Msg:String);
begin
  Msg:=FormatDateTime('tt',Now())+': '+Msg;
  FormMain.Memo1.Lines.Add(Msg);
  if LOGGING then Log(Msg);
end;

procedure ConsoleNewMessage(Msg:String);
begin
  Msg:=DateTimeToStr(Now)+': '+Msg;
  FormMain.Memo1.Text := Msg;
  if LOGGING then Log(Msg);
end;

procedure WriteConfig;
begin
  Ini := TIniFile.Create( LocalAppDataConfigFile );
  try
    Ini.WriteString( 'TelldusLive', 'PUBLIC_KEY', FormSettings.Edit_PUBLIC_KEY.Text );
    Ini.WriteString( 'TelldusLive', 'PRIVATE_KEY', FormSettings.Edit_PRIVATE_KEY.Text );
    Ini.WriteString( 'TelldusLive', 'TOKEN', FormSettings.Edit_TOKEN.Text );
    Ini.WriteString( 'TelldusLive', 'TOKEN_SECRET', FormSettings.Edit_TOKEN_SECRET.Text );
    Ini.WriteBool( 'Settings', 'InitMax',  FormSettings.CheckBox_StartMinimized.Checked );
    Ini.WriteBool( 'Settings', 'AutoLoad', FormSettings.CheckBox_AutoLoadDevices.Checked );
    Ini.WriteBool( 'Settings', 'RunWithWindows', FormSettings.CheckBox_SartWithWindows.Checked );
    Ini.WriteBool( 'Settings', 'EnableLogging', FormSettings.CheckBox_LogToFile.Checked );
    Ini.WriteBool( 'Settings', 'EnableNotifications', FormSettings.CheckBox_WinNotification.Checked );
    Ini.WriteBool( 'Settings', 'EnableHotkeys', FormSettings.CheckBoxEnableHotkeys.Checked );
  finally
    Ini.Free;
  end;
end;

procedure ReadConfig;
var I:Integer;
begin
  Ini := TIniFile.Create( LocalAppDataConfigFile );
  try
    FormSettings.Edit_PUBLIC_KEY.Text := Ini.ReadString( 'TelldusLive', 'PUBLIC_KEY', 'xxx' );
    FormSettings.Edit_PRIVATE_KEY.Text := Ini.ReadString( 'TelldusLive', 'PRIVATE_KEY', '' );
    FormSettings.Edit_TOKEN.Text := Ini.ReadString( 'TelldusLive', 'TOKEN', '' );
    FormSettings.Edit_TOKEN_SECRET.Text := Ini.ReadString( 'TelldusLive', 'TOKEN_SECRET', '' );

    if (Ini.ReadBool( 'Settings', 'InitMax', false )) then begin
      FormSettings.CheckBox_StartMinimized.Checked := True;
      FormMain.WindowState := wsMinimized;
    end
    else begin
      FormSettings.CheckBox_StartMinimized.Checked := False;
      FormMain.WindowState := wsNormal;
      FormMain.BringToFront;
    end;

    if (Ini.ReadBool( 'Settings', 'AutoLoad', false )) then begin
      FormSettings.CheckBox_AutoLoadDevices.Checked := True;
      LoadDevices;
    end
    else begin
      FormSettings.CheckBox_AutoLoadDevices.Checked := False;
    end;

    if (Ini.ReadBool( 'Settings', 'RunWithWindows', false )) then begin
      FormSettings.CheckBox_SartWithWindows.Checked := True;
      RunOnStartup(ExtractFileName(Application.ExeName), Application.ExeName, True);
    end
    else begin
      FormSettings.CheckBox_SartWithWindows.Checked := False;
      RemoveOnStartup(ExtractFileName(Application.ExeName), Application.ExeName, True);
    end;

    if (Ini.ReadBool( 'Settings', 'EnableLogging', false )) then begin
      FormSettings.CheckBox_LogToFile.Checked := True;
      LOGGING := True;
    end
    else begin
      FormSettings.CheckBox_LogToFile.Checked := False;
      LOGGING := False;
    end;

    if (Ini.ReadBool( 'Settings', 'EnableNotifications', false )) then begin
      FormSettings.CheckBox_WinNotification.Checked := True;
    end
    else begin
      FormSettings.CheckBox_WinNotification.Checked := False;
    end;

    if (Ini.ReadBool( 'Settings', 'EnableHotkeys', false )) then begin
      FormSettings.CheckBoxEnableHotkeys.Checked := True;
      FormMain.TabSheetHotKey.Enabled := True;
      for I := 0 to FormMain.ListBox3.Count do
        AddHotKeyEnable(FormMain.Handle, I);
      for I := 0 to FormMain.ListBox4.Count do
        AddHotKeyDisable(FormMain.Handle, I);
    end  else  begin
      FormSettings.CheckBoxEnableHotkeys.Checked := False;
      FormMain.TabSheetHotKey.Enabled := False;
    end;

  finally
    Ini.Free;
  end;
end;

procedure LoadSensorer;
begin
  FormMain.RESTClient1.BaseURL := API_URL + REQUEST_JSON + SENSOR_LIST;
  try
    FormMain.RESTRequest1.Execute;
  finally
    ConsoleMessage(FormMain.RESTResponse1.JSONText);
  end;
end;

procedure LoadDevices;
var
  idx: integer;
  //idy: integer;
begin
  FormMain.RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICES_LIST;
  try
    FormMain.RESTRequest1.Execute;
  finally
    ConsoleMessage(FormMain.RESTResponse1.JSONText);
    FormMain.ListBox1.Clear;
    FormMain.Panel2.Caption :='';
    JSONObject := nil;
    { convert String to JSON }
    JSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FormMain.RESTResponse1.JSONText), 0) as TJSONObject;
    try
      { output the JSON to console as String }
        //ConsoleNewMessage(JSONObject.ToString);
        JSONArray := TJSONArray(JSONObject.Get('device').JsonValue);
        for idx := 0 to pred(JSONArray.Count) do begin
          //devices := TJSONObject(JSONArray.Get(idx));
          devices := TJSONObject(JSONArray.Items[idx]);
          FormMain.ListBox1.Items.Add('id:' + devices.GetValue<string>('id') + '/ '+ devices.GetValue<string>('name')+'.');
          FormMain.ComboBox1.Items.Add('id:' + devices.GetValue<string>('id') + '/ '+ devices.GetValue<string>('name')+'.');
          //FormMain.ListBox1.Items.Add(devices.GetValue<string>('id'));
          //for idy := 0 to pred(devices.Count) do begin
            //ConsoleMessage( devices.Pairs[idy].JsonString.ToString + ':' + devices.Pairs[idy].JsonValue.ToString );
          //end;
        end;
        FormMain.ComboBox1.Text:=(FormMain.ListBox1.Items[0]);
    finally
      JSONObject.Free;
    end;
  end;

end;


procedure RunOnStartup(WindowTitle,CommandLn  : String; RunOnlyOnce: Boolean);
var
  RegIniFile  : TRegIniFile;
begin
  RegIniFile := TRegIniFile.Create('');

  with RegIniFile do begin
    RootKey := HKEY_CURRENT_USER;
    RegIniFile.WriteString('Software\Microsoft\Windows\' +
                             'CurrentVersion\Run'#0,
                              WindowTitle, CommandLn);
    Free;
    //ConsoleMessage('Added to Autorun');
  end;
end;

procedure RemoveOnStartup(WindowTitle,CommandLn  : String; RunOnlyOnce: Boolean);
var
  RegIniFile  : TRegIniFile;
begin
  RegIniFile := TRegIniFile.Create('');
  with RegIniFile do begin
    RootKey := HKEY_CURRENT_USER;
    RegIniFile.DeleteKey('Software\Microsoft\Windows\' +
                             'CurrentVersion\Run'#0,
                              WindowTitle);
    Free;
    //ConsoleMessage('Removed Autorun');
  end;

end;


end.
