unit Minecraft.Launcher.Types;

interface

uses
  System.Generics.Collections,
  System.JSON,
  System.SysUtils
  ;

type
  EMinecraftLauncherException = class(Exception);
  TMinecraftLauncherProfile = class
  private
    FName: string;
    FProfilType: string;
    FCreated: string;
    FLastUsed: string;
    FIcon: string;
    FLastVersionId: string;
    FGameDir: string;
    FJavaDir: string;
    FJavaArgs: string;
    FLogConfig: string;
    FLogConfigIsXML: Boolean;
    FResolution: string;
  protected
  public
    property Name: string read FName write FName;
    property ProfilType: string read FProfilType write FProfilType;
    property Created: string read FCreated write FCreated;
    property LastUsed: string read FLastUsed write FLastUsed;
    property Icon: string read FIcon write FIcon;
    property LastVersionId: string read FLastVersionId write FLastVersionId;
    property GameDir: string read FGameDir write FGameDir;
    property JavaDir: string read FJavaDir write FJavaDir;
    property JavaArgs: string read FJavaArgs write FJavaArgs;
    property LogConfig: string read FLogConfig write FLogConfig;
    property LogConfigIsXML: Boolean read FLogConfigIsXML write FLogConfigIsXML;
    property Resolution: string read FResolution write FResolution;

    class function FromJSON(
      const AJSONObject: TJSONObject
    ): TMinecraftLauncherProfile;

    function ToJSON: TJSONObject;
  end;

  TMinecraftLauncherProfileList = class(TObjectList<TMinecraftLauncherProfile>)
  private
    function GetFromProfilName(
      const AProfilName: string
    ): TMinecraftLauncherProfile;
  protected
  public
    property FromProfilName[const AProfilName: string]: TMinecraftLauncherProfile read GetFromProfilName;

    class function FromMinecraftLauncherProfilesJSON(
      const AMinecraftLauncherProfilesJSONFile: string
    ): TMinecraftLauncherProfileList;

    class function FromJSON(
      const AJSONArray: TJSONArray
    ): TMinecraftLauncherProfileList;

    function ToJSON: TJSONArray;
  end;

implementation

uses
  Helper.JSON,
  System.IOUtils
  ;

{ TMinecraftLauncherProfil }

class function TMinecraftLauncherProfile.FromJSON(
  const AJSONObject: TJSONObject
): TMinecraftLauncherProfile;
begin
  Result                  := TMinecraftLauncherProfile.Create;
  Result.FName            := AJSONObject.GetString('name');
  Result.FProfilType      := AJSONObject.GetString('type');
  Result.FCreated         := AJSONObject.GetString('created');
  Result.FLastUsed        := AJSONObject.GetString('lastUsed');
  Result.FIcon            := AJSONObject.GetString('icon');
  Result.FLastVersionId   := AJSONObject.GetString('lastVersionId');
  Result.FGameDir         := AJSONObject.GetString('gameDir');
  Result.FJavaDir         := AJSONObject.GetString('javaDir');
  Result.FJavaArgs        := AJSONObject.GetString('javaArgs');
  Result.FLogConfig       := AJSONObject.GetString('logConfig');
  Result.FLogConfigIsXML  := AJSONObject.GetBoolean('logConfigIsXML');
  Result.FResolution      := AJSONObject.GetString('resolution');
end;

function TMinecraftLauncherProfile.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.SetString('name', FName);
  Result.SetString('type', FProfilType);
  Result.SetString('created', FCreated);
  Result.SetString('lastUsed', FLastUsed);
  Result.SetString('icon', FIcon);
  Result.SetString('lastVersionId', FLastVersionId);
  Result.SetString('gameDir', FGameDir);
  Result.SetString('javaDir', FJavaDir);
  Result.SetString('javaArgs', FJavaArgs);
  Result.SetString('logConfig', FLogConfig);
  Result.SetBoolean('logConfigIsXML', FLogConfigIsXML);
  Result.SetString('resolution', FResolution);
end;

class function TMinecraftLauncherProfileList.FromJSON(
  const AJSONArray: TJSONArray
): TMinecraftLauncherProfileList;
var
  rJSONValue: TJSONValue;
begin
  Result      := TMinecraftLauncherProfileList.Create;
  for rJSONValue in AJSONArray do
    Result.Add(TMinecraftLauncherProfile.FromJSON(rJsonValue as TJSONObject));
end;

{ TMinecraftLauncherProfilList }

class function TMinecraftLauncherProfileList.FromMinecraftLauncherProfilesJSON(
  const AMinecraftLauncherProfilesJSONFile: string
): TMinecraftLauncherProfileList;
var
  rJSONObject: TJSONObject;
  rJSONPair: TJSONPair;
begin
  Result      := TMinecraftLauncherProfileList.Create;
  rJSONObject := TJSONObject.ParseJSONValue(TFile.ReadAllText(AMinecraftLauncherProfilesJSONFile));
  if Assigned(rJSONObject) then
    rJSONObject := rJSONObject.GetJSONObject('profiles');

  if Assigned(rJSONObject) then
    for rJSONPair in rJSONObject do
      Result.Add(TMinecraftLauncherProfile.FromJSON(rJSONPair.JsonValue as TJSONObject));
end;

function TMinecraftLauncherProfileList.GetFromProfilName(
  const AProfilName: string
): TMinecraftLauncherProfile;
var
  rMinecraftLauncherProfil: TMinecraftLauncherProfile;
begin
  Result := nil;
  for rMinecraftLauncherProfil in Self do
    if rMinecraftLauncherProfil.FName.ToUpper.Equals(AProfilName.ToUpper) then
      Exit(rMinecraftLauncherProfil);
end;

function TMinecraftLauncherProfileList.ToJSON: TJSONArray;
var
  rMinecraftLauncherProfil: TMinecraftLauncherProfile;
begin
  Result := TJSONArray.Create;
  for rMinecraftLauncherProfil in Self do
    Result.Add(rMinecraftLauncherProfil.ToJSON);
end;

end.
