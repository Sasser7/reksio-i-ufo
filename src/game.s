    processor 6502

    include "vcs.h"
    include "macro.h"

    seg Code
    org $F000   ; Define the code origin at $F000

Start:
    CLEAN_START

GameLoop:
    lda #$B4    ; PAL blue
    sta COLUBK

    jmp GameLoop

    org $FFFC   ; Fill the ROM size to 4KB
    .word Start
    .word Start