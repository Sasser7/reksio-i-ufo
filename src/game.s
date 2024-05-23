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

    ldx #$0E
    stx COLUP0

    ldx #$C6
    stx COLUP1

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

    ;;;;;;;;;;;;;;;;;;;;;;
    ;; Sprite Renderer  ;;
    ;;;;;;;;;;;;;;;;;;;;;;

    ldy #0
RenderPlayer:
    ldx Player,Y
    stx GRP0

    lda #0
    sta WSYNC

    iny
    cpy #9
    bne RenderPlayer

    ldy #0
    sty GRP0

    REPEAT 183
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

    org $FFF3
Player:
    .byte #%01000000, #%01100000, #%01011000, #%01111010, #%01110010, #%00111110, #%01111000, #%11110000, #%10110000    ; Sprite of Reksio

    org $FFFC   ; Fill the ROM size to 4KB
    .long Start