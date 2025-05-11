unit Frame.Main;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants,
  FMX.Controls,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.StdCtrls,
  FMX.Types,
  SubjectStand, FMX.Layouts, FMX.Controls.Presentation
  ;

type
  TFrameMain = class(TFrame)
    VSBCurseForgeInstance: TVertScrollBox;
    GLCurseForgeInstance: TGridLayout;
    LOption: TLayout;
    BSync: TButton;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    [BeforeShow] procedure OnBeforeShow;
  end;

implementation

uses
  CurseForge.Types,
  Form.Application,
  Frame.CurseForge.Instance
  ;

{$R *.fmx}

{ TFrameMain }

procedure TFrameMain.OnBeforeShow;
var
  rCurseForgeInstance: TCurseForgeInstance;
  rFrameCurseForgeInstance: TFrameCurseForgeInstance;
begin
  for rCurseForgeInstance in FormApplication.CurseForgeInstanceList do
  begin
    rFrameCurseForgeInstance                := TFrameCurseForgeInstance.Create(rCurseForgeInstance);
    rFrameCurseForgeInstance.Align          := TAlignLayout.Left;
    rFrameCurseForgeInstance.Margins.Top    := 4;
    rFrameCurseForgeInstance.Margins.Bottom := 4;
    rFrameCurseForgeInstance.Margins.Left   := 4;
    rFrameCurseForgeInstance.Margins.Right  := 4;
    rFrameCurseForgeInstance.Position.X     := MaxInt;
    rFrameCurseForgeInstance.Parent         := GLCurseForgeInstance;

    GLCurseForgeInstance.AddObject(rFrameCurseForgeInstance);
  end;
end;

end.
