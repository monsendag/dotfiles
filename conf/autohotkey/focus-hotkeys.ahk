; set title match mode to any string
; https://www.autohotkey.com/docs/commands/SetTitleMatchMode.htm
SetTitleMatchMode, RegEx

<#w::
  WinActivate, tunfor-web
return

<#s::  
WinActivate, tunfor-service
return

<#t::
  WinActivate, .*Vivaldi
return

<#c::
  WinActivate, Visual Studio Code
return