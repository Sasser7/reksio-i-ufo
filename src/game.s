    processor 6502

    seg code
    org $F000   ; Define the code origin at $F000

start:
    sei      ; Disable interrupts
    cld      ; Disable decimal mode
    ldx #$FF  ; Set the stack pointer
    txs      ; Set it


    lda #0
    ldx #$FF

memLoop:
    sta $0000,x
    dex
    bne memLoop     ; Loop until z-flag is set

    org $FFFC   ; Fill the ROM size to 4KB
    .word start
    .word start