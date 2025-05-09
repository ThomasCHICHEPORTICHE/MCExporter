unit CurseForge.DLL;

interface

uses
  CurseForge.Types,
  DLLLoader
  ;

type
  TCurseForgeDLL = class(TDLLLoader)
  private
    function GetIsInstalled: Boolean;
    function GetMinecraftRootPath: string;
    procedure SetMinecraftRootPath(const Value: string);
  protected
  public
    constructor Create;

    property IsInstalled: Boolean read GetIsInstalled;
    property MinecraftRootPath: string read GetMinecraftRootPath write SetMinecraftRootPath;
  end;


implementation

uses
  CurseForge.Consts
  ;

{ TCurseForgeDLL }

constructor TCurseForgeDLL.Create;
begin
  inherited Create(CurseForge.Consts.CURSEFORGE_DLL_FILENAME);
end;

function TCurseForgeDLL.GetIsInstalled: Boolean;
var
  rIsCurseForgeInstalled: TFunctionIsCurseForgeInstalled;
begin
  try
    rIsCurseForgeInstalled := Proc[CurseForge.Consts.FUNCTION_IS_CURSEFORGE_INSTALLED];
    Result := rIsCurseForgeInstalled;
  except
    Result := False;
  end;
end;

function TCurseForgeDLL.GetMinecraftRootPath: string;
var
  rGetMinecraftRootPath: TFunctionGetCurseForgeMinecraftRoot;
begin
  try
    rGetMinecraftRootPath := Proc[CurseForge.Consts.FUNCTION_CURSEFORGE_GET_MINECRAFT_ROOT_PATH];
    Result := rGetMinecraftRootPath;
  except
    Result := '';
  end;
end;

procedure TCurseForgeDLL.SetMinecraftRootPath(const Value: string);
var
  rSetMinecraftRootPath: TProcedureSetCurseForgeMinecraftRoot;
begin
  try
    rSetMinecraftRootPath := Proc[CurseForge.Consts.PROCEDURE_CURSEFORGE_SET_MINECRAFT_ROOT_PATH];
    rSetMinecraftRootPath(PChar(Value));
  except
  end;
end;

end.
