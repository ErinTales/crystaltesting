	nop
Function3f43::
	nop
	add hl, de
	ret

Function3f46:: ; unreferenced
	call MenuBoxCoord2Tile
jp_3f49::
	call GetMenuBoxDims
	dec b
	dec c
	call Function3eb4
	ret

Function3f52:: ; unreferenced
	ld hl, $d000
	ld b, $00
.jr_3f57:
	push bc
	ld c, $08
.jr_3f5a
	ld a, [de]
	inc de
	cpl
	ld [hl], $00
	inc hl
	ld [hli], a
	dec c
	jr nz, .jr_3f5a

	pop bc
	dec c
	jr nz, .jr_3f57
	ret

Function3f6b:: ; unreferenced
	ld hl, $d000
.jr_3f6c
	push bc
	ld c, $08
.jr_3f6f
	ld a, [de]
	inc de
	inc de
	cpl
	ld [hl], $00
	inc hl
	ld [hli], a
	dec c
	jr nz, .jr_3f6f
	pop bc
	dec c
	jr nz, .jr_3f6c
	ret