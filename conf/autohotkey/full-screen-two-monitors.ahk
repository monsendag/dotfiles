+#Up::
  WinGetActiveTitle, Title

  ; for detecting current position
  ;WinGetPos, X, Y, Width, Height, %Title%
  ;MsgBox, , Title, x: %X%  y: %Y%  w:%Width%  h:%Height%,

  SysGet, X1, 76
  SysGet, Y1, 77
  SysGet, Width, 78
  SysGet, Height, 79

  Width += Width

  WinRestore, %Title%
  WinMove, %Title%,, 1912, -620, 2885, 2515
return