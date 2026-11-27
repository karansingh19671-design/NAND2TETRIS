// Box.asm  --  Capstone, K = 48
// While any key is pressed, draw a black box; when released, clear it.
// Box: starts at row 48, 20 rows tall, 16*((48 mod 4)+1) = 16 pixels wide (1 word).
// First word address = SCREEN + 32*48 = 16384 + 1536 = 17920.

(LOOP)
    @KBD
    D=M
    @BLACK
    D;JNE           // key pressed -> black
    @color
    M=0             // no key -> white
    @DRAW
    0;JMP
(BLACK)
    @color
    M=-1            // all 16 bits set = black

(DRAW)
    @17920          // top-left word of the box (row 48, column 0)
    D=A
    @addr
    M=D
    @20             // 20 rows
    D=A
    @rows
    M=D

(ROW)
    @color
    D=M
    @addr
    A=M
    M=D             // word 0  (pixels 0-15)

    @32             // move down one screen row (32 words)
    D=A
    @addr
    M=D+M

    @rows
    MD=M-1
    @ROW
    D;JGT

    @LOOP
    0;JMP
