
; Script Function:
;	ARK: Survival Evolved automation and all keyboard controls instead of mouse
;
; Changed Hotkeys within ARK:
; WASD to arrow keys instead of
;	:*:w::{Up}
;	:*:s::{Down}
;	:*:a::{Left}
;	:*:d::{Right}
; Look Up	PageUp
; Look Down	PageDown
; Strafe Right	Period (Nulls WHISTLE "ATTACK THIS TARGET": Period)
; Strafe Left	Comma (Nulls WHISTLE "ALL MOVE TO": Comma)
;
; Other/Default Hotkeys
;
; MOVE FORWARD: W						USE SLOT ITEM I: One		TOGGLE WEAPON ATTACHMENT: N
; MOVE BACKWARD: S						USE SLOT ITEM 2: Two		DROP ITEM: 0
; STRAFE LEFT: A						USE SLOT ITEM 3: Three		CRAFT SLOT ITEM (MODIFIER): LeftAlt
; STRAFE RIGHT: D						USE SLOT ITEM 4: Four		EMOTE KEY LeftBrachet
; RUN: LeftShift						USE SLOT ITEM 5: Five		EMOTE KEY 2: RightBrachet
; JUMP: SpaceBar						USE SLOT ITEM 6: Six		WHISTLE SELECTION: Apostrophe
; CROUCH: C								USE SLOT ITEM 7: Seven		WHISTLE "ALL MOVE TO": Comma
; PRONE: X								USE SLOT ITEM 8: Eight		WHISTLE "ALL AGGRESSIVE": Subtract
; TOGGLE SPRINT: RightShift				USE SLOT ITEM 9: Nine		WHISTLE "ALL FOLLOW ME": J
; TURN RIGHT: Right						USE SLOT ITEM 10: Zero		WHISTLE "ALL STAY PUT": U
; TURN LEFT: Left						DRAG BODY: G				WHISTLE "YOU FOLLOW ME": T
; LOOK UP: Up							YOUR INVENTORY: I			WHISTLE "YOU STAY PUT": V
; LOOK DOWN: Down						YOUR CRAFTABLES: V			WHISTLE "ATTACK MY TARGET": Equals
; FIRE: LeftMouse						ACCESS TARGET INVENTORY: F	WHISTLE "ALL NEUTRAL": Hyphen
; IRON SIGHTS/ALT FIRE: RightMouse		TRIBE MANAGER: L			WHISTLE "ALL PASSIVE": Semicolon
; RELOAD: R 							MAP: M						WHISTLE "ATTACK THIS TARGET": Period
; USE: E								PLACE MAP MARKER: P			CYCLE TARGET FOLLOW DISTANCE: NumPadZero
; MELEE/PISTOL WHIP LeftControl			TOGGLE CONSOLE: Tab			ORDER ADD/REMOVE TAME: Z
; DEFECATE: Add					`		TOGGLE HUD: BackSpace		
; TOGGLE FISTS: Q						EXTENDED HUD INFO: H
; TOGGLE SELFIE CAM: RightAlt			PUSH TO TALK: B
; TOGGLE ORBIT CAMERA: K 				TOGGLE CHATBOX: Backslash
; ZOOM CAMERA IN: MouseScrollUp			LOCAL CHAT: Insert
; ZOOM CAMERA OUT: MouseScrollDown		TRIBE CHAT: Slash 
;
; Script Hotkeys:
;	\		Global stop key (walking, running, mining, farming, etc)
;	[		Autowalk
;	]		Autorun
;	LCtrl

; Default ARK Controls
;	E	Use

;Reusable Bola:
;cheat giveitem "Blueprint'/Game/Mods/ReusablePlus/Bola/PrimalItem_WeaponReusableBola.PrimalItem_WeaponReusableBola'" 2 0 0
;Reusable Flare Gun:
;cheat giveitem "Blueprint'/Game/Mods/ReusablePlus/FlareGun/PrimalItem_WeaponReusableFlareGun.PrimalItem_WeaponReusableFlareGun'" 1 0 0
;Reusable Grappling Hook:
;cheat giveitem "Blueprint'/Game/Mods/ReusablePlus/GrapplingHook/PrimalItemAmmo_ReusableGrapplingHook.PrimalItemAmmo_ReusableGrapplingHook'" 1 0 0
;Reusable Parachute:
;cheat giveitem "Blueprint'/Game/Mods/ReusablePlus/Parachute/PrimalItemConsumableBuff_ReusableParachute.PrimalItemConsumableBuff_ReusableParachute'" 1 0 0
;Reusable Spear:
;cheat giveitem "Blueprint'/Game/Mods/ReusablePlus/Spear/PrimalItem_WeaponReusableSpear.PrimalItem_WeaponReusableSpear'" 2 0 0

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force ; Only one instance at a time
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;; DEBUG output
Cinit()
running := 0
spaceDisabled := False

;|::
;+::
;=::
\::
	Cadd("stop everything")
	; stop movement
	ControlSend, , {LShift up}{Up up}, ARK: Survival Evolved
	; stop everything
	running := 0
	; stop spamming E
	eToggle := FALSE
	; stop spamming LCtrl
	LCtrlToggle := FALSE
return

#IfWinActive, ARK: Survival Evolved

; Starts spamming E (Use). The Use key is a PITA
eToggle = 0
#MaxThreadsPerHotkey 2
E::
	Cadd("Spamming E")
    eToggle := !eToggle ; reverses the variable, but if you want to make [E] key always turn this thing on - use TRUE instead
    While eToggle
	{
        ControlSend, , {E}, ARK: Survival Evolved
        sleep 100
    }
return

+E::
	; Shift+E, Hit E just once
	Cadd("hit e once")
	ControlSend, , {E}, ARK: Survival Evolved
return

W::
	; Hold E down for 5 seconds
	Cadd("holding e")
	ControlSend, , {E down}, ARK: Survival Evolved
	sleep 5000
	ControlSend, , {E up}, ARK: Survival Evolved
	Cadd("not holding e")
return

; Starts spamming Melee/Pistol Whip (LeftControl)
LCtrl::
	Cadd("Spamming LCtrl")
    LCtrlToggle := !LCtrlToggle ; reverses the variable, but if you want to make [E] key always turn this thing on - use TRUE instead
    While LCtrlToggle
	{
        ControlSend, , {LCtrl}, ARK: Survival Evolved
        sleep 100
    }
return

[::
	; walk
	Cadd("walk")
	ControlSend, , {LShift up}{Up down}, ARK: Survival Evolved
return

]::
	; run
	Cadd("run")
	ControlSend, , {LShift down}{Up down}, ARK: Survival Evolved
return



;CONSOLE CONTROLS
Cadd(text)
{
   global
   FormatTime, NowStamp, %A_now%, HH:mm:ss
   text := NowStamp . " " . text
   Ctext := text . "`n" . Ctext ;newest lines on top of course
   GuiControl,consoleLog:, Ctext, %Ctext%
}

Cinit()
{
   ;; LOG CONSOLE GUI
   Gui, consoleLog:Add, Edit,w400 h200 vCtext hScroll
   Gui, consoleLog:show, AutoSize x0 y0
}