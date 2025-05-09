program AppMCExporter;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.Application in '..\form\Form.Application.pas' {FormApplication},
  CurseForge.DLL in '..\object\curseforge\CurseForge.DLL.pas',
  CurseForge.Consts in '..\object\curseforge\CurseForge.Consts.pas',
  DLLLoader in '..\object\dllloader\DLLLoader.pas',
  CurseForge.Types in '..\object\curseforge\CurseForge.Types.pas',
  Helper.JSON in '..\object\helper\Helper.JSON.pas',
  Frame.Main in '..\frame\Frame.Main.pas' {FrameMain: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormApplication, FormApplication);
  Application.Run;
end.
