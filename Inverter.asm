.data
	Pergunta: .asciiz "Digite uma palavra:\n"
	Result: .asciiz "Sua palavara invertida é: "
	Str: .space 25
	StrInver: .space 25
.text
	li $v0, 4 # Vai printar para digitar a palavra
	la $a0, Pergunta					#$t0 estara apontando para a string digitada
	syscall							#$t1 estara apontando para a string que sera invertida
								#$t2 contador de caracteres existentes na palavra
	li $v0, 8 # Vai ler a palavra
	la $a0, Str
	la $a1, 25
	syscall
	
	la $t0, Str #Vai carregar a palavra
	la $t1, StrInver #Vai carregar o vetor aonde será colocada a palavra invertida
	li $t2, 0 #Inicializa o contador em zero
	
	loop:
		lb $t3, 0($t0) # Carrega o caracter de acordo com a incrementação
		beq $t3, $zero inverter # Quando a palavra chegar ao fim o seu valor sera 0, ou seja vai estar na hora de inverter
		addi $t2, $t2, 1 # Contador de caracteres na palavra sendo incrementado
		addi $t0, $t0, 1 #Avançando no vetor para a proxima casa em byte
		j loop
		
	inverter:
		subi $t2, $t2, 1 # A incremetação ira registrar o /0 também, então tiramos o /0 já que é um valor nulo e não é parte da palavra
		la $t0, Str	 # Inicializa a palavra ao seu ponto de origem	
		
	inverterLoop:
		blt $t2, $zero, fim #Se o contador chegar a um numero negativo ele vai imprimir o resultado da inversão
		add $t3, $t0, $t2 #Pega o endereço de memória base + indice, fazendo com que $t3 pegue o endereço da direita pra esquerda da strig
		lb $t4, 0($t3) #$t4 aponta para esse endereço de memória($t3)
		sb $t4, 0($t1) #O endereço de memória de $t3, apontado por $t4, será colocado em $t1
		addi $t1,$t1,1 #Avançamos uma casa de byte de StrInver
		subi $t2,$t2, 1 #Diminuimos o contador até que o numero de caracteres seja diminuido até -1, ou seja percorreu todos os caracteres
		j inverterLoop
		
	fim:
		
		li $v0, 4 # Imprime Result para apresentar o resultado
		la $a0, Result
		syscall
		
		li $v0, 4 # Resultado, imprime a string já invertida
		la $a0, StrInver
		syscall
		
		li $v0, 10 # Finaliza o programa
		syscall	
