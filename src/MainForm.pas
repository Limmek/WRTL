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
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ListBox2: TListBox;
    NotificationCenter1: TNotificationCenter;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
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
    procedure TabSheet2Show(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
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
    procedure CheckBox1Click(Sender: TObject);
    procedure LineAdd(aStringGrid: TStringGrid; aPos: integer);
    procedure Button1Click(Sender: TObject);
    procedure AutoSizeCol(Grid: TStringGrid; Column: integer);
    procedure StringGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PopupClickAPICommand(Sender: TObject);
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses SettingsForm, SettingsTelldusLive, Functions, Procedures;

var
  ConsumerKey, ConsumerSecret, AuthToken, AuthSecret, FilePath: String;
  Item: TMenuItem;
  buttonSelected : Integer;
  fixedCaption, fixedID, fixedName: String;

procedure TFormMain.PopupClickAPICommand(Sender: TObject);
begin
    fixedCaption := ExtractText(FormMain.ListBox2.Items[TMenuItem(Sender).MenuIndex],':','/');
    fixedID := StringReplace(fixedCaption,' ','',[rfReplaceAll, rfIgnoreCase]);
    fixedName := ExtractText(FormMain.ListBox2.Items[TMenuItem(Sender).MenuIndex],'/','.');
    buttonSelected := MessageDlg('Enable or Disable ID: '+fixedID,mtCustom,
                              [mbYes,mbNo], 0);
    if buttonSelected = mrYes    then begin
      ConsoleNewMessage('ID: '+fixedID+' Enabled');
      FormMain.RESTRequest1.Params.AddItem('id',fixedID);
      FormMain.RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_ON;
      FormMain.RESTRequest1.Execute;
      ConsoleMessage(FormMain.RESTResponse1.JSONText);
      if FormSettings.CheckBox_WinNotification.Checked then
        RunNotification(fixedName+' Enabled');
    end;

    if buttonSelected = mrNo    then  begin
      ConsoleNewMessage('ID: '+fixedID+' Disabled');
      FormMain.RESTRequest1.Params.AddItem('id',fixedID);
      FormMain.RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_OFF;
      FormMain.RESTRequest1.Execute;
      ConsoleMessage(FormMain.RESTResponse1.JSONText);
      if FormSettings.CheckBox_WinNotification.Checked then
        RunNotification(fixedName+' Disabled');
    end;
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
  if ComboBox1.Text='' then
    Panel2.Caption := 'Load devices first!'
  else  begin
    if StrToInt(ComboBox3.Text) <= 9 then
      ComboBox3.Text := ZeroFixTime(TrimLeadingZeros(ComboBox3.Text));
    LineAdd(StringGrid1,1);
  end;
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
    ListBox2.Items.Add(listbox1.items[listbox1.itemindex]);
    ListBox2.Items.SaveToFile(LocalAppDataConfigPath+DEVICES_LIST_FILE);
    Item := TMenuItem.Create(PopupMenu1);
    Item.Caption := listbox1.items[listbox1.itemindex];
    Item.OnClick := PopupClickAPICommand;
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
        Item.OnClick := PopupClickAPICommand;
        PopupMenu1.Items.Add(Item);
      end;
    end;
end;

procedure TFormMain.CheckBox1Click(Sender: TObject);
begin
  ConsoleMessage('asd');
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
var I:Integer;
begin
  ListBox2.Items.SaveToFile(LocalAppDataConfigPath+DEVICES_LIST_FILE);
  with stringgrid1 do  begin
  cells[0,0]:='Device';
  cells[1,0]:='Time';
  cells[2,0]:='Action';

  //cells[0,1]:='';
  //cells[1,1]:=ListBox2.Items[0];
  //cells[2,1]:=TimeToStr(Now);
  //cells[3,1] := '';

  end;
  //for I := 0 to ListBox2.Items.Count -1 do
    //ComboBox1.Items.Add(ListBox2.Items[I]);

  for I := 0 to 23 do
    ComboBox2.Items.Add(ZeroFixTime(I.ToString));

  for I := 0 to 60 do
    ComboBox3.Items.Add(ZeroFixTime(I.ToString));

  //ComboBox1.Text := ListBox2.Items[0];
  ComboBox2.Text := '12';
  ComboBox3.Text := '00';
  ComboBox4.Text := ComboBox4.Items[0];
  PageControl1.ActivePageIndex :=0;
  PageControl2.ActivePageIndex :=1;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var x:Integer;
begin
  Application.OnMinimize := OnMinimize;
  FilePath := ExtractFilePath(Application.ExeName);
  ConsoleMessage('Thanks for using '+Application.Title);
  ConsoleMessage('Version: '+GetAppVersionStr);
  ConsoleMessage('Looking for devices:');
  ConsoleMessage(LocalAppDataConfigPath+DEVICES_LIST_FILE);
  if fileexists(LocalAppDataConfigPath+DEVICES_LIST_FILE)    then begin
    ListBox2.Items.LoadFromFile(LocalAppDataConfigPath+DEVICES_LIST_FILE);
    for x := 0 to listbox2.items.Count -1 do begin
      Item := TMenuItem.Create(PopupMenu1);
      Item.Caption := listbox2.items[x];
      Item.OnClick := PopupClickAPICommand;
      PopupMenu1.Items.Add(Item);
      ConsoleMessage('Added: '+Item.Caption);
    end;
  end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  RESTClient1.Destroy;
  RESTRequest1.Destroy;
  RESTResponse1.Destroy;
  OAuth1Authenticator1.Destroy;
  PopupMenu1.Destroy;
  TrayIcon1.Destroy;
  NotificationCenter1.Destroy;
  ListBox2.Items.SaveToFile(LocalAppDataConfigPath+DEVICES_LIST_FILE);
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
    RESTRequest1.Execute;
    ConsoleNewMessage('ID: '+fixedID+' Disabled');
    ConsoleMessage(RESTResponse1.JSONText);
    if FormSettings.CheckBox_WinNotification.Checked then
      RunNotification(fixedName+' Disabled');
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
    RESTRequest1.Execute;
    ConsoleNewMessage('ID: '+fixedID+' Enabled');
    ConsoleMessage(RESTResponse1.JSONText);
    if FormSettings.CheckBox_WinNotification.Checked then
      RunNotification(fixedName+' Enabled');
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
    buttonSelected := MessageDlg('Chose what to do with '+fixedID,mtCustom,
                              [mbYes,mbNo], 0);
    if buttonSelected = mrYes    then begin
      ConsoleNewMessage('ID: '+fixedID+' Enabled');
      RESTRequest1.Params.AddItem('id',fixedID);
      RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_ON;
      RESTRequest1.Execute;
      ConsoleMessage(RESTResponse1.JSONText);
      if FormSettings.CheckBox_WinNotification.Checked then
        RunNotification(fixedName+' Enabled');
    end;

    if buttonSelected = mrNo    then  begin
      ConsoleNewMessage('ID: '+fixedID+' Disabled');
      RESTRequest1.Params.AddItem('id',fixedID);
      RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_OFF;
      RESTRequest1.Execute;
      ConsoleMessage(RESTResponse1.JSONText);
      if FormSettings.CheckBox_WinNotification.Checked then
        RunNotification(fixedName+' Disabled');
    end;
    //ConsoleMessage('ID: '+fixedID);
end;

procedure TFormMain.ListBox2Click(Sender: TObject);
begin
  Button3.Enabled := True;
  ImageEnable.Enabled := True;
  ImageDisable.Enabled := True;
end;

procedure TFormMain.ListBox2DblClick(Sender: TObject);
begin
    fixedID := StringReplace(SelectedTabbItemID,' ','',[rfReplaceAll, rfIgnoreCase]);
    fixedName := StringReplace(SelectedTabbItemName,' ','',[rfReplaceAll, rfIgnoreCase]);
    buttonSelected := MessageDlg('Chose what to do with '+fixedID,mtCustom,
                              [mbYes,mbNo], 0);
    if buttonSelected = mrYes    then begin
      ConsoleNewMessage(fixedID+' Enabled');
      RESTRequest1.Params.AddItem('id',fixedID);
      RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_ON;
      RESTRequest1.Execute;
      ConsoleMessage(RESTResponse1.JSONText);
      if FormSettings.CheckBox_WinNotification.Checked then
        RunNotification(fixedName+' Enabled');
    end;

    if buttonSelected = mrNo    then  begin
      ConsoleNewMessage(fixedID+' Disabled');
      RESTRequest1.Params.AddItem('id',fixedID);
      RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_OFF;
      RESTRequest1.Execute;
      ConsoleMessage(RESTResponse1.JSONText);
      if FormSettings.CheckBox_WinNotification.Checked then
        RunNotification(fixedName+' Disabled');
    end;
    //ConsoleMessage('ID: '+fixedID);
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

procedure TFormMain.TabSheet1Show(Sender: TObject);
begin
  Button2.Enabled := False;
  Button3.Enabled := False;
end;

procedure TFormMain.TabSheet2Show(Sender: TObject);
begin
  Button2.Enabled := False;
  Button3.Enabled := False;
end;

procedure TFormMain.Timer1Timer(Sender: TObject);
var iRow:Integer;
begin
  for iRow := 0 to stringgrid1.RowCount -1 do  begin
      if StringGrid1.Cells[1,iRow]=TimeToStr(Now) then  begin
        fixedID := StringReplace(ExtractText(StringGrid1.Cells[0,iRow],':','/'),' ','',[rfReplaceAll, rfIgnoreCase]);
        fixedName := StringReplace(ExtractText(StringGrid1.Cells[0,iRow],'/','.'),' ','',[rfReplaceAll, rfIgnoreCase]);
        if StringGrid1.Cells[2,iRow]='ON' then  begin
          RESTRequest1.Params.AddItem('id',fixedID);
          RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_ON;
          RESTRequest1.Execute;
          ConsoleNewMessage(fixedName+' Enabled');
          ConsoleMessage(RESTResponse1.JSONText);
          //if FormSettings.CheckBox_WinNotification.Checked then
          RunNotification(fixedName+' Enabled');
        end else if StringGrid1.Cells[2,iRow]='OFF' then begin
          RESTRequest1.Params.AddItem('id',fixedID);
          RESTClient1.BaseURL := API_URL + REQUEST_JSON + DEVICE_OFF;
          RESTRequest1.Execute;
          ConsoleNewMessage(fixedName+' Disabled');
          ConsoleMessage(RESTResponse1.JSONText);
          //if FormSettings.CheckBox_WinNotification.Checked then
          RunNotification(fixedName+' Disabled');
        end;
      end;
  end;
end;

procedure TFormMain.TrayIcon1DblClick(Sender: TObject);
begin
  Show;
  WindowState := wsNormal;
  Application.BringToFront;
end;

end.
