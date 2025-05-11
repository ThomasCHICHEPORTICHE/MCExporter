unit CurseForge.Types;

interface

uses
  System.Generics.Collections,
  System.JSON
  ;

type
  TCurseForgeInstance = class
  private
    FName: string;
    FVersion: string;
    FAuthor: string;
    FPath: string;
    FThumbnail: string;
  protected
  public
    property Name: string read FName;
    property Version: string read FVersion;
    property Author: string read FAuthor;
    property Path: string read FPath;
    property Thumbnail: string read FThumbnail;

    class function FromInstanceDirectory(
      const APath: string
    ): TCurseForgeInstance;
    class function FromJSON(
      const AJSONObject: TJSONObject
    ): TCurseForgeInstance;

    function ToJSON: TJSONObject;
  end;

  TCurseForgeInstanceList = class(TObjectList<TCurseForgeInstance>)
  private
  protected
  public
    class function FromJSON(
      const AJSONArray: TJSONArray
    ): TCurseForgeInstanceList;
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

      Result.FName    := oJSONObject.GetString('name');
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

class function TCurseForgeInstance.FromJSON(
  const AJSONObject: TJSONObject
): TCurseForgeInstance;
begin
  Result            := TCurseForgeInstance.Create;
  Result.FName      := AJSONObject.GetString('name');
  Result.FVersion   := AJSONObject.GetString('version');
  Result.FAuthor    := AJSONObject.GetString('author');
  Result.FPath      := AJSONObject.GetString('path');
  Result.FThumbnail := AJSONObject.GetString('thumbnail');
end;

function TCurseForgeInstance.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.SetString('name', FName);
  Result.SetString('version', FVersion);
  Result.SetString('author', FAuthor);
  Result.SetString('path', FPath);
  Result.SetString('thumbnail', FThumbnail);
end;

{ TCurseForgeInstanceList }

class function TCurseForgeInstanceList.FromJSON(
  const AJSONArray: TJSONArray
): TCurseForgeInstanceList;
var
  rJSONValue: TJSONValue;
begin
  Result := TCurseForgeInstanceList.Create;
  for rJSONValue in AJSONArray do
    Result.Add(TCurseForgeInstance.FromJSON(TJSONObject(rJSONValue)));
end;

function TCurseForgeInstanceList.ToJSON: TJSONArray;
var
  rCurseForgeInstance: TCurseForgeInstance;
begin
  Result := TJSONArray.Create;
  for rCurseForgeInstance in Self do
    Result.Add(rCurseForgeInstance.ToJSON);
end;
end.
