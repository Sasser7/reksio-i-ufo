; This is an NTSC version of the game
; Made with ❤️ by Karol Stępień (Sasser7)

    processor 6502

    include "vcs.h"
    include "macro.h"

    seg Code
    org $F000   ; Define the code origin at $F000

Start:
    CLEAN_START

    ldx #$92
    stx COLUBK

    ldx #$1E
    stx COLUPF

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
    ;;    set CTRLPF    ;;
    ;;;;;;;;;;;;;;;;;;;;;;

    ldx #%00000001
    stx CTRLPF

    ;;;;;;;;;;;;;;;;;;;;;;
    ;; Visible Picture  ;;
    ;;;;;;;;;;;;;;;;;;;;;;

    ldx #0
    stx PF0
    stx PF1
    stx PF2
    REPEAT 7
        sta WSYNC
    REPEND

    ldx #%11100000
    stx PF0
    ldx #%11111111
    stx PF1
    stx PF2
    REPEAT 7
        sta WSYNC
    REPEND

    ldx #%01100000
    stx PF0
    ldx #0
    stx PF1
    ldx #%10000000
    stx PF2
    REPEAT 164
        sta WSYNC
    REPEND

    ldx #%11100000
    stx PF0
    ldx #%11111111
    stx PF1
    stx PF2
    REPEAT 7
        sta WSYNC
    REPEND

    ldx #0
    stx PF0
    stx PF1
    stx PF2
    REPEAT 7
        sta WSYNC
    REPEND

    ;;;;;;;;;;;;;;;;;;;;;;
    ;;  LOOP OVERSCAN   ;;
    ;;;;;;;;;;;;;;;;;;;;;;

    lda #2
    sta VBLANK
    REPEAT 30
        sta WSYNC
    REPEND
    lda #0
    sta VBLANK
    ;;;;;;;;;;;;;;;;;;;;;;
    jmp NextFrame

    org $FFFC   ; Fill the ROM size to 4KB
    .word Start
    .word Start