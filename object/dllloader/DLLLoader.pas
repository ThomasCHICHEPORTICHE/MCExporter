unit DLLLoader;

interface

uses
  System.Generics.Collections,
  System.SysUtils
  ;

type
  EDLLException = class(Exception);
  TDLLLoader = class
  private
    FDLLHandle: THandle;
    FProcDictionary: TDictionary<string, Pointer>;
    function GetIsDLLLoaded: Boolean;
    function GetProcDictionary: TDictionary<string, Pointer>;
    function GetProc(const AProcName: string): Pointer;
  protected
    property ProcDictionary: TDictionary<string, Pointer> read GetProcDictionary;
  public
    constructor Create(
      const ADLLFilename: string
    );
    destructor Destroy; override;

    property IsDLLLoaded: Boolean read GetIsDLLLoaded;
    property Proc[const AProcName: string]: Pointer read GetProc;
  end;

implementation

uses
  System.IOUtils,
  WinAPI.Windows
  ;

{ TDLLLoader }

constructor TDLLLoader.Create(
  const ADLLFilename: string
);
begin
  FDLLHandle := LoadLibrary(PChar(ADLLFilename));
  if (not IsDLLLoaded) then
    raise EDLLException.CreateFmt('Error : DLL %s not loaded !', [TPath.GetFileNameWithoutExtension(ADLLFilename)]);
end;

destructor TDLLLoader.Destroy;
begin
  if (not IsDLLLoaded) then
    Exit;
  FreeLibrary(FDLLHandle);
  FreeAndNil(FProcDictionary);
end;

function TDLLLoader.GetIsDLLLoaded: Boolean;
begin
  Result := (FDLLHandle <> 0);
end;

function TDLLLoader.GetProc(const AProcName: string): Pointer;
begin
  if (not IsDLLLoaded) then
    raise EDLLException.Create('Error : DLL not loaded !');
  Result := GetProcAddress(FDLLHandle, PChar(AProcName));
  if (not Assigned(Result)) then
    raise EDLLException.CreateFmt('Error : Can''t load proc %s !', [AProcName]);
  ProcDictionary.Add(AProcName, Result);
end;

function TDLLLoader.GetProcDictionary: TDictionary<string, Pointer>;
begin
  if (not Assigned(FProcDictionary)) then
    FProcDictionary := TDictionary<string, Pointer>.Create;
  Result := FProcDictionary;
end;

end.
