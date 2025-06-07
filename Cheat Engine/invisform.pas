unit InvisForm;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Controls, Forms, Windows;

type
  TInvisForm = class(TForm)
  private
    procedure Invis;
  private
    procedure DoShowWindow; override;
  public
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

  procedure TInvisForm.Invis;
  begin
    self.Caption := RandomString(Random(32 - 8) + 8);
    self.ShowInTaskBar := stNever;
    SetWindowDisplayAffinity(Self.Handle, $11);
  end;

  procedure TInvisForm.DoShowWindow;
  begin
    self.Invis;
    inherited DoShowWindow;
  end;

end.

