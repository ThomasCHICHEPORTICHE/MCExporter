unit Form.Application;

interface

uses
  CurseForge.DLL,
  CurseForge.Types,
  FMX.Controls,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.Layouts,
  FMX.Types,
  FrameStand,
  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants

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
    FCurseForgeDLL: TCurseForgeDLL;
    FCurseForgeInstanceList: TCurseForgeInstanceList;
  public
    { Déclarations publiques }
    property CurseForgeInstanceList: TCurseForgeInstanceList read FCurseForgeInstanceList;
  end;

var
  FormApplication: TFormApplication;

implementation

uses
  Frame.Main
  ;

{$R *.fmx}

procedure TFormApplication.FormCreate(Sender: TObject);
begin
  FFrameStand               := TFrameStand.Create(Self);
  FFrameStand.DefaultParent := LMain;

  FCurseForgeDLL          := TCurseForgeDLL.Create;
  FCurseForgeInstanceList := FCurseForgeDLL.CurseForgeInstanceList;

  FFrameStand.NewAndShow<TFrameMain>;
end;

procedure TFormApplication.FormDestroy(Sender: TObject);
begin
  FFrameStand.CloseAll;
  FreeAndNil(FFrameStand);
  FreeAndNil(FCurseForgeInstanceList);
  FreeAndNil(FCurseForgeDLL);
end;

end.
