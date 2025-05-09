unit CurseForge.Consts;

interface

type
  TFunctionIsCurseForgeInstalled = function: Boolean;
  TFunctionGetCurseForgeMinecraftRoot = function: PChar;
  TProcedureSetCurseForgeMinecraftRoot = procedure(
    const APath: PChar
  );
  TFunctionCurseForgeInstanceList = function: PChar;

const
  CURSEFORGE_DISPLAY_NAME: string = 'CURSEFORGE';
  CURSEFORGE_DLL_FILENAME: string = 'DLLCurseForge.dll';

  FUNCTION_IS_CURSEFORGE_INSTALLED: PChar = 'IsCurseForgeInstalled';
  FUNCTION_CURSEFORGE_GET_MINECRAFT_ROOT_PATH: PChar = 'GetCurseForgeMinecraftRoot';
  FUNCTION_CURSEFORGE_INSTANCE_LIST: PCHar = 'CurseForgeInstanceList';

  PROCEDURE_CURSEFORGE_SET_MINECRAFT_ROOT_PATH: PChar = 'SetCurseForgeMinecraftRoot';

  REGISTRY_CURSEFORGE_KEY_PATH: string = 'Software\Overwolf\CurseForge';
  REGISTRY_CURSEFORGE_NAME_MINECRAFT_ROOT: string = 'minecraft_root';

implementation

end.
