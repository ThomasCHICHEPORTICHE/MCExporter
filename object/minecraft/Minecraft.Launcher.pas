unit Minecraft.Launcher;

interface

uses
  Minecraft.Launcher.Types
  ;

type
  TMinecraftLauncher = class
  private
  protected
  public
    class function IsInstalled: Boolean;
    class function GetProfileList: TMinecraftLauncherProfileList;
    class procedure SetProfileList(const AProfileList: TMinecraftLauncherProfileList);
  end;

implementation

uses
  Minecraft.Launcher.Consts,
  Helper.Registry,
  Helper.JSON,
  System.IOUtils,
  System.JSON,
  System.SysUtils,
  System.Win.Registry
  ;

{ TMinecraftLauncher }

class function TMinecraftLauncher.IsInstalled: Boolean;
begin
  Result := TRegistry.IsApplicationInstalled(Minecraft.Launcher.Consts.MINECRAFT_LAUNCHER_DISPLAYNAME);
end;

class procedure TMinecraftLauncher.SetProfileList(
  const AProfileList: TMinecraftLauncherProfileList
);
var
  sMinecraftLauncherProfilesJSON: string;
begin
  sMinecraftLauncherProfilesJSON := TPath.Combine(TPath.GetHomePath, Minecraft.Launcher.Consts.MINECRAFT_ROOT_DIRECTORY, Minecraft.Launcher.Consts.MINECRAFT_LAUNCHER_PROFILES_JSON);
  if (not TFile.Exists(sMinecraftLauncherProfilesJSON)) then
    raise EMinecraftLauncherException.CreateFmt('Error : %s not found !', [sMinecraftLauncherProfilesJSON]);

  TFile.WriteAllText(sMinecraftLauncherProfilesJSON, AProfileList.ToJSON.ToJSON);
end;

class function TMinecraftLauncher.GetProfileList: TMinecraftLauncherProfileList;
var
  sMinecraftLauncherProfilesJSON: string;
begin
  sMinecraftLauncherProfilesJSON := TPath.Combine(TPath.GetHomePath, Minecraft.Launcher.Consts.MINECRAFT_ROOT_DIRECTORY, Minecraft.Launcher.Consts.MINECRAFT_LAUNCHER_PROFILES_JSON);
  if (not TFile.Exists(sMinecraftLauncherProfilesJSON)) then
    raise EMinecraftLauncherException.CreateFmt('Error : %s not found !', [sMinecraftLauncherProfilesJSON]);

  Result := TMinecraftLauncherProfileList.FromMinecraftLauncherProfilesJSON(sMinecraftLauncherProfilesJSON);
end;

end.
