unit Procedures;

interface

uses
  MainForm, SettingsForm, Functions, SettingsTelldusLive,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Taskbar,
  IPPeerClient, REST.Client, REST.Authenticator.OAuth, Data.Bind.Components, Data.Bind.ObjectScope, JSON, DBXJSON,
  Vcl.Grids, Vcl.Menus, Math, Vcl.Buttons, Inifiles, Registry, shlobj, System.Notification;


procedure WriteConfig;
procedure ReadConfig;
procedure LoadSensorer;
procedure LoadDevices;
procedure RunOnStartup(WindowTitle,CommandLn  : String; RunOnlyOnce: Boolean);
procedure RemoveOnStartup(WindowTitle,CommandLn  : String; RunOnlyOnce: Boolean);
procedure ConsoleMessage(msg:String);
procedure ConsoleNewMessage(msg:String);
procedure Log(const Msg: string); overload;
procedure RunNotification(AlertMsg:String);
procedure DeleteCurrentRow(Grid: TStringGrid);

implementation

var
  Ini : TIniFile;
  JSONObject: TJSONObject;
  JSONArray: TJSONArray;
  //JSONValue : TJSONValue;
  devices: TJSONObject;

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
    AssignFile(F, LocalAppDataConfigPath+DateToStr(now)+LOGFILE_EXT);
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

procedure ConsoleMessage(msg:String);
begin
  FormMain.Memo1.Lines.Add(msg);
  msg:=DateTimeToStr(Now)+': '+msg;
  if LOGGING then Log(msg);
end;

procedure ConsoleNewMessage(msg:String);
begin
  FormMain.Memo1.Text := msg;
  if LOGGING then Log(msg);
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
  finally
    Ini.Free;
  end;
end;

procedure ReadConfig;
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

  finally
    Ini.Free;
  end;
end;

procedure LoadSensorer;
begin
  FormMain.RESTClient1.BaseURL := API_URL + REQUEST_JSON + SENSOR_LIST;
  FormMain.RESTRequest1.Execute;
  ConsoleNewMessage(FormMain.RESTResponse1.JSONText);
  FormMain.Memo1.ScrollBars := ssVertical;
end;

procedure LoadDevices;
var
  idx: integer;
  //idy: integer;
begin
  FormMain.RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICES_LIST;
  FormMain.RESTRequest1.Execute;
  ConsoleNewMessage(FormMain.RESTResponse1.JSONText);
  FormMain.Memo1.ScrollBars := ssVertical;
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
