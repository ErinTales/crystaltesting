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
	ld hl, wDecompressScratch
	ld b, 0
.row:
	push bc
	ld c, 1 tiles / 2
.col
	ld a, [de]
	inc de
	cpl
	ld [hl], $00
	inc hl
	ld [hli], a
	dec c
	jr nz, .col
	pop bc
	dec c
	jr nz, .row
	ret

Function3f6b:: ; unreferenced
	ld hl, wDecompressScratch
.row
	push bc
	ld c, 1 tiles / 2
.col
	ld a, [de]
	inc de
	inc de
	cpl
	ld [hl], $00
	inc hl
	ld [hli], a
	dec c
	jr nz, .col
	pop bc
	dec c
	jr nz, .row
	ret