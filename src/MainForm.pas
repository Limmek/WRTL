unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.Imaging.pngimage, Registry, Inifiles, IPPeerClient, REST.Client,
  REST.Authenticator.OAuth, Data.Bind.Components, Data.Bind.ObjectScope,
  Vcl.ToolWin, Vcl.ComCtrls, System.Notification, Vcl.Grids,
  Vcl.Samples.Calendar, Vcl.CheckLst, DateUtils;

type
  TFormMain = class(TForm)
    Panel1: TPanel;
    ListBox1: TListBox;
    Panel2: TPanel;
    Memo1: TMemo;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    ImageDevices: TImage;
    ImageSettings: TImage;
    ImageEnable: TImage;
    ImageTemp: TImage;
    ImageDisable: TImage;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    OAuth1Authenticator1: TOAuth1Authenticator;
    Panel3: TPanel;
    Panel4: TPanel;
    Button2: TButton;
    Button3: TButton;
    PageControl1: TPageControl;
    TabSheetDeviceList: TTabSheet;
    TabSheetTaskbarList: TTabSheet;
    ListBox2: TListBox;
    NotificationCenter1: TNotificationCenter;
    PageControl2: TPageControl;
    TabSheetConsole: TTabSheet;
    TabSheetSchedule: TTabSheet;
    ComboBox1: TComboBox;
    Timer1: TTimer;
    StringGrid1: TStringGrid;
    ComboBox4: TComboBox;
    Button1: TButton;
    Panel5: TPanel;
    ComboBox2: TComboBox;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    ComboBox3: TComboBox;
    Label1: TLabel;
    TabSheetHotKey: TTabSheet;
    ListBox3: TListBox;
    Panel6: TPanel;
    ButtonAddHotkey: TButton;
    ListBox4: TListBox;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure OnMinimize(Sender:TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure ImageSettingsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImageUpdateClick(Sender: TObject);
    procedure OAuth1Authenticator1Authenticate(ARequest: TCustomRESTRequest;
      var ADone: Boolean);
    procedure ImageEnableClick(Sender: TObject);
    procedure ImageDisableClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TabSheetTaskbarListShow(Sender: TObject);
    procedure TabSheetDeviceListShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ImageDevicesClick(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageTempClick(Sender: TObject);
    procedure ImageSettingsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageSettingsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageDevicesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageDevicesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageTempMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageTempMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageEnableMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageEnableMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageDisableMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageDisableMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure LineAdd(aStringGrid: TStringGrid; aPos: integer);
    procedure Button1Click(Sender: TObject);
    procedure AutoSizeCol(Grid: TStringGrid; Column: integer);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure ButtonAddHotkeyClick(Sender: TObject);
    procedure ListBox3DblClick(Sender: TObject);
    procedure ListBox4DblClick(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
  private
    { Private declarations }
    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
  public
    { Public declarations }
  end;

  TMyThread = class(TThread)
  protected
    procedure Execute; override;
end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses SettingsForm, SettingsTelldusLive, Functions, Procedures;

var
  ConsumerKey, ConsumerSecret, AuthToken, AuthSecret, fixedCaption, fixedID, fixedName: String;
  fixedHotKey: Integer;
  Item: TMenuItem;

procedure TMyThread.Execute;
begin

end;


procedure TFormMain.StringGrid1DblClick(Sender: TObject);
begin
  if StringGrid1.RowCount >= 3 then
    DeleteCurrentRow(StringGrid1);
end;


procedure TFormMain.LineAdd(aStringGrid: TStringGrid; aPos: integer);
var
   sRowNext: Array of string;
   sRowPrev: Array of string;
   iIndex, iRow, iCol: Integer;
   sTime:String;
begin
     iIndex := aStringGrid.Row;
     aStringGrid.RowCount := aStringGrid.RowCount + 1;
     SetLength(sRowNext, aStringGrid.ColCount);
     SetLength(sRowPrev, aStringGrid.ColCount);

     for iCol := 0 to aStringGrid.ColCount - 1 do
         sRowNext[iCol] := ComboBox1.Text;
     for iCol := 1 to aStringGrid.ColCount - 1 do begin
        sTime := ComboBox2.Text+':'+ComboBox3.Text+':00';
        if StringGrid1.Cells[iCol,aStringGrid.RowCount-3]=sTime then begin
          //sRowNext[iCol] := ComboBox2.Text+':'+ComboBox3.Text+':'+ZeroFixTime(TrimLeadingZeros((((aStringGrid.RowCount-3).ToString+'0').ToInteger div 2).ToString));
          sRowNext[iCol] := ComboBox2.Text+':'+ComboBox3.Text+':'+ZeroFixTime(TrimLeadingZeros(((aStringGrid.RowCount-3).ToString+'0')));  // add 10 sec delay
        end else begin
          sRowNext[iCol] := sTime;
        end;
     end;
     for iCol := 2 to aStringGrid.ColCount - 1 do
         sRowNext[iCol] := ComboBox4.Text;

     for iRow := iIndex to aStringGrid.RowCount-1 do
         for iCol := 0 to aStringGrid.ColCount-1 do
         begin
              sRowPrev[iCol] := aStringGrid.Cells[iCol, iRow];
              aStringGrid.Cells[iCol, iRow] := sRowNext[iCol];
              sRowNext[iCol] := sRowPrev[iCol];
              //AutoSizeCol(aStringGrid,iCol);
         end;
     sRowNext := nil;
     sRowPrev := nil;

end;



procedure TFormMain.Button1Click(Sender: TObject);
begin
  try
  if ComboBox1.Text='' then
    Panel2.Caption := 'Load devices first!'
  else  begin
    if StrToInt(ComboBox3.Text) <= 9 then
      ComboBox3.Text := ZeroFixTime(TrimLeadingZeros(ComboBox3.Text));
    LineAdd(StringGrid1,1);
  end;
  finally
    StringGrid2File(StringGrid1,LocalAppDataConfigPath+SCHEDULE_FILE);
    ConsoleMessage('Added '+ComboBox1.Text+' to '+SCHEDULE_FILE);
  end;
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
    ListBox2.Items.Add(listbox1.items[listbox1.itemindex]);
    ListBox2.Items.SaveToFile(LocalAppDataConfigPath+DEVICES_LIST_FILE);
    Item := TMenuItem.Create(PopupMenu1);
    Item.Caption := listbox1.items[listbox1.itemindex];
    Item.OnClick := PopupClickAPICommand.Send;
    PopupMenu1.Items.Add(Item);
    ConsoleMessage('Added '+Item.Caption);
end;

procedure TFormMain.Button3Click(Sender: TObject);
var x:Integer;
begin
    ListBox2.Items.Delete(listbox2.itemindex);
    ListBox2.Items.SaveToFile(LocalAppDataConfigPath+DEVICES_LIST_FILE);
    ConsoleMessage('Removed '+Item.Caption);
    Button3.Enabled := False;
    PopupMenu1.Items.Clear;
    if fileexists(LocalAppDataConfigPath+DEVICES_LIST_FILE)    then begin
      ListBox2.Items.LoadFromFile(LocalAppDataConfigPath+DEVICES_LIST_FILE);
      ConsoleMessage('Reloading '+DEVICES_LIST_FILE);
      for x := 0 to listbox2.items.Count -1 do begin
        Item := TMenuItem.Create(PopupMenu1);
        Item.Caption := listbox2.items[x];
        Item.OnClick := PopupClickAPICommand.Send;
        PopupMenu1.Items.Add(Item);
      end;
    end;
end;

procedure TFormMain.ButtonAddHotkeyClick(Sender: TObject);
begin
  { Registering a hotkey Ctrl+Alt+F5 }
  //RegisterHotKey(Handle, 0, MOD_CONTROL or MOD_ALT, VK_F1);
  if ComboBox7.Text='Enable' then begin
    fixedHotKey := ListBox3.Count;
    ListBox3.Items.add('F'+IntToStr(1+(fixedHotKey))+' - '+ComboBox8.Text);
    AddHotKeyEnable(Handle,fixedHotKey);
    ConsoleMessage('Added '+ComboBox8.Text+' CTRL-ALT-F'+IntToStr(1+(fixedHotKey)));
  end
  else begin
    fixedHotKey := ListBox4.Count;//ComboBox5.Text+'-ALT-'+ComboBox6.Text;
    ListBox4.Items.add('F'+IntToStr(1+(fixedHotKey))+' - '+ComboBox8.Text);
    AddHotKeyDisable(Handle,fixedHotKey);
    ConsoleMessage('Added '+ComboBox8.Text+' SHIFT-ALT-F'+IntToStr(1+(fixedHotKey)));
  end;
  ListBox3.Items.SaveToFile(LocalAppDataConfigPath+HOTKEY_ENABLE_FILE);
  ListBox4.Items.SaveToFile(LocalAppDataConfigPath+HOTKEY_DISABLE_FILE);
end;

procedure TFormMain.AutoSizeCol(Grid: TStringGrid; Column: integer);
var
  i, W, WMax: integer;
begin
  WMax := 0;
  for i := 0 to (Grid.RowCount - 1) do begin
    W := Grid.Canvas.TextWidth(Grid.Cells[Column, i]);
    if W > WMax then
      WMax := W;
  end;
  Grid.ColWidths[Column] := WMax + 5;
end;

procedure TFormMain.FormActivate(Sender: TObject);
var I,O:Integer;
begin
  PageControl1.ActivePageIndex :=0; //Active tabb 1
  PageControl2.ActivePageIndex :=0; //Active tabb 2

  { SCHEDULE TABB }
  with stringgrid1 do  begin
    cells[0,0]:='Device';
    cells[1,0]:='Time';
    cells[2,0]:='Action';
  end;

  for I := 0 to 23 do
    ComboBox2.Items.Add(ZeroFixTime(I.ToString));

  for I := 0 to 60 do
    ComboBox3.Items.Add(ZeroFixTime(I.ToString));

  ComboBox4.Text := ComboBox4.Items[0];
  SendMessage(Memo1.Handle, EM_LINESCROLL, 0,Memo1.Lines.Count);

  { HOTKEYS TABB }
  ComboBox8.Text := ComboBox8.Items[0];
  if FileExists(ChangeFileExt(Application.ExeName, '.old')) then
    DeleteFile(ChangeFileExt(Application.ExeName, '.old'));
end;

procedure TFormMain.WMHotKey(var Msg: TWMHotKey);
var I,L:Integer;
begin
  { This procedure is called when a window message WM_HOTKEY }
  { We perform additional actions }
  inherited;  // We give the form to process the message, if she already has its handler
  Beep;
  for I := 0 to ListBox3.Count do begin
    if Cardinal(Msg.HotKey) = I then begin
      fixedCaption := ExtractText(ListBox3.Items[I],':','/');
      fixedID := StringReplace(fixedCaption,' ','',[rfReplaceAll, rfIgnoreCase]);
      fixedName := ExtractText(ListBox3.Items[I],'/','.');
      //ShowChoiseMessage(fixedID,fixedName);
      RESTRequest1.Params.AddItem('id',fixedID);
      RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_ON;
      try
        RESTRequest1.Execute;
      finally
        ConsoleMessage('ID: '+fixedID+' Name: '+fixedName);
        ConsoleMessage(RESTResponse1.JSONText);
        if FormSettings.CheckBox_WinNotification.Checked then
          RunNotification(fixedName+' Enabled');
      end;

    end;
  end;

  for L := 0 to ListBox4.Count do begin
    if Cardinal(Msg.HotKey) = (100+L) then begin
      fixedCaption := ExtractText(ListBox4.Items[L],':','/');
      fixedID := StringReplace(fixedCaption,' ','',[rfReplaceAll, rfIgnoreCase]);
      fixedName := ExtractText(ListBox4.Items[L],'/','.');
      //ShowChoiseMessage(fixedID,fixedName);
      RESTRequest1.Params.AddItem('id',fixedID);
      RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_OFF;
      try
        RESTRequest1.Execute;
      finally
        ConsoleMessage('ID: '+fixedID+' Name: '+fixedName);
        ConsoleMessage(RESTResponse1.JSONText);
        if FormSettings.CheckBox_WinNotification.Checked then
          RunNotification(fixedName+' Disabled');
      end;
    end;
  end;

end;

procedure TFormMain.FormCreate(Sender: TObject);
var x,I:Integer;
begin
  Application.OnMinimize := OnMinimize; //Remove from taskbar fix

  ConsoleMessage('Thanks for using '+Application.Title);
  ConsoleMessage('Version: '+GetAppVersionStr);

  { Load device list }
  ConsoleMessage('Looking for device list:');
  ConsoleMessage(LocalAppDataConfigPath+DEVICES_LIST_FILE);
  if Not DirectoryExists(LocalAppDataConfigPath) then begin
     CreateDir(LocalAppDataConfigPath);
     ConsoleMessage('Creating folder..');
  end;

  if FileExists(LocalAppDataConfigPath+DEVICES_LIST_FILE)    then begin
    ListBox2.Items.LoadFromFile(LocalAppDataConfigPath+DEVICES_LIST_FILE);
    ComboBox8.Items.LoadFromFile(LocalAppDataConfigPath+DEVICES_LIST_FILE); //Hotkey device name
    for x := 0 to listbox2.items.Count -1 do begin
      Item := TMenuItem.Create(PopupMenu1);
      Item.Caption := listbox2.items[x];
      Item.OnClick := PopupClickAPICommand.Send;
      PopupMenu1.Items.Add(Item);
      ConsoleMessage('Added: '+Item.Caption);
    end;
    ConsoleMessage(x.ToString+' devices loaded.');
  end;

  { Load schedule list }
  ConsoleMessage('Looking for schedule list:');
  ConsoleMessage(LocalAppDataConfigPath+SCHEDULE_FILE);
  if not FileExists(LocalAppDataConfigPath+SCHEDULE_FILE) then begin
    StringGrid2File(StringGrid1,LocalAppDataConfigPath+SCHEDULE_FILE);
    ConsoleMessage('Could not find '+SCHEDULE_FILE+' creating new..');
  end  else  begin
    File2StringGrid(StringGrid1,LocalAppDataConfigPath+SCHEDULE_FILE);
    ConsoleMessage('Loaded '+SCHEDULE_FILE+' Added '+(StringGrid1.RowCount-1).ToString+' schedules.');
  end;

  { Load hotkeys }
  if not (fileexists(LocalAppDataConfigPath+HOTKEY_ENABLE_FILE) and fileexists(LocalAppDataConfigPath+HOTKEY_DISABLE_FILE) ) then begin
    ConsoleMessage('Could not find '+HOTKEY_ENABLE_FILE+' or '+HOTKEY_DISABLE_FILE+' creating new..');
    ListBox3.Items.SaveToFile(LocalAppDataConfigPath+HOTKEY_ENABLE_FILE);
    ListBox4.Items.SaveToFile(LocalAppDataConfigPath+HOTKEY_DISABLE_FILE);
  end  else  begin
    ListBox3.Items.LoadFromFile(LocalAppDataConfigPath+HOTKEY_ENABLE_FILE);
    ListBox4.Items.LoadFromFile(LocalAppDataConfigPath+HOTKEY_DISABLE_FILE);
    ConsoleMessage('Loaded Hotkeys files. Added '+IntToStr(ListBox3.Count+ListBox4.Count)+' hotkeys.');
  end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
var I:Integer;
begin
  RESTClient1.Destroy;
  RESTRequest1.Destroy;
  RESTResponse1.Destroy;
  OAuth1Authenticator1.Destroy;
  PopupMenu1.Destroy;
  TrayIcon1.Destroy;
  NotificationCenter1.Destroy;
  ListBox2.Items.SaveToFile(LocalAppDataConfigPath+DEVICES_LIST_FILE);
  ListBox3.Items.SaveToFile(LocalAppDataConfigPath+HOTKEY_ENABLE_FILE);
  ListBox4.Items.SaveToFile(LocalAppDataConfigPath+HOTKEY_DISABLE_FILE);
  StringGrid2File(StringGrid1,LocalAppDataConfigPath+SCHEDULE_FILE);
  // Unregisters a hotkeys
  for I := 0 to ListBox3.Count do
    UnRegisterHotKey(Handle, I);
  for I := 0 to ListBox4.Count do
    UnRegisterHotKey(Handle, I);
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
  if FormMain.Width < 570 then
    FormMain.Width := 570;

  if FormMain.Height < 310 then
    FormMain.Height := 310;
end;

procedure TFormMain.ImageDevicesClick(Sender: TObject);
begin
    LoadDevices;
end;

procedure TFormMain.ImageDevicesMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    ImageDevices.Stretch := True;
end;

procedure TFormMain.ImageDevicesMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    ImageDevices.Stretch := False;
end;

procedure TFormMain.ImageDisableClick(Sender: TObject);
begin
    fixedID := StringReplace(SelectedTabbItemID,' ','',[rfReplaceAll, rfIgnoreCase]);
    fixedName := StringReplace(SelectedTabbItemName,' ','',[rfReplaceAll, rfIgnoreCase]);
    RESTRequest1.Params.AddItem('id',fixedID);
    RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_OFF;
    try
      RESTRequest1.Execute;
    finally
      ConsoleMessage('ID: '+fixedID+' Name: '+fixedName);
      ConsoleMessage(RESTResponse1.JSONText);
      if FormSettings.CheckBox_WinNotification.Checked then
        RunNotification(fixedName+' Disabled');
    end;
end;

procedure TFormMain.ImageDisableMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    ImageDisable.Stretch := True;
end;

procedure TFormMain.ImageDisableMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ImageDisable.Stretch := False;
end;

procedure TFormMain.ImageEnableClick(Sender: TObject);
begin
    fixedID := StringReplace(SelectedTabbItemID,' ','',[rfReplaceAll, rfIgnoreCase]);
    fixedName := StringReplace(SelectedTabbItemName,' ','',[rfReplaceAll, rfIgnoreCase]);
    RESTRequest1.Params.AddItem('id',fixedID);
    RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_ON;
    try
      RESTRequest1.Execute;
    finally
      ConsoleMessage('ID: '+fixedID+' Name: '+fixedName);
      ConsoleMessage(RESTResponse1.JSONText);
      if FormSettings.CheckBox_WinNotification.Checked then
        RunNotification(fixedName+' Enabled');
    end;
end;

procedure TFormMain.ImageEnableMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ImageEnable.Stretch := True;
end;

procedure TFormMain.ImageEnableMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ImageEnable.Stretch := False;
end;

procedure TFormMain.ImageSettingsClick(Sender: TObject);
begin
  FormSettings.Position := poMainFormCenter;
  FormSettings.Visible := True;
  FormSettings.WindowState := wsNormal;
  FormMain.WindowState := wsNormal;
  Application.BringToFront;
end;

procedure TFormMain.ImageSettingsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageSettings.Stretch := True;
end;

procedure TFormMain.ImageSettingsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ImageSettings.Stretch := False;
end;

procedure TFormMain.ImageTempClick(Sender: TObject);
begin
    LoadSensorer;
end;

procedure TFormMain.ImageTempMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ImageTemp.Stretch := True;
end;

procedure TFormMain.ImageTempMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ImageTemp.Stretch := False;
end;

procedure TFormMain.ImageUpdateClick(Sender: TObject);
begin
  LoadDevices;
end;

procedure TFormMain.ListBox1Click(Sender: TObject);
begin
  Button2.Enabled := True;
  ImageEnable.Enabled := True;
  ImageDisable.Enabled := True;
end;

procedure TFormMain.ListBox1DblClick(Sender: TObject);
begin
    fixedID := StringReplace(SelectedTabbItemID,' ','',[rfReplaceAll, rfIgnoreCase]);
    fixedName := StringReplace(SelectedTabbItemName,' ','',[rfReplaceAll, rfIgnoreCase]);
    ShowChoiseMessage(fixedID,fixedName);
end;

procedure TFormMain.ListBox2Click(Sender: TObject);
begin
  Button3.Enabled := True;
  ImageEnable.Enabled := True;
  ImageDisable.Enabled := True;
end;

procedure TFormMain.ListBox2DblClick(Sender: TObject);
begin
    TMyThread.Create(false);
    fixedID := StringReplace(SelectedTabbItemID,' ','',[rfReplaceAll, rfIgnoreCase]);
    fixedName := StringReplace(SelectedTabbItemName,' ','',[rfReplaceAll, rfIgnoreCase]);
    ShowChoiseMessage(fixedID,fixedName);
end;

procedure TFormMain.ListBox3DblClick(Sender: TObject);
begin
  ListBox3.Items.Delete(ListBox3.ItemIndex);
  UnRegisterHotKey(Handle, ListBox3.ItemIndex);
end;

procedure TFormMain.ListBox4DblClick(Sender: TObject);
begin
  ListBox4.Items.Delete(ListBox4.ItemIndex);
  UnRegisterHotKey(Handle, ListBox4.ItemIndex);
end;

procedure TFormMain.OAuth1Authenticator1Authenticate(
  ARequest: TCustomRESTRequest; var ADone: Boolean);
begin
  ConsumerKey := string(FormSettings.Edit_PUBLIC_KEY.Text);
  ConsumerSecret := string(FormSettings.Edit_PRIVATE_KEY.Text);
  AuthToken := string(FormSettings.Edit_TOKEN.Text);
  AuthSecret	:= string(FormSettings.Edit_TOKEN_SECRET.Text);

  FormMain.OAuth1Authenticator1.ConsumerKey :=  ConsumerKey;
  FormMain.OAuth1Authenticator1.ConsumerSecret :=  ConsumerSecret;
  FormMain.OAuth1Authenticator1.AccessToken :=  AuthToken;
  FormMain.OAuth1Authenticator1.AccessTokenSecret :=  AuthSecret;
  FormMain.OAuth1Authenticator1.RequestToken  :=  AuthToken;
  FormMain.OAuth1Authenticator1.RequestTokenSecret  :=  AuthSecret;
end;

procedure TFormMain.OnMinimize(Sender:TObject);
begin
  Hide;
end;

procedure TFormMain.PageControl2Change(Sender: TObject);
begin
  if TabSheetHotKey.Visible and FormSettings.CheckBoxEnableHotkeys.Enabled then begin
    Panel2.Caption := 'Hotkeys are disabled!';
  end else
    Panel2.Caption := '';
end;

procedure TFormMain.TabSheetDeviceListShow(Sender: TObject);
begin
  Button2.Enabled := False;
  Button3.Enabled := False;
end;

procedure TFormMain.TabSheetTaskbarListShow(Sender: TObject);
begin
  Button2.Enabled := False;
  Button3.Enabled := False;
end;

procedure TFormMain.Timer1Timer(Sender: TObject);
var I,iRow:Integer;
begin
  for iRow := 0 to stringgrid1.RowCount -1 do  begin
      if StringGrid1.Cells[1,iRow]=TimeToStr(Now) then  begin
        fixedID := StringReplace(ExtractText(StringGrid1.Cells[0,iRow],':','/'),' ','',[rfReplaceAll, rfIgnoreCase]);
        fixedName := StringReplace(ExtractText(StringGrid1.Cells[0,iRow],'/','.'),' ','',[rfReplaceAll, rfIgnoreCase]);
        if StringGrid1.Cells[2,iRow]='ON' then  begin
          RESTRequest1.Params.AddItem('id',fixedID);
          RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_ON;
          try
            RESTRequest1.Execute;
          finally
            ConsoleMessage('ID: '+fixedID+' Name: '+fixedName);
            ConsoleMessage(RESTResponse1.JSONText);
            if FormSettings.CheckBox_WinNotification.Checked then
              RunNotification(fixedName+' Enabled');
          end;
        end else if StringGrid1.Cells[2,iRow]='OFF' then begin
          RESTRequest1.Params.AddItem('id',fixedID);
          RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_OFF;
          try
            RESTRequest1.Execute;
          finally
            ConsoleMessage('ID: '+fixedID+' Name: '+fixedName);
            ConsoleMessage(RESTResponse1.JSONText);
            if FormSettings.CheckBox_WinNotification.Checked then
              RunNotification(fixedName+' Disabled');
          end;
        end;
      end;
  //When the procedure ends, the thread ends.
  end;
end;

procedure TFormMain.TrayIcon1DblClick(Sender: TObject);
begin
  Show;
  WindowState := wsNormal;
  Application.BringToFront;
end;

end.
