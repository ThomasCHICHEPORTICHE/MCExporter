library DLLCurseForge;

{ Remarque importante sur la gestion m�moire de la DLL : ShareMem doit �tre la
  premi�re unit� de la clause USES de votre biblioth�que ET la clause USES
  (s�lectionner Projet-Voir le source) de votre projet si votre DLL exporte toute proc�dure ou
  fonction qui passe des cha�nes par le biais de param�tres ou de r�sultats de fonctions. Cela
  s'applique � toutes les cha�nes pass�es vers et depuis votre DLL -- m�me celles qui
  sont imbriqu�es dans des enregistrements et des classes. ShareMem est l'unit� d'interface au
  gestionnaire de m�moire partag�e BORLNDMM.DLL, qui doit �tre d�ploy�
  avec votre DLL. Pour �viter l'emploi de BORLNDMM.DLL, passez des informations cha�ne
  par le biais de param�tres PChar ou ShortString.

  Remarque importante sur l'utilisation de la VCL : quand cette DLL sera implicitement
  charg�e, elle utilise TWicImage / Pour les TImageCollection cr��s dans
  toute section d'initialisation d'unit�, Vcl.WicImageIni doit �tre
  inclus dans la clause USES de votre biblioth�que. }

uses
  System.SysUtils,
  System.Classes,
  System.Win.Registry,
  System.IOUtils,
  WinAPI.Windows,
  Helper.JSON in '..\object\helper\Helper.JSON.pas',
  Helper.Registry in '..\object\helper\Helper.Registry.pas',
  CurseForge.Functions in '..\object\curseforge\CurseForge.Functions.pas',
  CurseForge.Types in '..\object\curseforge\CurseForge.Types.pas',
  CurseForge in '..\object\curseforge\CurseForge.pas',
  CurseForge.Consts in '..\object\curseforge\CurseForge.Consts.pas';

{$R *.res}

exports IsCurseForgeInstalled;
exports CurseForgeMinecraftRoot;
exports CurseForgeInstanceList;

begin
end.
