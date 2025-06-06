unit frmWatchListAddEntryUnit;

{$mode objfpc}{$H+}

interface

uses
  InvisForm,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, betterControls;

type

  { TfrmWatchListAddEntry }

  TfrmWatchListAddEntry = class(TInvisForm)
    btnOK: TButton;
    btnCancel: TButton;
    edtExpression: TEdit;
    Panel1: TPanel;
    rgType: TRadioGroup;
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmWatchListAddEntry: TfrmWatchListAddEntry;

implementation

{$R *.lfm}

{ TfrmWatchListAddEntry }

procedure TfrmWatchListAddEntry.FormShow(Sender: TObject);
begin
  edtExpression.SetFocus;
end;

end.

