; This is a PAL version of the game
; Made with ❤️ by Sasser7

    processor 6502

    include "vcs.h"
    include "macro.h"

NUM_SCANLINES = 242 ; 242 for PAL, 192 for NTSC

    seg Code
    org $F000   ; Define the code origin at $F000

Start:
    CLEAN_START

RenderLoop:

    lda #2

    sta VBLANK
    sta VSYNC

    sta WSYNC
    sta WSYNC
    sta WSYNC

    lda #0

    sta VSYNC

    ldx #37
VBlankLoop:
    sta WSYNC
    dex
    bne VBlankLoop

    lda #0
    sta VBLANK

    ldx #NUM_SCANLINES
VisibleLoop:
    stx COLUBK
    sta WSYNC
    dex
    bne VisibleLoop

    lda #2
    sta VBLANK

    ldx #30
LoopOverscan:
    sta WSYNC
    dex
    bne LoopOverscan

    jmp RenderLoop

    org $FFFC   ; Fill the ROM size to 4KB
    .word Start
    .word Start