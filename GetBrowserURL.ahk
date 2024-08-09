#InstallKeybdHook
#SingleInstance force
file=%1%
clipboard:=""
success:=false
tooltip Starting
loop 5 {
	tooltip Starting GetBrowserURL %a_index%
	IfWinNotActive ahk_exe firefox.exe
		IfWinNotActive ahk_exe chrome.exe
			IfWinNotActive ahk_exe brave.exe
			{
				ret(file, "")
				return
			}
	send !d{esc 3}!d^c
	tooltip Starting3
	ClipWait 1
	tooltip Starting4
	if not errorlevel
	{
		SendInput {esc}
		success:=true
		break
	}
	if A_Index > 1
	{
		WinGetTitle x, A
		tooltip Retrying %x%
	}
}
if success
{
	tooltip
	ret(file, clipboard)
	;run % file
} else {
	tooltip Failed
	sleep 3000
}
ExitApp
ret(file, text){
	FileAppend %text%, *
}