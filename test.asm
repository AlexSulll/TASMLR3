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
    
    push    offset A
    push    offset B
    push    offset C
    
    call    schet
    mov     [D],eax
    
Exit:
    mov     ah,4Ch
    int     21h
schet proc near
    mov     si,[esp+2]
    mov     ch,[si]
    mov     si,[esp+4]
    mov     bh,[si]
    mov     si,[esp+6]
    mov     bl,[si]
    movsx   eax,bh
    mov     ebp,eax
    sal     ebp,2
    sal     eax,1
    add     ebp,eax
    movsx   eax,bl
    imul    ebp
    mov     ebp,eax
    movsx   eax,ch
    add     ebp,eax
    jz      Exit
    mov     esi,ebp
    movsx   ebp,ch
    movsx   eax,bh
    mov     edi,eax
    mov     edx,eax
    sal     edi,5
    sal     edx,2
    sub     edi,edx
    imul    eax
    imul    edi
    sub     ebp,19
    add     eax,ebp
    cdq
    idiv    esi
    ret     6
    schet   endp
end     Start 
