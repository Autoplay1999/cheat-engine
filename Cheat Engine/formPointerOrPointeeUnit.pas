unit formPointerOrPointeeUnit;

{$MODE Delphi}

interface

uses
  InvisForm,
  LCLIntf, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, LResources, ExtCtrls, betterControls;

type

  { TformPointerOrPointee }

  TformPointerOrPointee = class(TInvisForm)
    btnFindWhatWritesPointer: TButton;
    btnFindWhatWritesPointee: TButton;
    Label1: TLabel;
    Panel1: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formPointerOrPointee: TformPointerOrPointee;

implementation


initialization
  {$i formPointerOrPointeeUnit.lrs}

end.
