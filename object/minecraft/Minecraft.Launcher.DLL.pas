unit Minecraft.Launcher.DLL;

interface

uses
  DLLLoader,
  Minecraft.Launcher.Types
  ;

type
  TMinecraftLauncherDLL = class(TDLLLoader)
  private
    function GetIsInstalled: Boolean;
    function GetProfileList: TMinecraftLauncherProfileList;
    procedure SetProfileList(const Value: TMinecraftLauncherProfileList);
  protected
  public
    property IsInstalled: Boolean read GetIsInstalled;
    property ProfileList: TMinecraftLauncherProfileList read GetProfileList write SetProfileList;

    constructor Create; reintroduce;
  end;

implementation

uses
  Helper.JSON,
  Minecraft.Launcher.Consts,
  System.JSON
  ;

{ TMinecraftLauncherDLL }

constructor TMinecraftLauncherDLL.Create;
begin
  inherited Create(Minecraft.Launcher.Consts.MINECRAFT_LAUNCHER_DLL_FILENAME);
end;

function TMinecraftLauncherDLL.GetIsInstalled: Boolean;
var
  rMinecraftLauncherIsInstalled: TFunctionIsMinecraftLauncherInstalled;
begin
  try
    rMinecraftLauncherIsInstalled := Proc[Minecraft.Launcher.Consts.FUNCTION_IS_MINECRAFT_LAUNCHER_INSTALLED];
    Result := rMinecraftLauncherIsInstalled;
  except
    Result := False;
  end;
end;

function TMinecraftLauncherDLL.GetProfileList: TMinecraftLauncherProfileList;
var
  rMinecraftLauncherGetprofileList: TFunctionGetMinecraftLauncherProfileList;
begin
  try
    rMinecraftLauncherGetprofileList := Proc[Minecraft.Launcher.Consts.FUNCTION_GET_MINECRAFT_LAUNCHER_PROFILE_LIST];
    Result := TMinecraftLauncherProfileList.FromJSON(TJSONArray.ParseJSONValue(rMinecraftLauncherGetprofileList));
  except
    Result := nil;
  end;
end;

procedure TMinecraftLauncherDLL.SetProfileList(
  const Value: TMinecraftLauncherProfileList
);
var
  rMinecraftLauncherSetprofileList: TProcedureSetMinecraftLauncherProfileList;
begin
  rMinecraftLauncherSetprofileList := Proc[Minecraft.Launcher.Consts.PROCEDURE_SET_MINECRAFT_LAUNCHER_PROFILE_LIST];
  rMinecraftLauncherSetprofileList(PChar(Value.ToJSON))
end;

end.
