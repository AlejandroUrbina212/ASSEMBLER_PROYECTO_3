.data
.align 2

row_to_mark:   .word  0
col_to_mark:  .word  0
entrada_char:
    .asciz "%c"
entrada_decimal:
    .asciz "%d"
formato_fila:
    .asciz "Ingrese la fila"
formato_col:
    .asciz "Ingrese la columna"
formato_char: .asciz "%c  "
formato_enter: .asciz "\n"
disparo_acertado: .asciz "Has acertado un disparo!\n"
disparo_fallado: .asciz "Has Fallado!\n"
var: .asciz "b"
.text
.align 2
@ ****************************************************
@Subrutina que solicita todas las filas y las columna en la 
@que el usuario desea colocar un marcador del barco
@Parametros:
@   r0: 
@   r1: 
@   r2: direccion de la matriz
@   r3: numero de control para saber cuantos veces pedir marcadores
@Retorno
@   r0: 0 si el usuario ha aceptado su posicion de barcos
@ ****************************************************
.global guardarCoordenadas
guardarCoordenadas:
    push {r4-r12, lr} @vamos a usar mas registros
    mov r9, r2  @carga el arreglo de las coordenadas
    mov r10, r3 @carga el numero de veces para pedir marcadores
    mov r7, #-4 @empieza en -4 para ir recorriendo el array de coordenadas
    mov r8, #4
    mov r5, #2
cicloGuardarCoordenada:
    ldr r0, =formato_fila
    bl puts
    ldr r0, =entrada_decimal
    ldr r1, =row_to_mark
    bl scanf
    ldr r1, =row_to_mark
    add r7, r7, #4 @accesar al siguiente indice de array de coordenadas
    ldr r6, [r1] @carga el numero de fila ingresado
    mul r6, r6, r8 @multiplicar por 4, ya que las filas se acceden de 4 en 4 (en las matrices)
    str r6, [r9, r7] @guardar el numero de fila ya multiplicado
    ldr r0, =formato_col
    bl puts
    ldr r0, =entrada_decimal
    ldr r1, =col_to_mark
    bl scanf
    ldr r1, =col_to_mark
    ldr r6, [r1] @carga el numero de columna
    add r7, r7, #4 @accesar al siguiente indice de array de coordenadas
    mul r6, r6, r5 @multiplicar por 2, ya que las columnas se acceden de 2 en 2 (en las matrices)
    str r6, [r9, r7] @guardar el numero de columna ya multiplicado
    subs r10, #1 @resta 1 al contador del ciclo
    bne cicloGuardarCoordenada
    pop {r4-r12, pc}
@----------------------------------------------


@ ****************************************************
@Subrutina que solicita la fila y la columna en la 
@que el usuario desea colocar un marcador del barco
@Parametros:
@   r0: 
@   r1: arreglo de coordenadas
@   r2: direccion de la matriz dle jugador en turno
@   r3: numero de control para saber cuantos veces pedir marcadores
@Retorno
@   r0: 0 si el usuario ha aceptado su posicion de barcos
@ ****************************************************
.global colocarBarco
colocarBarco:
    push {r4-r12, lr} @vamos a usar mas registros
    mov r8, r2 @carga el arreglo de coordenadas
    mov r11, r1 @carga la matriz del jugador
    mov r10, r3 @carga el numero de veces para pedir marcadores
    mov r9, #-4
cicloSolicitar:
    add r9, r9, #4 @cargar fila de array de coordenadas
    ldr r6, [r8, r9] @carga el numero de fila
    ldr r5,[r11, r6] @mueve el indice a la fila seleccionada (0,4,8,12,16)
    mov r4,#'+'@caracter a ingresar
    add r9, r9, #4 @cargar columna de array de coordenadas
    ldr r6, [r8, r9] @carga el numero de columna, (0,2,4,6,8,10)
    strb r4,[r5,r6] @guarda el caracter (como bit) en la casilla seleccionada
    subs r10, #1
    bne cicloSolicitar
    pop {r4-r12, pc}
@----------------------------------------------
@ ****************************************************
@Subrutina que recibe la variable del arreglo
@e imprime la matriz correspondiente
@Parametros:
@   r0: 
@   r1: 
@   r2: direccion de la matriz
@Retorno
@ Nada
@ ****************************************************
.global imprimirMatriz
imprimirMatriz:
	push {r4-r12, lr} @vamos a usar mas registros
	mov r6, r2 @carga el arreglo
	mov r8, #0
mostrarMatriz:
	ldr r0,=formato_char
        ldr r2,[r6,r8]
        ldr r1,[r2,r5]
        bl printf
        add r5,r5,#1
        cmp r5,#12
        blne mostrarMatriz
        ldr r0,=formato_enter
        bl puts
        mov r5,#0
        add r8,r8,#4
        cmp r8,#24
        blne mostrarMatriz
    	pop {r4-r12, pc}
@----------------------------------------------
@ ****************************************************
@Subrutina que solicita la fila y la columna en la 
@que el usuario desea colocar un disparo en el otro tablero
@Parametros:
@   r0: 
@   r1:	direccion de la matriz de aciertos del jugador
@   r2: direccion de la matriz del oponente
@   
@Retorno
@   r0: 0 si el usuario ha aceptado su posicion de barcos
@ ****************************************************
.global solicitarDisparos
solicitarDisparos:
    push {r4-r12, lr} @vamos a usar mas registros
    mov r8, r1 @carga el arreglo de aciertos del usuario
    mov r1, #0
    mov r7, #0
    mov r11, r2 @carga el arreglo del oponente
    mov r10, #0 @carga el numero de veces para pedir marcadores
    @Solicitar fila y columna para disparar
    ldr r0, =formato_fila
    bl puts
    ldr r0, =entrada_decimal
    ldr r1, =row_to_mark
    bl scanf
    ldr r1, =row_to_mark
    ldr r6, [r1] @carga el numero de fila
    mov r9, #4 @cargar 4 para poder multiplicar por el numero de fila que seleccione el usuario
    mul r6, r6, r9 @multiplica el valor, y le cae encima para movese a esa fila
    ldr r5,[r11, r6] @mueve el indice a la fila seleccionada (0,4,8,12,16)
    ldr r0, =formato_col
    bl puts
    ldr r0, =entrada_decimal
    ldr r1, =col_to_mark
    bl scanf
    ldr r1, =col_to_mark
    ldr r10, [r1] @carga el numero de columna, (0,2,4,6,8,10)
    mov r9, #2 @cargar 4 para poder multiplicar por el numero de fila que seleccione el usuario
    mul r10, r10, r9 @multiplica el valor, y le cae encima para movese a esa fila
    ldrb r7,[r5,r10]
    cmp r7, #'_' 
    beq disparoFallado
    cmp r7, #'+'
    beq disparoAcertado
    
    pop {r4-r12, pc}

@----------------------------------------------------
@ ****************************************************
@Subrutina que muestra en pantalla si el usuario acerto un disparo
@Retorno
@ Nada
@ ****************************************************
.global disparoAcertado
disparoAcertado:
	push {r4-r12, lr} @vamos a usar mas registros	
	ldr r0, =disparo_acertado
	bl printf
	ldr r5,[r8, r6] @mueve el indice a la fila seleccionada (0,4,8,12,16)
    	mov r4, #'x'
	strb r4,[r5,r10] @guarda el bit en la casilla seleccionada
	pop {r4-r12, pc}
.global disparoFallado
disparoFallado:
	push {r4-r12, lr} @vamos a usar mas registros	
	ldr r0, =disparo_fallado
	bl printf
	ldr r5,[r8, r6] @mueve el indice a la fila seleccionada (0,4,8,12,16)
    	mov r4, #'o'
	strb r4,[r5,r10] @guarda el bit en la casilla seleccionada
	pop {r4-r12, pc}