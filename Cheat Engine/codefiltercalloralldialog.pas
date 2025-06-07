unit CodeFilterCallOrAllDialog;

{$mode delphi}

interface

uses
  InvisForm,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, betterControls;

type

  { TCallOrAllDialog }

  TCallOrAllDialog = class(TInvisForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Panel1: TPanel;
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{$R *.lfm}

end.

