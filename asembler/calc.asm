; Ensamblador utilizado NASM 
;
;

	[BITS 16]           	; Set 16 bit code generation
	SEGMENT junk  		; Segment containing code

  	..start:            	; The two dots tell the linker to Start Here.                  		

  
	mov  ax,data      ; Move segment address of data segment into AX
	mov  ds,ax        ; Copy address from AX into DS
	mov  es,ax	  ;
	mov  ax,stack     ; Move segment address of stack segment into AX
	mov  ss,ax        ; Copy address from AX into SS

	mov  sp,stacktop  ; Point SP to the top of the stack

	;==============================|
	; MAIN 			       |
	;==============================|		

	Inicio:

	call Reset		; Limpiar variables

	call Menu		; Imprimir menu
	
	Opcion:

	call GetCh		; Leer caracter de seleccion de opcion del menu

	cmp al, 27		; es ESC ?
	je Fin			; terminal si es ESC

	cmp al, '1'		; es ASCII 1?
	jne Opt2		; saltar si no es igual

	call DoSuma		; ingresar los datos y operar la suma

	jmp Inicio		; repetir el ciclo

	Opt2:			

	cmp al, '2'		; es ASCII 2
	jne Opt3		; saltar si no es igual
	
	call DoResta		; ingresar datos y operar la resta
	
	jmp Inicio		; repetir el ciclo
	
	Opt3:

	cmp al, '3'		; es ASCII 3
	jne Opt4		; saltar si no es igual

	call DoMulti		; ingreasar datos y operar la multiplicacion
	
	jmp Inicio		; repetir el ciclo

	Opt4:

	cmp al, '4'		; es ASCII 4
	jne Opcion		; si no repetir el ingreso de caracter

	call DoDiv		; ingresar datos y operar la division
	
	jmp Inicio		; repetir ciclo

	Fin:
		

	mov ax, 04C00H  	; salir 
	int 21H         	; fin de programa


;======================================================================

	; funcion DoDiv
	; ingresa datos y opera la division
	
	DoDiv:

	call NewLine		;

	mov dx, Msg13		;
	call Writeln		;
	
	Call NewLine		;

	mov dx, Msg6		;
	call Write		;
	
	mov cx, 10		; 10 digitos
	mov di, OpA		; guardarlo en memoria OpA
	call Read128BitNum	; llamar a la funcion que lee el numero

	Call NewLine		;
	
	mov dx, Msg7		;
	call Write		;
	
	mov cx, 10		; 10 digitos
	mov di, OpB		; guardarlo en memoria OpB
	call Read128BitNum	; llamar a la funcion que lee el numero

	mov si, OpB		; parametros para comparar el operador B
	mov di, Cero128Bits	; con cero, division por cero?

	call Cmp128Bits		; compara dos numeros de 128bits
	je DoDivFin		; si el B == 0 error division por cero

	Call NewLine		;

	mov si, OpA		; parametros de la division
	mov di, OpB		; etc
	mov bx, prd		; resultado
 
	call Div128Bits		; funcion que divide dos numeros

	mov dx, Msg8		;

	call Write		;

	mov si, prd		; resultado de la division en binario
	mov cx, 20		;
	mov bx, Res		; 

	call  Write128BitS	; funcion que convierte de binario a decimal

	mov si,Res		; en Res esta guardado el numero en decimal como cadena
	
	call WriteNum		; imprimir el numero en pantalla 

	Call NewLine		;
	Call NewLine		;

	ret			;

	DoDivFin:

	Call NewLine		; Exception, en caso de division por cer
	mov dx, Msg14		; imprimir un mensaje extra de error
	call Writeln		; y regresar sin hacer nada.

	ret			;

;======================================================================

	; funcion DoMulti
	; ingresa datos y opera la multiplicacion
	
	DoMulti:

	call NewLine		;

	mov dx, Msg12		;
	call Writeln		;
	
	Call NewLine		;

	mov dx, Msg6		;
	call Write		;
	
	mov cx, 10		; ingresar un numero de 
	mov di, OpA		; 10 digitos y guardarlo
	call Read128BitNum	; en binario en OpA

	Call NewLine		;
	
	mov dx, Msg7		;
	call Write		;
	
	mov cx, 10		; Ingresar numero de 10
	mov di, OpB		; digitos en binario y guardarlo 
	call Read128BitNum	; en OpB

	Call NewLine		;

	mov si, OpA		;
	mov di, OpB		;
	mov bx, prd		; resultado de la multiplicacion

	call Mult128Bits	; realizar la multiplicacion 

	mov dx, Msg8		;

	call Write		;

	mov si, prd		;
	mov cx, 20		;
	mov bx, Res		;

	call  Write128BitS	; convertir de binario a decimal

	mov si,Res		;
	
	call WriteNum		; imprimir el resultado en pantalla

	Call NewLine		;
	Call NewLine		;

	ret			;


;======================================================================

	; funcion DoResta
	; ingresa datos y opera
	
	DoResta:

	call NewLine		;

	mov dx, Msg11		;
	call Writeln		;
	
	Call NewLine		;

	mov dx, Msg6		;
	call Write		;
	
	mov cx, 20		;
	mov di, OpA		;
	call Read128BitNum	;

	Call NewLine		;
	
	mov dx, Msg7		;
	call Write		;
	
	mov cx, 20		;
	mov di, OpB		;
	call Read128BitNum	;

	Call NewLine		;

	mov si, OpA		;
	mov di, OpB		;
	mov bx, prd		;

	call Resta128Bits	;

	mov dx, Msg8		;

	call Write		;

	mov si, prd		;
	mov cx, 20		;
	mov bx, Res		;

	call  Write128BitS	;

	mov si,Res		;
	
	call WriteNum		;

	Call NewLine		;
	Call NewLine		;

	ret			;


;======================================================================

	; funcion DoSuma
	; ingresa datos y opera
	
	DoSuma:

	call NewLine		;

	mov dx, Msg10		;
	call Writeln		;
	
	Call NewLine		;

	mov dx, Msg6		;
	call Write		;
	
	mov cx, 20		;
	mov di, OpA		;
	call Read128BitNum	;

	Call NewLine		;
	
	mov dx, Msg7		;
	call Write		;
	
	mov cx, 20		;
	mov di, OpB		;
	call Read128BitNum	;

	Call NewLine		;

	mov si, OpA		;
	mov di, OpB		;
	mov bx, prd		;

	call Suma128Bits	;

	mov dx, Msg8		;

	call Write		;

	mov si, prd		;
	mov cx, 20		;
	mov bx, Res		;

	call  Write128BitS	;

	mov si,Res		;
	
	call WriteNum		;

	Call NewLine		;
	Call NewLine		;

	ret			;

;======================================================================

	
	; funcion CeroStr
	; llena una cadena de 0's
	; Parametro cx cantidad de digitos
	; Parametro di direccion de la cadena a rellenar

	CeroStr:

	mov si, strCero		;

	cld			;

	CeroStrCopiar:

	movsb			;

	dec si			;
	
	loop CeroStrCopiar	;

	ret			;

;======================================================================

	; funcion Reset
	; pone a 0 las variables A B y RES, TMP y PRD

	Reset:

	mov si, OpA		;
	call SetCero128Bits	;

	mov si, OpB		;
	call SetCero128Bits	;

	mov si, prd		;
	call SetCero128Bits	;

	mov si, tmp		;
	call SetCero128Bits	;

	mov di, Res		;
	mov cx, 21		;
	call CeroStr		;

	ret			;

;======================================================================

	; funcion Menu
	; imprime las cadenas que forman el menu

	Menu:

	call NewLine		;
	call NewLine		;		

	mov dx, Msg1		;
	call Writeln		;
	
	mov dx, Msg2		;
	call Writeln		;

	mov dx, Msg3		;
	call Writeln		;

	mov dx, Msg4		;
	call Writeln		;

	mov dx, Msg9		;
	call Writeln		;

	call NewLine		;
	call NewLine		;		

	mov dx, Msg5		;
	call Writeln		;

	ret			;

;======================================================================

	; funcion Cmp128Bits
	; compararacion de 128 bits
	; si operador a
	; di operador b
	; al = 0 -> A = B
	; al = 1 -> A > B
	; al = 2 -> A < B

	Cmp128Bits

	mov eax, [si + 12] 	;
	mov ebx, [di + 12]	;

	cmp eax, ebx		;
	
	ja Cmp128BitsAgB	;
	jb Cmp128BitsBgA	;


	mov eax, [si + 8] 	;
	mov ebx, [di + 8]	;

	cmp eax, ebx		;
	
	ja Cmp128BitsAgB	;
	jb Cmp128BitsBgA	;

	mov eax, [si + 4] 	;
	mov ebx, [di + 4]	;

	cmp eax, ebx		;
	
	ja Cmp128BitsAgB	;
	jb Cmp128BitsBgA	;

	mov eax, [si]	 	;
	mov ebx, [di]		;

	cmp eax, ebx		;
	
	ja Cmp128BitsAgB	;
	jb Cmp128BitsBgA	;

;	mov al, 'E'		; depuracion
;	call PutCh		;

	
	mov al, 0		;
	cmp al , 0		;
	
	ret			;

	Cmp128BitsAgB	:

;	mov al, 'A'		; depuracion
;	call PutCh		; 
	
	mov al, 1		;
	cmp al, 0		;

	ret			;

	Cmp128BitsBgA	:

;	mov al, 'B'		; depuracion
;	call PutCh		;

	mov al, 0		;
	cmp al, 1		;

	ret			;

;======================================================================

	; funcion SetCero128Bits
	; si numero
	; pone un numero de 128bits a cero
	
	SetCero128Bits:

	xor eax, eax		; a Xor a = 0 
	mov [si], eax		; [si] = 0
	mov [si+4], eax		; bits 32-63
	mov [si+8], eax		; bits 64-95
	mov [si+12], eax	; bits 96-127
	
	ret			;


;======================================================================

	; funcion Inc128Bits
	; si operador a
	; ecx, incremento
	; incrementa el numero en SI , CX veces
	; osea, OP = OP + CX , pasando la direccion
	; de OP en si

	Inc128Bits:

	mov eax, [si]		; primera palabra doble
	mov edx, ecx		; incremento
	add eax, edx		; sumar las primar partes
	mov [si], eax		; guardar el resultado bajo
	
	mov eax, [si+4]		; segunda doble palabra
	mov edx, 0		; el incremento es solo de 32 bits a lo sumo
	adc eax, edx		; suma con carry
	mov [si+4], eax		; guardar ETC...
 
	mov eax, [si+8]		; ... 64-95
	mov edx, 0		;
	adc eax, edx		;
	mov [si+8], eax		;

	mov eax, [si+12]	; ... 96-127
	mov edx, 0		;
	adc eax, edx		;
	mov [si+12], eax	;
	
	ret			;


;======================================================================

	
	; funcion Div128Bits
	; si operador a
	; di operador b
	; bx resultado
	; divide dos numeros mediante 
	; restas sucesivas, y optimizada con dezplamientos
	; A / B ==> 
	; SI A > ( B * 4096 ) ENTONCES 
	; A = A - 4096 
	; RES = RES + B * 4096
	; para optimizar divisiones grandes

	Div128Bits:

	push si			;
	push di 		;
	push bx			;

	mov si, di		;
	mov di, tmp		;

	call ShiftLeft128Bits	; desplazar b a la izquierda.

	mov ecx, 11		; 11 desplazamientos que faltan para hacer los 12.
	
	mov si, tmp		;

	Div128BitsL1:

	call ShiftLeft128Bits	; 11 veces aqui
 
	loop Div128BitsL1	; al salir de este loop en tmp estara b * 4096 calculado con desplazamiento
	
	pop bx			;
	pop di			;
	pop si			;
	
	Div128BitsCiclo:        ; ciclo principal de la division, cuantas veces cabe el operador B
				; en el operador A? es contar la cantidad de restas, antes de que
				; A sea negativo.

	push si			;
	push di 		;
	push bx			;

	call Cmp128Bits		; Cmp A,B 

	pop bx			;
	pop di			;
	pop si			;

	jl Div128BitsFin	; Sale si B > A porque ya no cabe el operador B en A

	push si			;
	push di 		;
	push bx			;

	mov di, tmp		;

	call Cmp128Bits		; comparar con tmp que es B * 4096 para hacer la optimizacion
				; de divisiones grandes
		
	pop bx			;
	pop di			;
	pop si			;

	jl Div128BitsN		; si es menor, hacer el paso de 1 en 1 normalmente

	push si			;
	push di 		;
	push bx			;

	mov di, tmp		; sino restar tmp de A
				; osea A = A - 4096 * B

	mov bx, si		;

	call Resta128Bits	; operar la resta
	
	pop bx			;
	pop di			;
	pop si			;

	push si			;
	push di 		;
	push bx			;

	mov ecx, 4096		; incrementar el contador o resultado 	
				; en 4096

	mov si, bx		;

	call Inc128Bits		; sumar RES = RES + 4096;
	
	pop bx			;
	pop di			;
	pop si			;
	
	jmp Div128BitsCiclo	; repetir el proceso. 

	Div128BitsN:

	push si			;
	push di 		;
	push bx			;

	mov bx, si		;

	call Resta128Bits	; restar A - B 

	pop bx			;
	pop di			;
	pop si			;

	push si			;
	push di 		;
	push bx			;
	
	mov ecx, 1		; incrementar el resultado en 1
	mov si, bx		;

	call Inc128Bits		;

	pop bx			;
	pop di			;
	pop si			;

	jmp Div128BitsCiclo	;

	Div128BitsFin:

	ret			;

;======================================================================

	
	; funcion ShiftLeft128Bits
	; si numero a ser desplazado
	; di resultado
	; desplazar a la izquierda un numero de 128bits

	ShiftLeft128Bits:

	mov eax, [si]		;
	shl eax, 1		;
	mov [di], eax		;

	mov eax, [si + 4]	;
	rcl eax, 1		;
	mov [di + 4], eax	;

	mov eax, [si + 8]	;
	rcl eax, 1		;
	mov [di + 8], eax	;

	mov eax, [si + 12]	;
	rcl eax, 1		;
	mov [di + 12], eax	;
	
	ret			;

;======================================================================

	; funcion Mult128Bits
	; di operador a
	; si operador b
	; resultado en bx
	; multiplicar con sumas repetidas en un ciclo
	; y optimizaciones mediante shift a la izquierda
	

	Mult128Bits:

	Mult128BitsCiclo:
		
	mov eax, [si]		;
	or eax, [si+4]		;
	or eax, [si+8]		;
	or eax, [si+12]		;
	
	jz NEAR Mult128BitsFin	;

	xor eax, eax		;

	mov eax, [si+4]		;
	or eax, [si+8]		;
	or eax, [si+12]		;

	jz NEAR Opt23		;
	
;	mov al, 'A'		;
;	call PutCh		;

	push di			;
	push si			;
	
	mov si, di		;
	mov di, tmp		;

	call ShiftLeft128Bits	;
	mov si, tmp		;

	mov cx, 30		;

	Mult128BitsL1: 

	call ShiftLeft128Bits	;

	loop Mult128BitsL1	;
	
	mov di, tmp		;

	mov si, bx		;

	call Suma128Bits	;

	pop si			;
	pop di			;

	push bx			;

	push si			;
	push di			;
	
	mov bx, si		;
	
	mov di, DosA31		;

	call Resta128Bits	;	

	pop si			;
	pop di			;
	pop bx			;		

	jmp Mult128BitsCiclo	;

	Opt23:

	mov eax, [si]		;
	and eax, 0xFF000000	;	
	or eax, [si+4]		;
	or eax, [si+8]		;
	or eax, [si+12]		;

	jz NEAR Opt7		;
	
;	mov al, 'M'		;
;	call PutCh		;

	push di			;
	push si			;

	mov ecx, 5		;
	
	mov si, di		;
	mov di, tmp		;

	call ShiftLeft128Bits	;
	mov si, tmp		;
	mov cx, 22		;

	Mult128BitsL2: 

	call ShiftLeft128Bits	;

	loop Mult128BitsL2	;
	
	mov di, tmp		;

	mov si, bx		;

	call Suma128Bits	;

	pop si			;

	pop di			;

	mov ecx, 8388608	;

	call Dec128Bits		;	
		
	jmp Mult128BitsCiclo	;	

	Opt7:


	mov eax, [si]		;
	cmp eax, 256		;

	jb Mult128BitsN		;
	
;	mov al, 'R'		;
;	call PutCh		;

	push di			;
	push si			;
	
	mov si, di		;
	mov di, tmp		;

	call ShiftLeft128Bits	;
	mov si, tmp		;
	mov cx, 6		;

	Mult128BitsL3: 

	call ShiftLeft128Bits	;

	loop Mult128BitsL3	;
	
	mov di, tmp		;

	mov si, bx		;

	call Suma128Bits	;

	pop si			;

	pop di			;

	mov ecx, 128		;

	call Dec128Bits		;	
		
	jmp Mult128BitsCiclo	;	
	

	Mult128BitsN:	

	push si			;
	
	mov si, bx		;

	call Suma128Bits	;

	pop si			;

	mov ecx, 1		;

	call Dec128Bits		;	
		
	jmp Mult128BitsCiclo	;	

	Mult128BitsFin:

	ret			;

	
;======================================================================

	; Dec128Bits
	; decrementar un numero en ECX
	; si el numero
	; si = si - ecx
	; resta de 32 bits el segundo operador 

	Dec128Bits		;

	mov eax, [si]		;
	mov edx, ecx		;
	sub eax,edx		;
	
	mov edx, 0		;

	mov [si], eax		;
	
	mov eax, [si+4]		;
	sbb eax,edx		;
	mov [si+4], eax		;

	mov eax, [si+8]		;
	sbb eax,edx		;
	mov [si+8], eax		;

	mov eax, [si+12]	;
	sbb eax,edx		;
	mov [si+12], eax	;
	
	ret			;
	
;======================================================================

	; funcion Resta128Bits
	; si operador a
	; di operador b
	; resultado en bx
	; resta de dos numeros de 128bits en binario
	
	Resta128Bits:

	mov eax, [si]		;
	mov edx, [di]		;
	sub eax, edx		;
	mov [bx], eax		;
	
	mov eax, [si+4]		;
	mov edx, [di+4]		;
	sbb eax, edx		;
	mov [bx+4], eax		;

	mov eax, [si+8]		;
	mov edx, [di+8]		;
	sbb eax, edx		;
	mov [bx+8], eax		;

	mov eax, [si+12]	;
	mov edx, [di+12]	;
	sbb eax, edx		;
	mov [bx+12], eax	;
	
	ret			;

;======================================================================

	; funcion Suma128Bits
	; di operador a
	; si operador b
	; resultado en bx
	; sumar dos numeros de 128 bits

	Suma128Bits:

	mov eax, [di]		;
	mov edx, [si]		;
	add eax, edx		;
	mov [bx], eax		;
	
	mov eax, [di+4]		;
	mov edx, [si+4]		;
	adc eax, edx		;
	mov [bx+4], eax		;

	mov eax, [di+8]		;
	mov edx, [si+8]		;
	adc eax, edx		;
	mov [bx+8], eax		;

	mov eax, [di+12]	;
	mov edx, [si+12]	;
	adc eax, edx		;
	mov [bx+12], eax	;
	
	ret			;



;======================================================================

	; funcion Write128BitS	
	; bx cadena
	; si numero
	; convierte un numero de binario a decimal y lo almacena en una cadena 
	; como texto
	; soporta numeros negativos en formato de complemento a dos. 
	; si es negativo llama a una funcion Write128BitNum que antepone un 
	; signo negativo y calcula el complemento osea 0 - Numero antes de 
	; convertirlo a decimal

	Write128BitS:

	mov al, [si+15]		;
	and al, 10000000B	;
		
	jz Write128BitPos	;

	call Write128BitNumNeg	;

	jmp Write128BitSFin	;

	Write128BitPos:
	
	call Write128BitNum	;

	Write128BitSFin:
	
	
	ret			;
	
;======================================================================

	; funcion Write128BitNumNeg
	; sacar numero negativo.		
	; bx cadena de salida
	; si numero de entrada
	; convertir un numero negativo en base binaria 
	; a un numero decimal con signo "-" antepuesto

	Write128BitNumNeg:

	add bx, cx		;
	
	push si			;
	push bx			;

	mov bx, si		;

	mov di, si		;

	mov si, Cero128Bits	;

	call Resta128Bits	;
		
	pop bx			;
	pop si			;

	Write128BitNumcicloNeg:
	
	push bx			;
	call DivDiez		;
	pop bx			;

	or al, 0x30		;
	mov [bx],al		;
	dec bx			;
;	call PutCh		;		

	mov eax, [si];
	or eax, [si+4];
	or eax, [si+8];
	or eax, [si+12];

	jnz  Write128BitNumcicloNeg
	
	mov al, '-'		;
	mov [bx], al		;

	ret			;


;======================================================================
	
	; funcion Write128BitNum
	; BinToDec en cadena
	; si numero para convertir
	; bx cadena para rellenar
	; cx tamaño de la cadena
	; convierte un numero positivo en binario a decimal 

	Write128BitNum:

	mov di, si		;
	add bx, cx		;
		
	Write128BitNumciclo:
	
	push bx			;
	call DivDiez		;
	pop bx			;

	or al, 0x30		;
	mov [bx],al		;
	dec bx			;
;	call PutCh		;		

	mov eax, [si];
	or eax, [si+4];
	or eax, [si+8];
	or eax, [si+12];

	jnz  Write128BitNumciclo	;
	

	ret			;

	
;======================================================================

	; funcion DivDiez
	; Divide un numero de 128 bits, por 10
	; USADA SOLO PARA CONVERTIR DE BINARIO A DECIMAL, 
	; Parametro si direccion de la 128 bits de entrada
	; parametro di direccion de los 128 bits de salida
	
	; NOTA: esta funcion usa DIV solo para dividir por diez
	; y obtener el residuo que es utilizado en la conversion
	; de binario a decimal, no participa en la division.

	DivDiez:

	xor edx,edx		;
	mov eax, [si + 12]	;
	mov ebx, 10		;
	div ebx			;

	mov [di + 12], eax	;

	mov eax, [si + 8]	;
	div ebx			;

	mov [di + 8], eax	;

	mov eax, [si + 4]	;
	div ebx			;

	mov [di + 4], eax	;

	mov eax, [si]		;
	div ebx			;

	mov [di] , eax		;

	mov eax, edx		;

	ret			;

;======================================================================

		
	; funcion Read128BitNum
	; USAL MUL SOLO PARA CONVERTIR DE DECIMAL A BINARIO
	; AL PRESIONAR UN DIGITO, MULTIPLICA POR 10 y SUMA 
	; EL DIGITO
	; lee un numero de 128 bits
	; Parametro di direccion de la 128 bits de salida
	; cx , cantidad de digitos

	; Nota: en esta funcion se utiliza MULT. para convertir
	; los digitos ingresador por el teclado a un numero
	; en base binaria conforme son ingresados.	

	Read128BitNum:

	Read128NumCiclo:

	call GetCh		;
	cmp al, 13		;
	je NEAR Read128NumFin		;

	cmp al,0x30		; Caracter < '0' , no aceptar
	jb NEAR	Read128NumCiclo		;

	cmp al,0x39		; Caracter > '9' , no aceptar
	ja NEAR	Read128NumCiclo		;

	cmp cx, 0		;
	je NEAR Read128NumFin	;

	dec cx			;

	push cx			;
	push ax			;	

	or al, 0x30		;

	call PutCh		;

	mov eax, 10		;
	mov ebx, [di]		;
	mul ebx			;
	mov [di], eax		;
	mov ecx, edx		;
	mov eax, 10		;
	mov ebx, [di + 4]	;
	mul ebx			;
	add eax, ecx		;
	mov [di + 4], eax	;
	adc edx, 0		;
	mov ecx, edx		;
	mov eax, 10		;
	mov ebx, [di + 8]	;
	mul ebx			;
	add eax, ecx		;
	mov [di + 8], eax	;
	adc edx, 0		;
	mov ecx, edx		;
	mov eax, 10		;
	mov ebx, [di + 12]	;
	mul ebx			;
	add eax, ecx		;
	mov [di + 12], eax	;
	pop ax			;
	and eax, 0xF		;
	mov ebx, [di]		;
	add eax, ebx		;
	mov [di], eax		;
	mov eax, [di+4]		;
	adc eax, 0		;
	mov [di+4], eax		;
	mov eax, [di+8]		;
	adc eax, 0		;
	mov [di+8], eax		;
	mov eax, [di+12]	;
	adc eax, 0		;
	mov [di+12], eax	;

	pop cx			;

	jmp Read128NumCiclo	;
	
	Read128NumFin:

	call NewLine		;
			
	ret			;

;======================================================================


	; funcion WriteNum
	; Imprime un numero sin ceros a la izquierda
	; Parametro si direccion de la cadena a imprimir
	; imprime un numero almacenado en una cadena
	; quitando los ceros a la izquierda
	; 0000000000035 -> 35 

	WriteNum:

	WriteNumCiclo:
	
	mov al, [si]		;

	cmp al, '0'		;

	jne WriteNumFin		;

	inc si			;

	loop WriteNumCiclo	;

	WriteNumFin:

	mov dx, si		;

	call Write		;
	
	ret			;



;======================================================================

	; funcion Write
	; imprimir una cadena en pantalla
	;
	; Parametro dx direccion de la cadena	
	; imprime una cadena terminada en $ en pantalla

  	Write:
  	
	push ax			; preservar ax 
    	mov ah,0x9      	; funcion 9, imprimir en pantalla
    	int 0x21         	; interrupcion dos
	pop ax			; restaurar ax
	ret             	; return

;======================================================================

	; funcion Writeln
	; imprimir + enter
	;
	; Parametro dx direccion de la cadena	

  	Writeln:
  	
    	call Write      	; Display the string proper through Write
	mov dx,CRLF     	; Load offset of newline string to DX
	call Write      	; Display the newline string through Write
	ret             	; Return to the caller

;======================================================================

	; funcion HasKey
	; hay una tecla presionada en espera?
	; zf = 0 => Hay tecla esperando 
	; zf = 1 => No hay tecla en espera 
	; como el ReadKey de pascal: NO UTILIZADA


	HasKey:

	push ax			;

	mov ah, 0x01		; funcion 1
	int 0x16		; interrupcion bios

	pop ax			;

	ret			; return

;======================================================================

	; funcion ClearIn
	; Borrar Buffer del Teclado
	; NO UTILIZADA, me hiba a servir para limpiar posibles
	; pulsaciones dobles en el menu, pero no se dio el 
	; problema al probar con la funcion GETCH
	
	ClearIn
	
	ClearInL1:
		
	call HasKey		;	
	jz ClearInL2		;	
	call GetCh		;
	jmp ClearInL1		;	
	
	ClearInL2:		;
	
	ret			;
		

;======================================================================

	; funcion PutCh
	; imprimir el caracter ascii en al, en pantalla
	; Parametro al el caracter a imprimir
	
	PutCh:

	mov ah,	0x0E		;
	int 0x10		;

	ret			;

;======================================================================

	; funcion NewLine
	; nueva linea
	; imprimir enter en pantalla

	NewLine:

	mov dx, CRLF		;
	call Write		;
	ret			;


;======================================================================

	; funcion GetCh
	; ascii tecla presionada
	; Salida en al codigo ascii sin eco, via BIOS

	GetCh:
	
	xor ah,ah		;
	int 0x16		;	
	ret			;
	
;======================================================================
	
	;==============================|
	; DATA 			       |
	;==============================|


	SEGMENT data  ; Segment containing initialized data

	Cero128Bits DW  0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	DosA31	DW  	0x0000,0x8000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	OpA    	DW 	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	OpB	DW	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	prd 	DW	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	tmp     DW	0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

  	Msg1   DB "(1)   SUMAR       -> RES = A + B $"
	Msg2   DB "(2)   RESTAR      -> RES = A - B $"
	Msg3   DB "(3)   MULTIPLICAR -> RES = A * B $"
	Msg4   DB "(4)   DIVIDIR     -> RES = A / B $"
	Msg9   DB "(ESC) SALIR $"
	
	Msg5   DB "Presione el numero de opcion { 1 | 2 | 3 | 4 } ? $"

	Msg6   DB "Ingrese el operador A: $"
	Msg7   DB "Ingrese el operador B: $"

	Msg8   DB "RESULTADO = $"

	Msg10   DB "Operacion Seleccionada -> SUMA $" 
	Msg11   DB "Operacion Seleccionada -> RESTA $" 
	Msg12   DB "Operacion Seleccionada -> MULTIPLICACION $" 
	Msg13   DB "Operacion Seleccionada -> DIVISION $" 
	
	Msg14	DB "#### Error Imposible Dividir por 0 ####$"

	Buff   DB "000000000000000000000000000000$"

	Res    DB "000000000000000000000$"	

	OperA  DB "0000000000000000000000000$"

	CRLF   DB   0DH,0AH,'$'

	strCero DB '0'


	;==============================|
	; STACK			       |
	;==============================|

	; GENERADO POR MI IDE, setup del stack y tamaño reservado


        SEGMENT stack stack 	; This means a segment of *type* "stack"
                            	; that is also *named* "stack"! Some
                            	; linkers demand that a stack segment
                            	; have the explicit type "stack"
	resb 1024      		; Reserve 64 bytes for the program stack
    	stacktop:          	; It's significant that this label points to
                       		; the *last* of the reserved 64 bytes, and
                       		;  not the first!
