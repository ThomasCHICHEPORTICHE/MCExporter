unit Form.Application;

interface

uses
  FMX.Controls,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.Types,
  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants,
  FrameStand, FMX.Layouts
  ;

type
  TFormApplication = class(TForm)
    LContent: TLayout;
    LHeader: TLayout;
    LFooter: TLayout;
    LMain: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
    FFrameStand: TFrameStand;
  public
    { Déclarations publiques }
  end;

var
  FormApplication: TFormApplication;

implementation

{$R *.fmx}

procedure TFormApplication.FormCreate(Sender: TObject);
begin
  FFrameStand               := TFrameStand.Create(Self);
  FFrameStand.DefaultParent := LMain;
end;

procedure TFormApplication.FormDestroy(Sender: TObject);
begin
  FFrameStand.CloseAll;
  FreeAndNil(FFrameStand);
end;

end.
