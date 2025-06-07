unit InvisForm;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Windows;

type
  TInvisForm = class(TForm)
  private
  public
    procedure DoShowWindow; override;
  end;

function SetWindowDisplayAffinity(hWnd: HWND; dwAffinity: DWORD): BOOL; stdcall; external 'user32';

implementation
  function RandomString(Len: Integer): String;
  const
    Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  var
    i: Integer;
  begin
    SetLength(Result, Len);
    for i := 1 to Len do
      Result[i] := Chars[Random(Length(Chars)) + 1];
  end;

  procedure TInvisForm.DoShowWindow;
  begin
    Self.Caption := RandomString(Random(32 - 8) + 8);
    Self.ShowInTaskBar := stNever;
    SetWindowDisplayAffinity(Self.Handle, $11);
    inherited DoShowWindow;
  end;

end.

