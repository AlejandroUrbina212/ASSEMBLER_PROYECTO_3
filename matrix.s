/*Prueba para la impresionde matriz*/
/*Pruab pa*ra verificar si se pueden hacer matrices*/


/*
---------------------------------------------
Universidad Del Valle de Guatemala
Luis Urbina -- 18473
---------------------------------------------
*/
.text
.align 2
.global main
.type main, %function
main:

	
	@inicio del programa
	stmfd sp!, {lr} 

@@ INICIA SOLICITUD DE COLOCAR BARCO A JUGADOR 1
	@@REPETIR ESTO HASTA QUE SELECCIONE QUE ESTA DE ACUERDO CON LAS POSICIONES
	ldr r0, =posicionarJug1 @Mostrar al jugador que posicione sus barcos
	bl puts
	ldr r2, =coordenadas @se cargan las coordenadas
       	mov r3, #3 @numero de veces que se repite guardarCoordenadas
	bl guardarCoordenadas @guardarCoordenadas (0,0, =coordenadas, 3)
	@@HASTA ACA SE REPITE 

	@@Se colocan los barcos del jugador 1
	ldr r1, =arreglo @Matriz donde se colocaran los barcos
	ldr r2, =coordenadas @arreglo donde estan las posiciones
       	mov r3, #3 @numero de veces a repetir el ciclo
        bl colocarBarco @colocarBarco (0, =arreglo, =coordenadas, 3)
	
	@@ Mostrar barco jugador 1
	ldr r0, =matrizJug1String
	bl puts
	ldr r2, =arreglo
	bl imprimirMatriz

@@ INICIA SOLICITUD DE COLOCAR BARCO A JUGADOR 2
	@@REPETIR ESTO HASTA QUE SELECCIONE QUE ESTA DE ACUERDO CON LAS POSICIONES
	ldr r0, =posicionarJug2 @Mostrar al jugador que posicione sus barcos
	bl puts
	ldr r2, =coordenadas @se cargan las coordenadas
       	mov r3, #3 @numero de veces que se repite guardarCoordenadas
	bl guardarCoordenadas @guardarCoordenadas (0,0, =coordenadas, 3)
	@@HASTA ACA SE REPITE

	@@Se colocan los barcos del jugador 2
	ldr r1, =arreglo_2 @Matriz donde se colocaran los barcos
	ldr r2, =coordenadas @arreglo donde estan las posiciones
       	mov r3, #3 @numero de veces a repetir el ciclo
        bl colocarBarco @colocarBarco (0, =arreglo_2, =coordenadas, 3)
	
	@@ Mostrar barco jugador 2
	ldr r0, =matrizJug2String
	bl puts
	ldr r2, =arreglo_2
	bl imprimirMatriz
	
@Aca va un ciclo que se acaba cuando cualquiera gana
	ldr r0, =turnoJug1
	bl puts
	/*SolicitarDisparos del jugador 1 */
	ldr r1, =arreglo_shots
	ldr r2, =arreglo_2
	bl solicitarDisparos
	
	/*SolicitarDisparos del jugador 1 */
	ldr r1, =arreglo_shots
	ldr r2, =arreglo_2
	bl solicitarDisparos
	
	/*SolicitarDisparos del jugador 1 */
	ldr r1, =arreglo_shots
	ldr r2, =arreglo_2
	bl solicitarDisparos
	
	/*Mostrar Aciertos del jugador 1 */

	ldr r0, =aciertos1
	bl puts
	ldr r2, =arreglo_shots
	bl imprimirMatriz
	
	ldr r0, =turnoJug2
	bl puts
	/*SolicitarDisparos del jugador 2 */
	ldr r1, =arreglo_shots2
	ldr r2, =arreglo
	bl solicitarDisparos

	/*SolicitarDisparos del jugador 2 */
	ldr r1, =arreglo_shots2
	ldr r2, =arreglo
	bl solicitarDisparos
	
	/*SolicitarDisparos del jugador 2 */
	ldr r1, =arreglo_shots2
	ldr r2, =arreglo
	bl solicitarDisparos
	
	/*Mostrar aciertos del jugador 2 */
	ldr r0, =aciertos2
	bl puts
	ldr r2, =arreglo_shots2
	bl imprimirMatriz

	/*---------------------Fin Programa------------------------*/

	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr
	
.data
.align 2

resultado: .word 0
comand: .word 0
okSeleccion: .word 0
matrizJug1String: .asciz "BARCOS JUGADOR 1"
matrizJug2String: .asciz "BARCOS JUGADOR 2"
posicionarJug1: .asciz "Posicione sus barcos Jugador 1"
posicionarJug2: .asciz "Posicione sus barcos Jugador 2"
turnoJug1: .asciz "Es el turno del jugador 1"
turnoJug2: .asciz "Es el turno del jugador 2"
aciertos1: .asciz "ACIERTOS JUGADOR 1"
aciertos2: .asciz "ACIERTOS JUGADOR 2"

co0: .asciz " ","1","2","3","4","5"
co1: .asciz "A","_","_","_","_","_"
co2: .asciz "B","_","_","_","_","_"
co3: .asciz "C","_","_","_","_","_"
co4: .asciz "D","_","_","_","_","_"
co5: .asciz "E","_","_","_","_","_"
arreglo: .word co0,co1,co2,co3,co4,co5

co0_2: .asciz " ","1","2","3","4","5"
co1_2: .asciz "A","_","_","_","_","_"
co2_2: .asciz "B","_","_","_","_","_"
co3_2: .asciz "C","_","_","_","_","_"
co4_2: .asciz "D","_","_","_","_","_"
co5_2: .asciz "E","_","_","_","_","_"
arreglo_2: .word co0_2,co1_2,co2_2,co3_2,co4_2,co5_2

co0_shots: .asciz " ","1","2","3","4","5"
co1_shots: .asciz "A","_","_","_","_","_"
co2_shots: .asciz "B","_","_","_","_","_"
co3_shots: .asciz "C","_","_","_","_","_"
co4_shots: .asciz "D","_","_","_","_","_"
co5_shots: .asciz "E","_","_","_","_","_"
arreglo_shots: .word co0_shots,co1_shots,co2_shots,co3_shots,co4_shots,co5_shots

co0_shots2: .asciz " ","1","2","3","4","5"
co1_shots2: .asciz "A","_","_","_","_","_"
co2_shots2: .asciz "B","_","_","_","_","_"
co3_shots2: .asciz "C","_","_","_","_","_"
co4_shots2: .asciz "D","_","_","_","_","_"
co5_shots2: .asciz "E","_","_","_","_","_"
arreglo_shots2: .word co0_shots2,co1_shots2,co2_shots2,co3_shots2,co4_shots2,co5_shots2

coordenadas: .word 0,0,0,0,0,0

@formatos para impresion
entrada_okSeleccion: .asciz "Esta de acuerdo con su posicion del barco? (afirmativo) ingrese 1, (negativo) ingrese 0"
formato_decimal: .asciz "%d"
formato_char: .asciz "%c  "
formato_enter: .asciz "\n"