#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include lib\ocr
#include OCR.ahk
#include %A_ScriptDir%

global LAG_FACTOR := 1.0

Drink()
{
	water_image := "assets/water_w_text.png"
	drink_image := "assets/drink_text.png"
	
	ImageSearch out_x, out_y, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *TransBlack *40 %water_image%
	if (out_x) {
		MouseMove out_x, out_y
		MouseClick right
		Sleep % LAG_FACTOR*500
		ImageSearch out_x, out_y, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %drink_image%
		if (out_x) {
			MouseMove out_x, out_y
			MouseClick
		}
	} else {
		OutputDebug failed :(
	}
}

ExpandInventory()
{
	inventory_image := "assets/inventory.png"
	inventory_expand_image := "assets/inventory_expand.png"

	ImageSearch out_x, out_y, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %inventory_image%
	if (!out_x) {
		Send {f3}
		Sleep % LAG_FACTOR*150
		WinActivate ahk_class LWJGL
		ImageSearch out_x, out_y, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %inventory_image%
	}

	if (out_x) {
		MouseMove out_x, out_y, 5
		MouseMove 0, 25, 5, R
		MouseClick right
		Sleep % LAG_FACTOR*150
		ImageSearch expand_x, expand_y, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %inventory_expand_image%
		if (expand_x) {
			MouseMove expand_x, expand_y, 5
			MouseClick
		} else {
			MsgBox image not found
		}		
	}
}

^d::
	Drink()
return
