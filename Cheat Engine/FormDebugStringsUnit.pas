unit FormDebugStringsUnit;

{$MODE Delphi}

interface

uses
  InvisForm,
  LCLIntf, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, LResources, betterControls;

type
  TFormDebugStrings = class(TInvisForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDebugStrings: TFormDebugStrings;

implementation


procedure TFormDebugStrings.Button1Click(Sender: TObject);
begin
  close;
end;

initialization
  {$i FormDebugStringsUnit.lrs}

end.
