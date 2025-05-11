unit Frame.Main;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.Layouts,
  FMX.StdCtrls,
  FMX.Types,
  Frame.CurseForge.Instance,
  SubjectStand
  ;

type
  TFrameMain = class(TFrame)
    VSBCurseForgeInstance: TVertScrollBox;
    GLCurseForgeInstance: TGridLayout;
    LOption: TLayout;
    BSync: TButton;
    procedure BSyncClick(Sender: TObject);
  private
    { Déclarations privées }
    FFrameCurseForgeInstanceList: TFrameCurseForgeInstanceList;
  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    [BeforeShow] procedure OnBeforeShow;
  end;

implementation

uses
  CurseForge.Types,
  Form.Application,
  Minecraft.Launcher.DLL,
  Minecraft.Launcher.Types
  ;

{$R *.fmx}

{ TFrameMain }

procedure TFrameMain.BSyncClick(Sender: TObject);
var
  rFrameCurseForgeInstance: TFrameCurseForgeInstance;
  rCurseForgeInstance: TCurseForgeInstance;
  oMinecraftLauncherDLL: TMinecraftLauncherDLL;
  oMinecraftLauncherProfileList: TMinecraftLauncherProfileList;
  rMinecraftLauncherProfile: TMinecraftLauncherProfile;
begin
  oMinecraftLauncherDLL := TMinecraftLauncherDLL.Create;
  try
    oMinecraftLauncherProfileList := oMinecraftLauncherDLL.ProfileList;
    try
      for rFrameCurseForgeInstance in FFrameCurseForgeInstanceList do
      begin
        rCurseForgeInstance       := rFrameCurseForgeInstance.CurseForgeInstance;
        rMinecraftLauncherProfile := oMinecraftLauncherProfileList.FromProfilName[rCurseForgeInstance.Name];
        if ((not rFrameCurseForgeInstance.Selected) and Assigned(rMinecraftLauncherProfile)) then
        begin
          oMinecraftLauncherProfileList.Remove(rMinecraftLauncherProfile);
          FreeAndNil(rMinecraftLauncherProfile);
        end
        else if (rFrameCurseForgeInstance.Selected and (not Assigned(rMinecraftLauncherProfile))) then
        begin
          rMinecraftLauncherProfile         := TMinecraftLauncherProfile.Create;
          rMinecraftLauncherProfile.Name    := rCurseForgeInstance.Name;
          rMinecraftLauncherProfile.Icon    := rCurseForgeInstance.Thumbnail;
          rMinecraftLauncherProfile.GameDir := rCurseForgeInstance.Path;
        end;
      end;
      oMinecraftLauncherDLL.ProfileList := oMinecraftLauncherProfileList;
    finally
      FreeAndNil(oMinecraftLauncherProfileList);
    end;
  finally
    FreeAndNil(oMinecraftLauncherDLL);
  end;

end;

constructor TFrameMain.Create(AOwner: TComponent);
begin
  inherited;
  FFrameCurseForgeInstanceList := TFrameCurseForgeInstanceList.Create;
end;

destructor TFrameMain.Destroy;
begin
  FreeAndNil(FFrameCurseForgeInstanceList);
  inherited;
end;

procedure TFrameMain.OnBeforeShow;
var
  rCurseForgeInstance: TCurseForgeInstance;
  rFrameCurseForgeInstance: TFrameCurseForgeInstance;
begin
  for rCurseForgeInstance in FormApplication.CurseForgeInstanceList do
  begin
    rFrameCurseForgeInstance                    := TFrameCurseForgeInstance.Create(nil);
    rFrameCurseForgeInstance.Align              := TAlignLayout.Left;
    rFrameCurseForgeInstance.Margins.Top        := 4;
    rFrameCurseForgeInstance.Margins.Bottom     := 4;
    rFrameCurseForgeInstance.Margins.Left       := 4;
    rFrameCurseForgeInstance.Margins.Right      := 4;
    rFrameCurseForgeInstance.Position.X         := MaxInt;
    rFrameCurseForgeInstance.Parent             := GLCurseForgeInstance;
    rFrameCurseForgeInstance.CurseForgeInstance := rCurseForgeInstance;

    GLCurseForgeInstance.AddObject(rFrameCurseForgeInstance);
    FFrameCurseForgeInstanceList.Add(rFrameCurseForgeInstance);
  end;
end;

end.
