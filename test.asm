.model      small
.386
.stack      100h
.data
    A           db      52d
    B           db      -52d
    C           db      52d
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
    movsx   eax,bh ;eax = b
    mov     ebp,eax ;ebp = b
    sal     ebp,2 ; ebp = 4b
    sal     eax,1 ;eax = 2b
    add     ebp,eax ;ebp = 6b
    movsx   eax,bl ; eax = a
    imul    ebp;eax = 6ab
    movsx   eax,ch
    add     ebp,eax
    jz      Exit
    mov     esi,ebp
    movsx   eax,ch ;eax = c
    mov     ebp,eax ;ebp = c
    movsx   eax,bh ; eax = b
    mov     edi,eax ; edi = b
    mov     edx,eax ; edx = b
    sal     edi,5
    sal     edx,2
    sub     edi,edx ; edi = 28b
    imul    eax ; eax = b^2
    imul    edi ;eax = 28 b^3
    sub     ebp,19
    add     edi,ebp
    mov     eax,edi
    cdq
    idiv    esi
    ret     6
    schet   endp
end     Start 