; This is an NTSC version of the game
; Made with ❤️ by Karol Stępień (Sasser7)

    processor 6502

    include "vcs.h"
    include "macro.h"

    seg Code
    org $F000   ; Define the code origin at $F000

Start:
    CLEAN_START
NextFrame:
    ;;;;;;;;;;;;;;;;;;;;;;
    ;;  Vertical sync   ;;
    ;;;;;;;;;;;;;;;;;;;;;;
    lda #2
    sta VBLANK
    sta VSYNC

    REPEAT 3
        sta WSYNC
    REPEND

    lda #0
    sta VSYNC
    ;;;;;;;;;;;;;;;;;;;;;;
    ;;  Vertical Blank  ;;
    ;;;;;;;;;;;;;;;;;;;;;;
    REPEAT 37
        sta WSYNC
    REPEND
    lda #0
    sta VBLANK
    ;;;;;;;;;;;;;;;;;;;;;;
    ;; Visible Picture  ;;
    ;;;;;;;;;;;;;;;;;;;;;;
    ldx #$92
    REPEAT 7
        stx COLUBK
        sta WSYNC
    REPEND

    ldx #$1E
    REPEAT 7
        stx COLUBK
        sta WSYNC
    REPEND

    ldx #$92
    REPEAT 164
        stx COLUBK
        sta WSYNC
    REPEND

    ldx #$1E
    REPEAT 7
        stx COLUBK
        sta WSYNC
    REPEND

    ldx #$92
    REPEAT 7
        stx COLUBK
        sta WSYNC
    REPEND

    ldx #$00
    stx COLUBK
    ;;;;;;;;;;;;;;;;;;;;;;
    ;;  LOOP OVERSCAN   ;;
    ;;;;;;;;;;;;;;;;;;;;;;
    lda #2
    REPEAT 30
        sta WSYNC
    REPEND
    ;;;;;;;;;;;;;;;;;;;;;;
    jmp NextFrame

    org $FFFC   ; Fill the ROM size to 4KB
    .word Start
    .word Start