PhotoStudio:
	ld hl, .WhichMonPhotoText
	call PrintText
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg

	ld hl, .HoldStillText
	call PrintText
	call DisableSpriteUpdates
	farcall PrintPartymon
	call ReturnToMapWithSpeechTextbox
	ldh a, [hPrinter]
	and a
	jr nz, .cancel
	ld hl, .PrestoAllDoneText
	jr .print_text

.cancel
	ld hl, .NoPhotoText
	jr .print_text

.egg
	ld hl, .EggPhotoText

.print_text
	call PrintText
	ret

.WhichMonPhotoText:
	text_start _WhichMonPhotoText
	text_end

.HoldStillText:
	text_start _HoldStillText
	text_end

.PrestoAllDoneText:
	text_start _PrestoAllDoneText
	text_end

.NoPhotoText:
	text_start _NoPhotoText
	text_end

.EggPhotoText:
	text_start _EggPhotoText
	text_end
