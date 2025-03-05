program ChangeProject;

uses
  Vcl.Forms,
  CnahgeUnit in 'CnahgeUnit.pas' {ChangeForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TChangeForm, ChangeForm);
  Application.Run;
end.
