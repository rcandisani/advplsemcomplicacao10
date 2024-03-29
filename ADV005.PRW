#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

//------------------------------------------------------------------------------
/*{Protheus.doc} Vetores e Matrizes
Conceito de vetores e matrizes

@author 	Rogerio Onishi Candisani
@version 	
@since   	
*/
//------------------------------------------------------------------------------
User Function ADV005()
/*
O que s�o Vetores e Matrizes (arrays)


Vetores e Matrizes s�o estruturas de dados muito simples que podem nos ajudar muito quando temos muitas vari�veis do mesmo tipo em um algoritmo. 

Imagine o seguinte problema: Voc� precisa criar um algoritmo que l� o nome e as 4 notas de 50 alunos, 

calcular a m�dia de cada aluno e informar quais foram aprovados e quais foram reprovados. 

Conseguiu imaginar quantas vari�veis voc� vai precisar? Muitas n�? 

Vamos fazer uma conta r�pida: 50 vari�veis para armazenar os nomes dos alunos, 

(4 * 50 = ) 200 vari�veis para armazenar as 4 notas de cada aluno e por fim, 

50 vari�veis para armazenar as m�dias de cada aluno. 

300 vari�veis no total, sem contar a quantidade de linhas de c�digo que voc� vai precisar para ler todos os dados do usu�rio,

calcular as m�dias e apresentar os resultados. 

Mas eu tenho uma boa not�cia pra voc�. 

N�s n�o precisamos criar 300 vari�veis! Podemos utilizar Vetores e Matrizes (tamb�m conhecidos como ARRAYs)!



O QUE S�O VETORES E MATRIZES?


Vetor (array uni-dimensional) � uma vari�vel que armazena v�rias vari�veis do mesmo tipo. 

No problema apresentado anteriormente, n�s podemos utilizar um vetor de 50 posi��es para armazenar os nomes dos 50 alunos.

Matriz (array multi-dimensional) � um vetor de vetores. 

No nosso problema, imagine uma matriz para armazenar as 4 notas de cada um dos 50 alunos. 

Ou seja, um vetor de 50 posi��es, e em cada posi��o do vetor, h� outro vetor com 4 posi��es. Isso � uma matriz.

Cada item do vetor (ou matriz) � acessado por um n�mero chamado de �ndice.

Vamos representar os vetores e matrizes graficamente para facilitar o entendimento do conceito.

Podemos ver na imagem acima que cada posi��o do vetor � identificado por um n�mero (chamado de �ndice), no caso da matriz s�o dois n�meros (um na vertical e um na horizontal).

CONCLUS�O

Como voc� pode perceber nesse artigo, Vetores e Matrizes s�o, na verdade, a mesma coisa: array 

a diferen�a � que o vetor � um array de apenas 1 dimens�o 

e a matriz � um array de 2 (ou mais) dimens�es.

Array � uma das estruturas de dados mais simples que existe e uma das mais utilizadas tamb�m. 

Acho que todas as linguagens de programa��o t�m arrays, pelo menos ainda n�o conhe�o uma linguagem que n�o tem. 

Por�m, os �ndices podem mudar dependendo da linguagem, algumas come�am os �ndices do array com 1 e outras com 0, 

essa � a grande diferen�a que geralmente encontramos entre linguagens. 

No caso das linguagens que come�am os arrays com o �ndice 0, o �ltimo elemento do array recebe o �ndice (<tamanho do array> � 1).

*/


Declara��o de variaveis de vetores
aVetor:={} // sempre representada por aNomeDoVetor - como boas pr�ticas de programa��o

//Alguns Vetores conhecidos no protheus

//Quando se quer saber a posi��o de um item do pedido de venda 
aCols:={} // Itens do pedido de venda por exemplo

aHeader:= {} // cabe�aho da tabela em quest�o 

aRotina:={} // matriz dos programas dentro do menu padr�o








Return


