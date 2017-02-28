unit SettingsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, ShellApi,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, Vcl.Tabs, Registry;

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
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox_WinNotification: TCheckBox;
    ImageLogFile: TImage;
    CheckBox_LogToFile: TCheckBox;
    Label5: TLabel;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSettings: TFormSettings;

implementation

{$R *.dfm}

uses MainForm, Functions, Procedures, SettingsTelldusLive;



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
    ReadConfig;
  end;
  Label5.Caption:=API_URL;
  PageControl1.ActivePageIndex :=0;
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

end.
