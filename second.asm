.model      small
.386
.stack      100h
.data
    A           db      ?
    B           db      ?
    C           db      ?
    D           dd      ?
.code
Start:
    mov     ax,@data
    mov     ds,ax
    mov     es,ax
    
    push    A
    push    B
    push    C
    
    call    schet
    mov     [D],eax
    
Exit:
    mov     ah,4Ch
    int     21h
schet proc near
	 push    bp
    mov     bp,sp
    mov     ch,[bp+4]
    mov     bh,[bp+6]
    mov     bl,[bp+8]

    mov     al,bh
    imul    bl
    cwde
    mov     ebp,eax
    sal     eax,2
    sal     ebp,1
    add     ebp,eax
    movsx   eax,ch
    add     ebp,eax
    jz      Exit
    mov     esi,ebp

    movsx   ax,bh
    mov     bp,ax
    sal     bp,5
    sal     ax,2
    sub     bp,ax
    mov     al,bh
    imul    bh
    imul    bp
    shl     edx,16
    or      eax,edx
    movsx   ecx,ch
    add     eax,ecx
    sub     eax,19
    cdq
    idiv    esi
    pop     bp
    ret     6
    schet   endp
end     Start