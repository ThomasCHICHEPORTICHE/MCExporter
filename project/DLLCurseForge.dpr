library DLLCurseForge;

{ Remarque importante sur la gestion mémoire de la DLL : ShareMem doit être la
  première unité de la clause USES de votre bibliothèque ET la clause USES
  (sélectionner Projet-Voir le source) de votre projet si votre DLL exporte toute procédure ou
  fonction qui passe des chaînes par le biais de paramètres ou de résultats de fonctions. Cela
  s'applique à toutes les chaînes passées vers et depuis votre DLL -- même celles qui
  sont imbriquées dans des enregistrements et des classes. ShareMem est l'unité d'interface au
  gestionnaire de mémoire partagée BORLNDMM.DLL, qui doit être déployé
  avec votre DLL. Pour éviter l'emploi de BORLNDMM.DLL, passez des informations chaîne
  par le biais de paramètres PChar ou ShortString.

  Remarque importante sur l'utilisation de la VCL : quand cette DLL sera implicitement
  chargée, elle utilise TWicImage / Pour les TImageCollection créés dans
  toute section d'initialisation d'unité, Vcl.WicImageIni doit être
  inclus dans la clause USES de votre bibliothèque. }

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
