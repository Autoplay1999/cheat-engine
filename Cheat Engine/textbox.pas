unit textbox;

{$mode Delphi}

interface

uses
  InvisForm,
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TTextbox }

  TTextbox = class(TInvisForm)
    Confirm: TButton;
    Input: TEdit;
  private

  public

  end;

var
  gTextbox: TTextbox;

implementation

{$R *.lfm}

{ TTextbox }
initialization
end.

