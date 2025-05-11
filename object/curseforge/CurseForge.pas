unit CurseForge;

interface

type
  TCurseForge = class
  private
  protected
  public
    class function IsInstalled: Boolean;
    class function MinecraftRoot: string;
    class function MinecraftInstanceList: string;
    class function MinecraftInstancePath: string;
  end;

implementation

uses
  CurseForge.Consts,
  CurseForge.Types,
  Helper.Registry,
  System.JSON,
  System.IOUtils,
  System.SysUtils,
  System.Win.Registry
  ;

{ TCurseForge }

class function TCurseForge.IsInstalled: Boolean;
begin
  Result := TRegistry.IsApplicationInstalled(CurseForge.Consts.CURSEFORGE_DISPLAY_NAME);
end;

class function TCurseForge.MinecraftInstanceList: string;
var
  oCurseForgeInstanceList: TCurseForgeInstanceList;
  sDirectory: string;
begin
  Result := '';
  if (not TCurseForge.IsInstalled) then
    Exit;

  oCurseForgeInstanceList := TCurseForgeInstanceList.Create;
  try
    for sDirectory in TDirectory.GetDirectories(TCurseForge.MinecraftInstancePath) do
      oCurseForgeInstanceList.Add(TCurseForgeInstance.FromInstanceDirectory(sDirectory));
    Result := oCurseForgeInstanceList.ToJSON.ToJSON;
  finally
    FreeAndNil(oCurseForgeInstanceList);
  end;
end;

class function TCurseForge.MinecraftInstancePath: string;
begin
  Result := TPath.Combine(TCurseForge.MinecraftRoot, 'instances');
end;

class function TCurseForge.MinecraftRoot: string;
begin
  Result := '';

  if (not TCurseForge.IsInstalled) then
    Exit;

  Result := TRegistry.GetString(REGISTRY_KEY_CURRENT_USER, REGISTRY_CURSEFORGE_KEY_PATH, REGISTRY_CURSEFORGE_NAME_MINECRAFT_ROOT);
end;

end.
