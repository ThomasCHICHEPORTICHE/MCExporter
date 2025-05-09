unit CurseForge.Functions;

interface

uses
  CurseForge
  ;

function IsCurseForgeInstalled: Boolean;
function GetCurseForgeMinecraftRoot: PChar;
procedure SetCurseForgeMinecraftRoot(
  const APath: PChar
);
function CurseForgeInstanceList: PChar;

var
  CurseForgeMinecraftRoot: string;

implementation

uses
  CurseForge.Types,
  Helper.Registry,
  Helper.JSON,
  System.IOUtils,
  System.SysUtils,
  System.Win.Registry
  ;

function IsCurseForgeInstalled: Boolean;
begin
  Result := TCurseForge.IsInstalled;
end;

function GetCurseForgeMinecraftRoot: PChar;
begin
  Result := StrNew(PChar(CurseForgeMinecraftRoot));
end;

procedure SetCurseForgeMinecraftRoot(
  const APath: PChar
);
begin
  CurseForgeMinecraftRoot := APath;
end;

function CurseForgeInstanceList: PChar;
begin
  Result := StrNew(PChar(TCurseForge.MinecraftInstanceList));
end;

initialization
  CurseForgeMinecraftRoot := TCurseForge.MinecraftRoot;
end.
