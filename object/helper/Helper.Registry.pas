unit Helper.Registry;

interface

uses
  System.Win.Registry,
  WinAPI.Windows
  ;

type
  TRegistryHelper = class Helper for TRegistry
  private
  protected
  public
//    class function IsApplicationInstalled(
//      const ADisplayName: string
//    ): Boolean;

    class function GetKey(
      const ARootKey: HKEY;
      const AKey: string
    ): TRegistry;

    class function GetString(
      const ARootKey: HKEY;
      const AKey: string;
      const AName: string
    ): string;

    class function GetInteger(
      const ARootKey: HKEY;
      const AKey: string;
      const AName: string
    ): Integer;

    class function GetDouble(
      const ARootKey: HKEY;
      const AKey: string;
      const AName: string
    ): Double;

    class function GetBoolean(
      const ARootKey: HKEY;
      const AKey: string;
      const AName: string
    ): Boolean;

    class procedure SetString(
      const ARootKey: HKEY;
      const AKey: string;
      const AName: string;
      const AValue: String
    );

    class procedure SetInteger(
      const ARootKey: HKEY;
      const AKey: string;
      const AName: string;
      const AValue: Integer
    );

    class procedure SetDouble(
      const ARootKey: HKEY;
      const AKey: string;
      const AName: string;
      const AValue: Double
    );

    class procedure SetBoolean(
      const ARootKey: HKEY;
      const AKey: string;
      const AName: string;
      const AValue: Boolean
    );

    class function KeyExists(
      const ARootKey: HKEY;
      const AKey: string
    ): Boolean;
  end;

const
  REGISTRY_DEFAULT_STRING_VALUE: string = '';
  REGISTRY_DEFAULT_NUMERIC_VALUE: Integer = 0;
  REGISTRY_DEFAULT_BOOLEAN_VALUE: Boolean = False;

  REGISTRY_KEY_LOCAL_MACHINE  = HKEY_LOCAL_MACHINE;
  REGISTRY_KEY_USERS          = HKEY_USERS;
  REGISTRY_KEY_CURRENT_USER   = HKEY_CURRENT_USER;
implementation

uses
  System.Classes,
  System.IOUtils,
  System.SysUtils
  ;

//{
//  This class function search in Registry if an application Is Installed.
//
//  @param(ADisplayName Application display name to find in registry.)
//  @returns(True if application is installed, False otherwhise.)
//}
//class function TRegistryHelper.IsApplicationInstalled(
//  const ADisplayName: string
//): Boolean;
//const
//  ROOT_KEYS: array[0..2] of HKEY = (
//    HKEY_LOCAL_MACHINE,
//    HKEY_LOCAL_MACHINE,
//    HKEY_CURRENT_USER
//  );
//  ROOT_PATHS: array[0..2] of string = (
//    'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
//    'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall',
//    'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
//  );
//  KEY: string = 'DisplayName';
//var
//  oRegistry: TRegistry;
//  rKey: HKEY;
//  sRootPath: string;
//  oKeyNames: TStringList;
//  sKey: string;
//begin
//  Result    := False;
//  oRegistry := TRegistry.Create(KEY_READ);
//  oKeyNames := TStringList.Create;
//  try
//    for rKey in ROOT_KEYS do
//    begin
//      oRegistry.RootKey := rKey;
//      for sRootPath in ROOT_PATHS do
//      begin
//        if (not oRegistry.OpenKeyReadOnly(sRootPath)) then
//          Continue;
//        oRegistry.GetKeyNames(oKeyNames);
//        oRegistry.CloseKey;
//        for sKey in oKeyNames do
//        begin
//          if (not oRegistry.OpenKeyReadOnly(sRootPath + '\' + sKey)) then
//            Continue;
//          try
//            if (oRegistry.ValueExists(KEY) and (oRegistry.ReadString(KEY).ToUpper.Contains(ADisplayName.ToUpper))) then
//            begin
//              Result := True;
//              Exit;
//            end;
//          finally
//            oRegistry.CloseKey;
//          end;
//        end;
//      end;
//    end;
//  finally
//    FreeAndNil(oRegistry);
//    FreeAndNil(oKeyNames);
//  end;
//end;

class function TRegistryHelper.GetKey(
  const ARootKey: HKEY;
  const AKey: string
): TRegistry;
begin
  Result          := TRegistry.Create(KEY_READ);
  Result.RootKey  := ARootKey;
  if (not Result.OpenKeyReadOnly( AKey)) then
    raise ERegistryException.CreateFmt('Error : Cannot open key : %s', [AKey]);
end;

class function TRegistryHelper.GetString(
  const ARootKey: HKEY;
  const AKey: string;
  const AName: string
): string;
var
  oRegistry: TRegistry;
begin
  Result := REGISTRY_DEFAULT_STRING_VALUE;
  try
    oRegistry := TRegistry.GetKey(ARootKey, AKey);
    Result    := oRegistry.ReadString(AName);
    oRegistry.CloseKey;
  finally
    FreeAndNil(oRegistry);
  end;
end;

class function TRegistryHelper.KeyExists(
  const ARootKey: HKEY;
  const AKey: string
): Boolean;
var
  oRegistry: TRegistry;
begin
  try
    oRegistry := TRegistry.GetKey(ARootKey, AKey);
    Result    := True;
    oRegistry.CloseKey;
  finally
    FreeAndNil(oRegistry);
  end;
end;

class procedure TRegistryHelper.SetBoolean(
  const ARootKey: HKEY;
  const AKey: string;
  const AName: string;
  const AValue: Boolean
);
var
  oRegistry: TRegistry;
begin
  try
    oRegistry := TRegistry.GetKey(ARootKey, AKey);
    oRegistry.WriteBool(AName, AValue);
    oRegistry.CloseKey;
  finally
    FreeAndNil(oRegistry);
  end;
end;

class procedure TRegistryHelper.SetDouble(
  const ARootKey: HKEY;
  const AKey: string;
  const AName: string;
  const AValue: Double
);
var
  oRegistry: TRegistry;
begin
  try
    oRegistry := TRegistry.GetKey(ARootKey, AKey);
    oRegistry.WriteFloat(AName, AValue);
    oRegistry.CloseKey;
  finally
    FreeAndNil(oRegistry);
  end;
end;

class procedure TRegistryHelper.SetInteger(
  const ARootKey: HKEY;
  const AKey: string;
  const AName: string;
  const AValue: Integer
);
var
  oRegistry: TRegistry;
begin
  try
    oRegistry := TRegistry.GetKey(ARootKey, AKey);
    oRegistry.WriteInteger(AName, AValue);
    oRegistry.CloseKey;
  finally
    FreeAndNil(oRegistry);
  end;
end;

class procedure TRegistryHelper.SetString(
  const ARootKey: HKEY;
  const AKey: string;
  const AName: string;
  const AValue: String
);
var
  oRegistry: TRegistry;
begin
  try
    oRegistry := TRegistry.GetKey(ARootKey, AKey);
    oRegistry.WriteString(AName, AValue);
    oRegistry.CloseKey;
  finally
    FreeAndNil(oRegistry);
  end;
end;

class function TRegistryHelper.GetInteger(
  const ARootKey: HKEY;
  const AKey: string;
  const AName: string
): Integer;
var
  oRegistry: TRegistry;
begin
  try
    oRegistry := TRegistry.GetKey(ARootKey, AKey);
    Result    := oRegistry.ReadInteger(AName);
    oRegistry.CloseKey;
  finally
    FreeAndNil(oRegistry);
  end;
end;

class function TRegistryHelper.GetDouble(
  const ARootKey: HKEY;
  const AKey: string;
  const AName: string
): Double;
var
  oRegistry: TRegistry;
begin
  try
    oRegistry := TRegistry.GetKey(ARootKey, AKey);
    Result    := oRegistry.ReadFloat(AName);
    oRegistry.CloseKey;
  finally
    FreeAndNil(oRegistry);
  end;
end;

class function TRegistryHelper.GetBoolean(
  const ARootKey: HKEY;
  const AKey: string;
  const AName: string
): Boolean;
var
  oRegistry: TRegistry;
begin
  try
    oRegistry := TRegistry.GetKey(ARootKey, AKey);
    Result    := oRegistry.ReadBool(AName);
    oRegistry.CloseKey;
  finally
    FreeAndNil(oRegistry);
  end;

end;

end.
