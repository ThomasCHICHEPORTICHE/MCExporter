unit Helper.JSON;

interface

uses
  System.JSON
  ;


type
  TJSONObjectHelper = class Helper for TJSONObject
  private
    function InternalSetValue<T>(
      const AKey: string;
      const AValue: T
    ): TJSONObject;
    function InternalGetValue<T>(
      const AKey: string;
      const ADefaultValue: T
    ): T;
  protected
  public
    function SetString(
      const AKey: string;
      const AValue: string
    ): TJSONObject;
    function SetInteger(
      const AKey: string;
      const AValue: Integer
    ): TJSONObject;
    function SetDouble(
      const AKey: string;
      const AValue: Double
    ): TJSONObject;
    function SetBoolean(
      const AKey: string;
      const AValue: Boolean
    ): TJSONObject;
    function SetJSONObject(
      const AKey: string;
      const AValue: TJSONObject
    ): TJSONObject;
    function SetJSONArray(
      const AKey: string;
      const AValue: TJSONArray
    ): TJSONObject;

    function GetString(
      const AKey: string
    ): string;
    function GetInteger(
      const AKey: string
    ): Integer;
    function GetDouble(
      const AKey: string
    ): Double;
    function GetBoolean(
      const AKey: string
    ): Boolean;
    function GetJSONObject(
      const AKey: string
    ): TJSONObject;
    function GetJSONArray(
      const AKey: string
    ): TJSONArray;
  end;

const
  JSON_DEFAULT_STRING_VALUE: string = '';
  JSON_DEFAULT_NUMERIC_VALUE: Integer = 0;
  JSON_DEFAULT_BOOLEAN_VALUE: Boolean = False;

implementation

uses
  System.RTTI,
  System.SysUtils,
  System.TypInfo
  ;

function TJSONObjectHelper.GetBoolean(
  const AKey: string
): Boolean;
begin
  Result := InternalGetValue<Boolean>(AKey, JSON_DEFAULT_BOOLEAN_VALUE);
end;

function TJSONObjectHelper.GetDouble(
  const AKey: string
): Double;
begin
  Result := InternalGetValue<Double>(AKey, JSON_DEFAULT_NUMERIC_VALUE);
end;

function TJSONObjectHelper.GetInteger(
  const AKey: string
): Integer;
begin
  Result := InternalGetValue<Integer>(AKey, JSON_DEFAULT_NUMERIC_VALUE);
end;

function TJSONObjectHelper.GetJSONArray(
  const AKey: string
): TJSONArray;
begin
    Result := InternalGetValue<TJSONArray>(AKey, nil);
end;

function TJSONObjectHelper.GetJSONObject(
  const AKey: string
): TJSONObject;
begin
    Result := InternalGetValue<TJSONObject>(AKey, nil);
end;

function TJSONObjectHelper.GetString(
  const AKey: string
): string;
begin
    Result := InternalGetValue<string>(AKey, JSON_DEFAULT_STRING_VALUE);
end;

function TJSONObjectHelper.InternalGetValue<T>(
  const AKey: string;
  const ADefaultValue: T
): T;
var
  rJSONValue: TJSONValue;
begin
  Result      := ADefaultValue;
  rJSONValue  := GetValue(AKey);
  if (not Assigned(rJSONValue)) then
    Exit;

  Result := rJSONValue.AsType<T>;
end;

function TJSONObjectHelper.InternalSetValue<T>(
  const AKey: string;
  const AValue: T
): TJSONObject;
var
  rValue: TValue;
begin
  rValue := TValue.From<T>(AValue);

  RemovePair(AKey);

  if rValue.TypeInfo = TypeInfo(string) then
    Result := AddPair(AKey, rValue.AsString)
  else if rValue.TypeInfo = TypeInfo(Integer) then
    Result := AddPair(AKey, rValue.AsInteger)
  else if rValue.TypeInfo = TypeInfo(Double) then
    Result := AddPair(AKey, rValue.AsExtended)
  else if rValue.TypeInfo = TypeInfo(Boolean) then
    Result := AddPair(AKey, rValue.AsBoolean)
  else if rValue.TypeInfo = TypeInfo(TJSONObject) then
    Result := AddPair(AKey, rValue.AsType<TJSONObject>)
  else if rValue.TypeInfo = TypeInfo(TJSONArray) then
    Result := AddPair(AKey, rValue.AsType<TJSONArray>)
  else
    raise Exception.Create('Unsupported type');
end;

{ TJSONHelper }

function TJSONObjectHelper.SetBoolean(
  const AKey: string;
  const AValue: Boolean
): TJSONObject;
begin
  Result := InternalSetValue<Boolean>(AKey, AValue);
end;

function TJSONObjectHelper.SetDouble(
  const AKey: string;
  const AValue: Double
): TJSONObject;
begin
  Result := InternalSetValue<Double>(AKey, AValue);
end;

function TJSONObjectHelper.SetInteger(
  const AKey: string;
  const AValue: Integer
): TJSONObject;
begin
  Result := InternalSetValue<Integer>(AKey, AValue);
end;

function TJSONObjectHelper.SetJSONArray(
  const AKey: string;
  const AValue: TJSONArray
): TJSONObject;
begin
  Result := InternalSetValue<TJSONArray>(AKey, AValue);
end;

function TJSONObjectHelper.SetJSONObject(
  const AKey: string;
  const AValue: TJSONObject
): TJSONObject;
begin
  Result := InternalSetValue<TJSONObject>(AKey, AValue);
end;

function TJSONObjectHelper.SetString(
  const AKey: string;
  const AValue: string
): TJSONObject;
begin
  Result := InternalSetValue<string>(AKey, AValue);
end;

end.

