unit First;

{$mode delphi}

interface

uses
  Windows, Classes, SysUtils;

procedure DbgLog(msg: string);

implementation

procedure DbgLog(msg: string);
begin
  {$ifndef NoODS}
    {$ifdef windows}
      windows.outputdebugstring(pchar(msg));
    {$endif}

    {$ifdef android}
      log(msg);
    {$endif}
  {$endif}
end;

end.

