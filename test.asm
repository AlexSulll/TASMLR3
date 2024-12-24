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
    
    jmp     Exit
schet proc near
    mov     si,[esp+2]
    mov     ch,[si]
    mov     si,[esp+4]
    mov     bh,[si]
    mov     si,[esp+6]
    mov     bl,[si]
Answer:
    movsx   eax,bh
    mov     ebp,eax
    sal     ebp,2
    sal     eax,1
    add     ebp,eax
    movsx   eax,bl
    imul    ebp
    or      edx,edx
    jz      positive_6ab
    cmp     edx, 0FFFFFFFFh
    jz      negative_6ab
positive_6ab:
    mov     esi,eax 
    movsx   eax,ch
    or      eax,eax
    js      negative_c1
    add     esi,eax
    jz      vihod
    jmp     chislitel
negative_6ab:    
    mov     esi,eax
    movsx   eax,ch
    or      eax,eax
    js      negative_c2
    add     esi,eax
    jz      vihod
    jmp     chislitel
negative_c1:
    neg     eax
    sub     esi,eax
    jz      vihod
    jmp     chislitel
negative_c2:
    neg     eax
    sub     esi,eax
    jz      vihod
chislitel:
    movsx   eax,ch
    mov     ebp,eax
    movsx   eax,bh
    mov     edi,eax
    mov     edx,eax
    sal     edi,5
    sal     edx,2
    sub     edi,edx
    imul    eax
    imul    edi
    sub     ebp,19
    jns     positive_c
    jz      division
negative_c:
    neg     ebp
    sub     eax,ebp
    jmp     division
positive_c:
    add     eax,ebp
division:
    idiv    esi
    mov     [D],eax
vihod:
    ret
    schet   endp   
Exit:
    mov     ah,04ch
    mov     al,0
    int     21h
    end     Start 