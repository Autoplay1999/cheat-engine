unit frmProcesswatcherExtraUnit;

{$MODE Delphi}

interface

uses
  InvisForm,
  LCLIntf, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, LResources, betterControls;

type
  TfrmProcessWatcherExtra = class(TInvisForm)
    data: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProcessWatcherExtra: TfrmProcessWatcherExtra;

implementation


initialization
  {$i frmProcesswatcherExtraUnit.lrs}

end.
