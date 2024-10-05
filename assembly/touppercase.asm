; pesquisa palavras específicas em um arquivo texto e retorna as mesmas especificando a linha e deixando a palavra procurada em maiusculo
.model small
.stack 100h

	cr 			equ 13
	lf 			equ 10
	buff_size	equ 100

.data
	ptrAtual     dw 0
	byteslidos				dw 0
	handlearq   			dw 0
	flagOcorr    			dw 0
	flagPos				dw 0
	flagCR					dw 0
	flagEOF				dw 0
	contLinha 				dw 0

	msg			db "$"
	buscatxt 		db "-- Que palavra voce quer buscar?", cr,lf,0
	ocorrenciastxt 		db "-- Foram encontradas as seguintes ocorrencias:", cr,lf,0
	naoOcorrenciastxt 		db "-- Nao foram encontradas ocorrencias.", cr,lf,0
    buscanovtxt 		db "-- Quer buscar outra palavra? (s/n)", cr,lf,0
    somentetxt 		db "-- Por favor, responda somente s ou n.", cr,lf,0
	linhatxt		db "Linha ",0
	doispontostxt        db ": ",0
	fimocorrenciastxt		db "-- Fim das ocorrencias.",cr,lf,0
	encerrandotxt 	db "-- Encerrando...", cr,lf,0
	msgerroabr	db "-- Erro ao abrir arquivo!$"
	msgerroler	db "-- Erro ao ler arquivo!$"

	sw_n			dw	0
	sw_f			db	0
	sw_m			dw	0
	bufferwrword	db	10 dup (?)

	cmdline 			db 128 dup(?)
	palavraPrev 			db 50 dup(?)
	palavraAtual 		    db 50 dup(?)
	palavraPos 	        db 50 dup(?)
	palavraAux 	        db 50 dup(?)
	buffarq				db buff_size dup(?)
	palavra 	db 50 dup(?)
	palavraTam  			db 0
	buffTec 		db 100 dup(?)
	contLinhaStr 	db 10 dup(?)


.code
	.startup

	push ds
	push es

	mov ax, ds
	mov bx, es
	mov ds, bx
	mov es, ax

	mov si, 80h
	mov ch, 0
	mov cl, [si]
	mov ax, cx

	mov si, 81h
	inc si
	dec cx
	lea di, cmdline
	rep movsb

	pop es
	pop ds

	call main
.exit


main proc 	near

loopMain:

    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx

    mov byte ptr contLinha, 1
	mov byte ptr flagOcorr, 0
	mov byte ptr flagPos,  0
	mov byte ptr flagCR,   0
	mov byte ptr flagEOF,  0

    call fopen

    lea bx, buscatxt
    call printf_s

    call limpaPalavra

    mov cx, 20
    lea bx, palavra
    call scanf
    call printf_n

    lea bx, palavra
    call toUpperCase

    xor cx, cx
    xor dx, dx

    call verificaStr

    cmp ax, 0
    je 	palavraInvalida
    jmp palavraValida

palavraInvalida:
    lea bx, buscanovtxt
    call printf_s

	call limpaPalavra

	lea bx, buffTec
	mov cx, 1
    call scanf

    cmp byte ptr [buffTec], 'S'
    je 	sim1
	cmp byte ptr [buffTec], 's'
    je 	sim1
	cmp byte ptr [buffTec], 'N'
    je 	nao1
	cmp byte ptr [buffTec], 'n'
    je 	nao1
	call printf_n
    jmp outro1

sim1:
	call printf_n
    mov ah, 3eh
    mov bx, handlearq
    int 21h
    jmp loopMain

nao1:
	call printf_n
    mov ah, 3eh
    mov bx, handlearq
    int 21h
	jmp encerrando

outro1:
	lea bx, somentetxt
    call printf_s
	jmp palavraInvalida

palavraValida:
    xor bx, bx
    xor si, si
    xor di, di

proxPalavra:
	lea si, palavraAtual
	call limpaStr

    lea bx, palavraAtual
    mov ptrAtual, bx

proxChar:
    mov ah, 3fh
    mov dx, ptrAtual
    mov cx, 1
    mov bx, handlearq
    int 21h
    jc 	fimArq
	cmp ax,0
	je 	ultimaPalavra

    mov bx, ptrAtual
    cmp [bx], 20h
    je 	casoNormal
    cmp [bx], lf
    je 	palavraCR

    inc ptrAtual
    jmp proxChar

ultimaPalavra:
	lea bx, ptrAtual
	mov di,1
	mov byte ptr [bx + di], 0

	lea bx, palavraAtual
    lea	di, palavraAux
	call removeCRLF
	lea bx, palavraAux
    lea di, palavraAtual
    call copiaPalavra

	cmp flagPos,1
	jne naoImprimePos
	mov byte ptr flagPos, 0

	lea bx, palavraAtual
	call printf_s
	call printf_n

naoImprimePos:
	lea	di, contLinhaStr
    call numDeLinhas

	mov byte ptr flagEOF, 1
	mov byte ptr flagCR, 1

	jmp comparacao

palavraCR:
	lea bx, ptrAtual
	mov di,1
	mov byte ptr [bx + di], 0

	lea bx, palavraAtual
    lea	di, palavraAux
	call removeCRLF
	lea bx, palavraAux
    lea di, palavraAtual
    call copiaPalavra

	cmp flagPos,1
	jne naoImprimePos2

	lea bx, palavraAtual
	call printf_s
	call printf_n

naoImprimePos2:
	lea di, contLinhaStr
    call numDeLinhas
	inc contLinha

	mov byte ptr flagCR, 1
	mov byte ptr flagPos, 0

	jmp comparacao

casoNormal:
	lea bx, ptrAtual
	mov di,1
	mov byte ptr [bx + di], 0

	cmp flagPos,1
	jne naoImprimePos3

	lea bx, palavraAtual
	call printf_s

	call printf_n


naoImprimePos3:
	lea di, contLinhaStr
    call numDeLinhas

	mov byte ptr flagCR, 0
	mov byte ptr flagPos, 1

comparacao:
	jmp comparacaoMaior

voltacomparacao:
    cmp ax, 0
    jne naoCombina

	call imprimeOcorrenciastxt

	call arrumaPalavra

	call imprimeCombinacao

	lea si, palavraPrev
	call limpaStr

	cmp flagEOF, 1
	jne naoFimArq
	call printf_n
	jmp fimArq
	
naoFimArq:
	cmp flagCR,1
	je 	naoSalvaPrev

    lea bx, palavraAtual
    lea di, palavraPrev
    call copiaPalavra

naoSalvaPrev:
    cmp flagCR,1
	jne naoFazPrintf_n

	call printf_n
	mov byte ptr flagCR,0

naoFazPrintf_n:
    jmp proxPalavra

naoCombina:
	lea si, palavraPrev
	call limpaStr

	cmp flagEOF, 1
	jne naoFimArq2
	jmp fimArq

naoFimArq2:
	cmp flagCR, 1
	je 	naoSalvaPrev2

    lea bx, palavraAtual
    lea di, palavraPrev
    call copiaPalavra


naoSalvaPrev2:
	mov byte ptr flagPos, 0
    jmp proxPalavra

fimArq:
    call fclose

	call novamenteOuNao

    lea bx, buscanovtxt
    call printf_s
	call limpaPalavra

	lea bx, buffTec
	mov cx, 1
    call scanf

    cmp byte ptr [buffTec], 'S'
    je 	sim2
	cmp byte ptr [buffTec], 's'
    je 	sim2
	cmp byte ptr [buffTec], 'N'
    je 	nao2
	cmp byte ptr [buffTec], 'n'
    je 	nao2
	call printf_n
    jmp outro2

sim2:
	call printf_n
    jmp loopMain
nao2:
	call printf_n
	jmp encerrando
outro2:
	lea bx, somentetxt
    call printf_s

    mov byte ptr contLinha, 1
	mov byte ptr flagOcorr, 0
	mov byte ptr flagPos,  0
	mov byte ptr flagCR,   0
	mov byte ptr flagEOF,  0

	jmp palavraInvalida

encerrando:
    lea bx, encerrandotxt
    call printf_s
	.exit

comparacaoMaior:
	call debugger

	lea si, palavraAux
	call limpaStr

    lea bx, palavraAtual
    lea di, palavraAux
    call somenteLetras

    lea bx, palavraAux
    call toUpperCase

    call comparaStrs

	jmp voltacomparacao

main endp

;################################################################################
;################################################################################

printf_s proc	near
	mov	dl,[bx]
	cmp	dl,0
	je	ps_1

	push bx
	mov	ah,2
	int	21h
	pop	bx

	inc	bx

	jmp	printf_s

ps_1:
	ret

printf_s	endp

printf_n	proc 	near

	mov ah, 02h
    mov dl, lf
    int 21h
    mov dl, cr
    int 21h

    ret

printf_n endp

printEspaco proc	near

	mov ah, 02h
	mov dl, ' '
	int 21h

	ret

printEspaco	endp

scanf	proc	near
		mov	dx,0

rdstr_1:
		mov	ah,7
		int	21h

		cmp	al,0dh
		jne	rdstr_a

		mov	byte ptr[bx],0

		ret

rdstr_a:
		cmp	al,08h
		jne	rdstr_b
		
		cmp	dx,0
		jz	rdstr_1

		push dx
		
		mov	dl,08h
		mov	ah,2
		int	21h

		mov	dl,' '
		mov	ah,2
		int	21h

		mov	dl,08h
		mov	ah,2
		int	21h

		pop	dx

		dec	bx

		inc	cx

		dec	dx

		jmp	rdstr_1
		
rdstr_b:
		cmp	cx,0
		je	rdstr_1

		cmp	al,' '
		jl	rdstr_1

		mov	[bx],al

		inc	bx

		dec	cx

		inc	dx

		push dx
		mov	dl,al
		mov	ah,2
		int	21h
		pop	dx
		jmp	rdstr_1

scanf	endp


verificaStr proc	near
	lea si, palavra
	xor ax, ax
	cld

loopVertificaStr:
	lodsb
	cmp	al, 0
	je fimVerifica

	cmp	al, '0'
	jl 	naoValidado
	cmp al, '9'
	jle charValidada

	cmp	al, 'A'
	jl 	naoValidado
	cmp al, 'Z'
	jle charValidada

	cmp al, 'a'
	jl 	naoValidado
	cmp al, 'z'
	jle charValidada

	cmp al, cr
	je 	naoValidado

naoValidado:
	mov ax, 0
	ret

charValidada:
	jmp loopVertificaStr

fimVerifica:
	mov ax, 1
	ret

verificaStr endp

limpaPalavra	proc	near
	lea di, palavra
	mov cx, 20
	xor al, al

	rep	stosb

	ret

limpaPalavra	endp

toUpperCase 	proc 	near
loopUpper:
    mov al, [bx]
    cmp al, 0
    je 	fimUpper
    cmp al, 'a'
    jb 	proxUpper
    cmp	al, 'z'
    ja 	proxUpper
    sub al, 32
    mov byte ptr [bx], al
proxUpper:
    inc	bx
    jmp	loopUpper

fimUpper:
    ret

toUpperCase endp

somenteLetras	proc 	near
    cld
proxChar1:
    mov al, [bx]
    inc bx
    cmp al, 0
    je 	fimSomenteLetras

    cmp al, 'A'
    jb 	pulaChar
    cmp al, 'Z'
    jbe	mantemChar

    cmp al, 'a'
    jb 	pulaChar
    cmp al, 'z'
    jbe mantemChar

    cmp al, '0'
    jb 	pulaChar
    cmp al, '9'
    jbe mantemChar

pulaChar:
    jmp proxChar1

mantemChar:
    mov [di], al
    inc di
    jmp proxChar1

fimSomenteLetras:
    mov al, 0
    mov [di], al
    ret

somenteLetras endp

removeCRLF	proc	near
    cld

proxChar3:
    mov al, [bx]
    inc bx
    cmp al, 0
    je 	fimRemoveCRLF

    cmp al, cr
    jb 	pulaRemove
    cmp	al, lf
    jb 	pulaRemove
    jmp mantemRemove

pulaRemove:
    jmp proxChar3

mantemRemove:
    mov	[di], al
    inc	di
    jmp proxChar3

fimRemoveCRLF:
	mov al, 0
    mov	[di], al

	ret

removeCRLF	endp

copiaPalavra	proc	near

copiaLoop:
    mov al, [bx]
    mov	[di], al
    inc bx
    inc di
    cmp al, 0
    jne copiaLoop

    ret

copiaPalavra endp

numDeLinhas proc 	near
    mov cx, 0
    mov ax, contLinha
    mov bx, 10
    mov si, di

loopNumLinhas:
    xor dx, dx
    div bx
    add dl, '0'
    push dx
    inc cx
    cmp ax, 0
    jne loopNumLinhas

escreveDigitos:
    pop	dx
    mov [di], dl
    inc di
    loop escreveDigitos

    mov byte ptr [di], 0
    ret

numDeLinhas endp

limpaStr 	proc 	near

    mov cx, 50

limpaStr_loop:
    mov byte ptr [si], 0
    inc si
    loop limpaStr_loop
    ret

limpaStr 	endp

comparaStrs	proc 	near
    push cx
    push si
    push	di

	lea	si, palavra
    lea di, palavraAux

comparaStrs_loop:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne	strDif
    cmp al, 0
    je 	strIgual
    inc si
    inc di
    jmp comparaStrs_loop

strIgual:
    xor	ax, ax
    jmp fimCompara

strDif:
    mov ax, 1

fimCompara:
    pop di
    pop si
    pop cx

    ret

comparaStrs endp

debugger	proc    near
	lea	dx,msg
	mov ah,9
	int	21h
	ret

debugger 	endp

imprimeOcorrenciastxt			proc 	near

	cmp flagOcorr, 0
	jne naoImprime
	lea bx, ocorrenciastxt
	call printf_s
	mov byte ptr flagOcorr, 1

naoImprime:
	ret

imprimeOcorrenciastxt	endp

arrumaPalavra	proc	near
	call debugger

	lea si, palavraAux
	call limpaStr


	lea bx, palavraAtual
    lea di, palavraAux
    call copiaPalavra


	lea bx, palavraAux
    call toUpperCase

	ret

arrumaPalavra	endp

imprimeCombinacao	proc	near

	call debugger
    lea bx, linhatxt
    call printf_s

	lea bx, contLinhaStr
	call printf_s

	lea bx, doispontostxt
	call printf_s

    lea bx, palavraPrev
    call printf_s
	
    lea bx, palavraAux
    call printf_s

	ret

imprimeCombinacao	endp

novamenteOuNao	proc	near
	cmp flagOcorr, 0
	je 	printNaoOcorr
	call debugger
	lea bx, fimocorrenciastxt
	call printf_s
	jmp naoImprimeNov

printNaoOcorr:
	call debugger
	lea bx, naoOcorrenciastxt
	call printf_s

naoImprimeNov:
	ret
novamenteOuNao	endp

fopen	proc 	near

	lea dx,cmdline
	mov	al,0
	mov ah,3dh
	int	21h
	jc 	erroabrir
	mov	handlearq,ax
	jmp fimFopen

	erroabrir:
	lea dx,msgerroabr
	mov ah,9
	int 21h
	.exit
	jmp	fimFopen

fimFopen:
	ret

fopen endp

fclose	proc	near

    mov ah, 3eh
    mov bx, handlearq
    int 21h
	ret

fclose endp

end
