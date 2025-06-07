unit textbox;

{$mode Delphi}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TTextbox }

  TTextbox = class(TForm)
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

