unit Minecraft.Launcher.Functions;

interface

uses
  Minecraft.Launcher
  ;

function IsMinecraftLauncherInstalled: Boolean;
function GetMinecraftLauncherProfileList: PChar;
procedure SetMinecraftLauncehrProfileList(
  const AMinecraftLauncherProfileList: PChar
);

implementation

uses
  Helper.JSON,
  Minecraft.Launcher.Types,
  System.JSON,
  System.SysUtils
  ;

function IsMinecraftLauncherInstalled: Boolean;
begin
  Result := TMinecraftLauncher.IsInstalled;
end;

function GetMinecraftLauncherProfileList: PChar;
begin
  Result := StrNew(PChar(TMinecraftLauncher.GetProfileList.ToJSON.ToJSON));
end;

procedure SetMinecraftLauncehrProfileList(
  const AMinecraftLauncherProfileList: PChar
);
begin
  TMinecraftLauncher.SetProfileList(TMinecraftLauncherProfileList.FromJSON(TJSONArray.ParseJSONValue(AMinecraftLauncherProfileList)));
end;

end.
