unit CurseForge.Types;

interface

uses
  System.Generics.Collections,
  System.JSON
  ;

type
  TCurseForgeInstance = class
  private
    Fname: string;
    FVersion: string;
    FAuthor: string;
    FPath: string;
    FThumbnail: string;
  protected
  public
    property Name: string read Fname;
    property Version: string read FVersion;
    property Author: string read FAuthor;
    property Path: string read FPath;
    property Thumbnail: string read FThumbnail;

    class function FromInstanceDirectory(
      const APath: string
    ): TCurseForgeInstance;

    function ToJSON: TJSONObject;
  end;

  TCurseForgeInstanceList = class(TObjectList<TCurseForgeInstance>)
  private
  protected
  public
    function ToJSON: TJSONArray;
  end;

implementation

uses
  Helper.JSON,
  System.IOUtils,
  System.SysUtils
  ;

{ TCurseForgeInstance }

class function TCurseForgeInstance.FromInstanceDirectory(
  const APath: string
): TCurseForgeInstance;

  procedure FromManifestJSON(
    const ACurseForgeInstance: TCurseForgeInstance
  );
  var
    oJSONObject: TJSONObject;
  begin
    oJSONObject := TJSONObject.LoadFromFile(TPath.Combine(ACurseForgeInstance.FPath, 'manifest.json'));
    if (not Assigned(oJSONObject)) then
      Exit;
    try

      Result.Fname    := oJSONObject.GetString('name');
      Result.FVersion := oJSONObject.GetString('version');
      Result.FAuthor  := oJSONObject.GetString('author');
    finally
      FreeAndNil(oJSONObject);
    end;
  end;

  procedure FromMinecraftInstanceJSON(
    const ACurseForgeInstance: TCurseForgeInstance
  );
  var
    oJSONObject: TJSONObject;
    rJSONObjectInstalledModpack: TJSONObject;
  begin
    oJSONObject := TJSONObject.LoadFromFile(TPath.Combine(ACurseForgeInstance.FPath, 'minecraftinstance.json'));
    if (not Assigned(oJSONObject)) then
      Exit;
    rJSONObjectInstalledModpack := oJSONObject.GetJSONObject('installedModpack');
    if (not Assigned(rJSONObjectInstalledModpack)) then
      Exit;
    try
      Result.FThumbnail := rJSONObjectInstalledModpack.GetString('thumbnailUrl');
    finally
      FreeAndNil(oJSONObject);
    end;
  end;

begin
  Result        := TCurseForgeInstance.Create;
  Result.FPath  := APath;
  FromManifestJSON(Result);
  FromMinecraftInstanceJSON(Result);
end;

function TCurseForgeInstance.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.SetString('name', Fname);
  Result.SetString('version', FVersion);
  Result.SetString('author', FAuthor);
  Result.SetString('path', FPath);
  Result.SetString('thumbnail', FThumbnail);
end;

{ TCurseForgeInstanceList }

function TCurseForgeInstanceList.ToJSON: TJSONArray;
var
  rCurseForgeInstance: TCurseForgeInstance;
begin
  Result := TJSONArray.Create;
  for rCurseForgeInstance in Self do
    Result.Add(rCurseForgeInstance.ToJSON);
end;
end.
