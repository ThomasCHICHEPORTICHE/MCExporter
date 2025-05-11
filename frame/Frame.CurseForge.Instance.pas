unit Frame.CurseForge.Instance;

interface

uses
  CurseForge.Types,
  FMX.Controls,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Skia,
  FMX.Types,
  System.Classes,
  System.Generics.Collections,
  System.Skia,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants,
  TC.ResourceImage
  ;

type
  TFrameCurseForgeInstance = class(TFrame)
    SKIThumbnail: TSkAnimatedImage;
    TName: TText;
    TVersion: TText;
    RBackground: TRectangle;
    RISelected: TResourceImage;
    procedure FrameClick(Sender: TObject);
  private
    { Déclarations privées }
    FCurseForgeInstance: TCurseForgeInstance;
    FSelected: Boolean;

    procedure LoadUI;
    procedure SetSelected(const Value: Boolean);
    procedure SetCurseForgeInstance(const Value: TCurseForgeInstance);
  public
    { Déclarations publiques }
    property Selected: Boolean read FSelected write SetSelected;
    property CurseForgeInstance: TCurseForgeInstance read FCurseForgeInstance write SetCurseForgeInstance;
  end;
  TFrameCurseForgeInstanceList = class(TObjectList<TFrameCurseForgeInstance>)
  private
  protected
  public
  end;
implementation

uses
  IdHTTP
  ;

{$R *.fmx}

{ TFrame1 }

procedure TFrameCurseForgeInstance.FrameClick(Sender: TObject);
begin
  Selected := (not Selected);
end;

procedure TFrameCurseForgeInstance.LoadUI;
var
  oIdHTTP: TIdHTTP;
  oMemoryStream: TMemoryStream;
begin
  TName.Text    := FCurseForgeInstance.Name;
  TVersion.Text := FCurseForgeInstance.Version;

  oMemoryStream := TMemoryStream.Create;
  oIdHTTP       := TIdHTTP.Create(nil);
  try
    oIdHTTP.Get(FCurseForgeInstance.Thumbnail, oMemoryStream);
    oMemoryStream.Seek(0, soFromBeginning);
    SKIThumbnail.LoadFromStream(oMemoryStream);
  finally
    FreeAndNil(oMemoryStream);
    FreeAndNil(oIdHTTP);
  end;

  Selected := False;
end;

procedure TFrameCurseForgeInstance.SetCurseForgeInstance(
  const Value: TCurseForgeInstance);
begin
  FCurseForgeInstance := Value;
  LoadUI;
end;

procedure TFrameCurseForgeInstance.SetSelected(const Value: Boolean);
begin
  FSelected           := Value;
  RISelected.Visible  := FSelected;
end;

end.
