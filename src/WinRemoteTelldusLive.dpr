program WinRemoteTelldusLive;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {FormMain},
  SettingsForm in 'SettingsForm.pas' {FormSettings},
  SettingsTelldusLive in 'SettingsTelldusLive.pas',
  Functions in 'Functions.pas',
  Procedures in 'Procedures.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'WinRemoteTelldusLive';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormSettings, FormSettings);
  Application.Run;
end.
