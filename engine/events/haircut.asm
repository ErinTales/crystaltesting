BillsGrandfather:
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, [wCurPartySpecies]
	ld [wScriptVar], a
	ld [wNamedObjectIndex], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

.cancel
	xor a
	ld [wScriptVar], a
	ret

OlderHaircutBrother:
	ld hl, HappinessData_OlderHaircutBrother
	jr HaircutOrGrooming

YoungerHaircutBrother:
	ld hl, HappinessData_YoungerHaircutBrother
	jr HaircutOrGrooming

DaisysGrooming:
	ld hl, HappinessData_DaisysGrooming
	; fallthrough

HaircutOrGrooming:
	push hl
	farcall SelectMonFromParty
	pop hl
	jr c, .nope
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	push hl
	call GetCurNickname
	call CopyPokemonName_Buffer1_Buffer3
	pop hl
	call Random
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	inc hl
	jr .loop

.ok
	inc hl
	ld a, [hli]
	ld [wScriptVar], a
	ld c, [hl]
	call ChangeHappiness
	ret

.nope
	xor a
	ld [wScriptVar], a
	ret

.egg
	ld a, 1
	ld [wScriptVar], a
	ret

INCLUDE "data/events/happiness_probabilities.asm"

CopyPokemonName_Buffer1_Buffer3:
	ld hl, wStringBuffer1
	ld de, wStringBuffer3
	ld bc, MON_NAME_LENGTH
	jp CopyBytes

DummyPredef1:
	ret

Function01_7e17:
	ld hl, $7e61
	jr $7e1f
	ld hl, $7e6a
Function01_7e1c:
	push hl
	ld a, $14
	ld hl, $4000
	rst $08
	pop hl
	jr c, jr_001_7e4d

	ld a, [$d0c8]
	cp $fd
	jr z, jr_001_7e52

	push hl
	call $38a9
	call $7e6d
	pop hl
	call $2f9b

jr_001_7e3b:
	sub [hl]
	jr c, jr_001_7e43

	inc hl
	inc hl
	inc hl
	jr jr_001_7e3b

jr_001_7e43:
	inc hl
	ld a, [hl+]
	ld [$c2dd], a
	ld c, [hl]
	call $7bbb
	ret


jr_001_7e4d:
	xor a

Call_001_7e4e:
	ld [$c2dd], a
	ret


jr_001_7e52:
	ld a, $01
	ld [$c2dd], a
	ret


	ld c, h
	ld [bc], a
	add hl, bc
	add b
	inc bc
	ld a, [bc]
	rst $38
	inc b
	dec bc
	sbc d
	ld [bc], a
	inc c
	ld c, h
	inc bc
	dec c
	rst $38
	inc b
	ld c, $ff
	ld [bc], a
	ld [de], a

Call_001_7e6d:
	ld hl, $d05b
	ld de, $d071
	ld bc, $0006
	jp $302f


	ld a, $3f
	ld hl, $56db
	rst $08
	jp $63ec
