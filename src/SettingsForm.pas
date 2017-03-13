unit SettingsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, ShellApi,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, Vcl.Tabs, Registry, IdBaseComponent, Vcl.Graphics,
  IdComponent, IdTCPConnection, IdTCPClient, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.Types;

type
  TFormSettings = class(TForm)
    CheckBox_AutoLoadDevices: TCheckBox;
    CheckBox_SartWithWindows: TCheckBox;
    CheckBox_StartMinimized: TCheckBox;
    ImageLocalFolder: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    ImageSave: TImage;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ImageRegedit: TImage;
    ImageGit: TImage;
    LabelGit: TLabel;
    LabelAuthor: TLabel;
    LabelVersion: TLabel;
    LabelAbout: TLabel;
    Edit_PUBLIC_KEY: TEdit;
    Edit_PRIVATE_KEY: TEdit;
    Edit_TOKEN_SECRET: TEdit;
    Edit_TOKEN: TEdit;
    CheckBox_WinNotification: TCheckBox;
    ImageLogFile: TImage;
    CheckBox_AutoUpdate: TCheckBox;
    Label5: TLabel;
    CheckBoxEnableHotkeys: TCheckBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    LabelCheckForUpdate: TLabel;
    ProgressBarDownload: TProgressBar;
    LabelGlobalSpeed: TLabel;
    CheckBox_LogToFile: TCheckBox;
    procedure ImageLocalFolderClick(Sender: TObject);
    procedure ImageSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImageRegeditClick(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure LabelGitClick(Sender: TObject);
    procedure ImageLogFileClick(Sender: TObject);
    procedure ImageSaveMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageSaveMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageLogFileMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageLogFileMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageRegeditMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageRegeditMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageLocalFolderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageLocalFolderMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label5Click(Sender: TObject);
    procedure LabelCheckForUpdateClick(Sender: TObject);
    procedure ReceiveDataEvent(const Sender: TObject; AContentLength: Int64; AReadCount: Int64; var Abort: Boolean);
  private
    { Private declarations }
      FClient: THTTPClient;
      FGlobalStart: Cardinal;
      FAsyncResponse: IHTTPResponse;
      FDownloadStream: TStream;
      procedure DoEndDownload(const AsyncResult: IAsyncResult);
  public
    { Public declarations }
    procedure DownloadNewFile;
  end;

var
  FormSettings: TFormSettings;

implementation


{$R *.dfm}

uses MainForm, Functions, Procedures, SettingsTelldusLive,
System.IOUtils;


procedure TFormSettings.FormCreate(Sender: TObject);
begin
  ConsoleMessage('Checking config:');
  ConsoleMessage(LocalAppDataConfigFile);
  if not CheckConfigExist then begin
    ConsoleMessage('Config not found. Creating file...');
    WriteConfig;
    ConsoleMessage('Config created!');
    FormSettings.Visible := True;
    FormSettings.Position := poDesktopCenter;
  end
  else  begin
    ConsoleMessage('Loading settings');
    ConsoleMessage(LocalAppDataConfigPath+Application.Title+CONFIG_EXT);
    ReadConfig;
  end;
  Label5.Caption:=API_URL;
  PageControl1.ActivePageIndex :=0;

  FClient := THTTPClient.Create;
  FClient.OnReceiveData := ReceiveDataEvent;

  if FormSettings.CheckBox_AutoUpdate.Checked then
      FormSettings.LabelCheckForUpdate.OnClick(Self);

end;

procedure TFormSettings.ImageLocalFolderClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'runas', 'explorer.exe', PChar(LocalAppDataConfigPath), nil, SW_NORMAL);
end;

procedure TFormSettings.ImageLocalFolderMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    ImageLocalFolder.Stretch := True;
end;

procedure TFormSettings.ImageLocalFolderMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    ImageLocalFolder.Stretch := False;
end;

procedure TFormSettings.ImageLogFileClick(Sender: TObject);
begin
  if CheckBox_LogToFile.Checked and FileExists(LocalAppDataConfigPath+LOGFILE_FOLDER+DateToStr(now)+LOGFILE_EXT) then  begin
    ShellExecute(Application.Handle, 'open', 'notepad.exe', PChar(LocalAppDataConfigPath+LOGFILE_FOLDER+DateToStr(now)+LOGFILE_EXT), nil, SW_NORMAL);
  end
  else
    ShowMessage('Enable logging first!');
end;

procedure TFormSettings.ImageLogFileMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   ImageLogFile.Stretch := True;
end;

procedure TFormSettings.ImageLogFileMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageLogFile.Stretch := False;
end;

procedure TFormSettings.ImageRegeditClick(Sender: TObject);
var
  Reg: TRegistry;
  WindowsFilePath, LastKey, KeyToFind, ValueToWrite : String;
begin
  ValueToWrite := 'HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run';
  KeyToFind := 'SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Regedit';

  Reg:= TRegistry.Create;
  try
    if Reg.KeyExists(KeyToFind) then
      ConsoleMessage('found '+ KeyToFind)
    else
      ConsoleMessage('not found '+ KeyToFind);
    if Reg.OpenKey(KeyToFind, False) then  begin
      ConsoleMessage(KeyToFind+ ' opened ok');
      LastKey := Reg.ReadString('LastKey');
      ConsoleMessage('Last key: '+ LastKey);
      Reg.WriteString('LastKey', ValueToWrite);
    end
    else begin
      ConsoleMessage('failed to open key: '+ KeyToFind);
    end;

  finally

    {OPEN REGEDIT}
    try
      Reg.Rootkey:= HKEY_LOCAL_MACHINE;
      Reg.Openkey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion', FALSE);
      WindowsFilePath:= Reg.ReadString('SystemRoot');
    finally
      Reg.Free;
      ShellExecute(Application.Handle, 'runas' ,PChar(Concat(WindowsFilePath,'\system32\regedit.exe')),'','',SW_SHOW);
    end;

  end;
end;

procedure TFormSettings.ImageRegeditMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   ImageRegedit.Stretch := True;
end;

procedure TFormSettings.ImageRegeditMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   ImageRegedit.Stretch := False;
end;

procedure TFormSettings.ImageSaveClick(Sender: TObject);
begin
  FormSettings.Visible := False;
  WriteConfig;
  ConsoleMessage('Settings saved');
  ReadConfig;
  ConsoleMessage('Loading settings');
  FormSettings.WindowState := wsNormal;
  FormMain.WindowState := wsNormal;
  Application.BringToFront;
end;

procedure TFormSettings.ImageSaveMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageSave.Stretch := True;
end;

procedure TFormSettings.ImageSaveMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ImageSave.Stretch := False;
end;

procedure TFormSettings.Label5Click(Sender: TObject);
begin
  ShellExecute(0, 'Open', PChar(API_URL), nil, nil, SW_SHOWNORMAL);
end;

procedure TFormSettings.LabelCheckForUpdateClick(Sender: TObject);
var
  buttonSelected : Integer;
  CheckVer, CurVer:String;
begin
  CheckVer := trim(CheckVersion(VERSION_URL));
  CurVer := trim(GetAppVersionStr);
  ConsoleMessage('Checking for update..');
  if not (CheckVer = CurVer) then begin
    ConsoleMessage('Current version: '+CurVer);
    ConsoleMessage('Latest version: '+CheckVer);
    buttonSelected := MyMessageDlg('New version available '+CheckVer, mtCustom, [mbYes, mbNo], ['Update','Run anyway'], Application.Title);
    if buttonSelected = mrNo    then begin
      ConsoleMessage('Update aborted!');
    end;

    if buttonSelected = mrYes    then begin
      ConsoleMessage('Downloading new version '+CheckVer);
      DownloadNewFile;
    end;
  end;
end;

procedure TFormSettings.LabelGitClick(Sender: TObject);
begin
  ShellExecute(0, 'Open', PChar(ABOUT_GIT), nil, nil, SW_SHOWNORMAL);
end;

procedure TFormSettings.TabSheet2Show(Sender: TObject);
begin
  LabelGit.Caption := ABOUT_GIT;
  LabelVersion.Caption := 'Version: '+GetAppVersionStr;
  LabelAuthor.Caption := 'Creator: Jim A';
  LabelAbout.Caption := ABOUT_INFO;
end;

procedure TFormSettings.DownloadNewFile;
var
  LResponse: IHTTPResponse;
  LFileName, bakName, URL: string;
  LSize: Int64;
begin
  bakName := ChangeFileExt(Application.ExeName, '.old');
  LFileName := Application.ExeName;
  if FileExists(bakName) then
    DeleteFile(bakName);
  RenameFile (Application.ExeName, bakName);
  try
    FAsyncResponse := nil;
    URL := DOWNLOAD_URL;

    LResponse := FClient.Head(URL);
    LSize := LResponse.ContentLength +1000000;
    ConsoleMessage(Format('Head response: %d - %s', [LResponse.StatusCode, LResponse.StatusText]));
    LResponse := nil;

    LabelGlobalSpeed.Visible := True;
    ProgressBarDownload.Visible := True;
    ProgressBarDownload.Max := LSize;
    ProgressBarDownload.Min := 0;
    ProgressBarDownload.Position := 0;
    LabelGlobalSpeed.Caption := 'Global speed: 0 KB/s';

    // Create the file that is going to be dowloaded
    FDownloadStream := TFileStream.Create(LFileName, fmCreate);
    FDownloadStream.Position := 0;

    FGlobalStart := TThread.GetTickCount;

    // Start the download process
    FAsyncResponse := FClient.BeginGet(DoEndDownload, URL, FDownloadStream);

  finally
    LabelCheckForUpdate.Enabled := FAsyncResponse = nil;
    FAsyncREsponse := nil;
  end;
end;

procedure TFormSettings.DoEndDownload(const AsyncResult: IAsyncResult);
begin
  try
    FAsyncResponse := THTTPClient.EndAsyncHTTP(AsyncResult);
    TThread.Synchronize(nil,
      procedure
      begin
        ConsoleMessage('Download Finished!');
        ConsoleMessage(Format('Status: %d - %s', [FAsyncResponse.StatusCode, FAsyncResponse.StatusText]));
      end);
  finally
    FDownloadStream.Free;
    FDownloadStream := nil;
    ProgressBarDownload.Position := ProgressBarDownload.Max;
    LabelCheckForUpdate.Enabled := True;
    Sleep(1000);
    ShellExecute(Handle, 'runas', PChar(Application.ExeName), PChar(ExtractFilePath(Application.ExeName)), nil, SW_NORMAL);
    Application.Terminate;
    Close;
    ExitProcess(0);
  end;

end;

procedure TFormSettings.ReceiveDataEvent(const Sender: TObject; AContentLength, AReadCount: Int64;
  var Abort: Boolean);
var
  LTime: Cardinal;
  LSpeed: Integer;
  LCancel: Boolean;
begin
  LCancel := Abort;
  LTime := TThread.GetTickCount - FGlobalStart;
  LSpeed := (AReadCount * 1000) div LTime;
  TThread.Queue(nil,
    procedure
    begin
      LCancel := not LabelCheckForUpdate.Enabled;
      ProgressBarDownload.Position := AReadCount;
      //ProgressBarDownload.StepIt();
      LabelGlobalSpeed.Caption := Format('Global speed: %d KB/s', [LSpeed div 1024]);
      FormMain.Panel2.Caption := Format('Global speed: %d KB/s', [LSpeed div 1024]);
    end);
  Abort := LCancel;
end;

end.
