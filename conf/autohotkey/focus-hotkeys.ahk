; set title match mode to any string
; https://www.autohotkey.com/docs/commands/SetTitleMatchMode.htm
SetTitleMatchMode, RegEx
;SetTitleMatchMode 2

; call WinActivate 
; https://www.autohotkey.com/docs/commands/WinActivate.htm

; match tunfor-web and avoid matching tunfor-web2
<#w::
   WinActivate, ^tunfor-web(\s|$) ahk_exe idea64.exe
return

; match tunfor-service and avoid matching tunfor-service2
<#s::
   WinActivate, ^tunfor-service(\s|$) ahk_exe idea64.exe
return

<#t::
   WinActivate, ahk_exe Vivaldi.exe
return

<#c::
  WinActivate, Visual Studio Code
return