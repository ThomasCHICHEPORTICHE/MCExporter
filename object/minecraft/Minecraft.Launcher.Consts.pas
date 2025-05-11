unit Minecraft.Launcher.Consts;

interface

type
  TFunctionIsMinecraftLauncherInstalled = function: Boolean;
  TFunctionGetMinecraftLauncherProfileList = function: PChar;
  TProcedureSetMinecraftLauncherProfileList = procedure(
    const AMinecraftLauncherProfilList: PChar
  );

const
  MINECRAFT_LAUNCHER_DISPLAYNAME: string = 'MINECRAFT LAUNCHER';
  MINECRAFT_LAUNCHER_DLL_FILENAME: string = 'DLLMinecraftLauncher.dll';
  MINECRAFT_LAUNCHER_PROFILES_JSON: string = 'launcher_profiles.json';
  MINECRAFT_ROOT_DIRECTORY: string = '.minecraft';

  FUNCTION_IS_MINECRAFT_LAUNCHER_INSTALLED: PChar = 'IsMinecraftLauncherInstalled';
  FUNCTION_GET_MINECRAFT_LAUNCHER_PROFILE_LIST: PChar = 'GetMinecraftLauncherProfileList';

  PROCEDURE_SET_MINECRAFT_LAUNCHER_PROFILE_LIST: PChar = 'SetMinecraftLauncherProfileList';

implementation

end.
