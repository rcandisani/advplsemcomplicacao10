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
O que são Vetores e Matrizes (arrays)


Vetores e Matrizes são estruturas de dados muito simples que podem nos ajudar muito quando temos muitas variáveis do mesmo tipo em um algoritmo. 

Imagine o seguinte problema: Você precisa criar um algoritmo que lê o nome e as 4 notas de 50 alunos, 

calcular a média de cada aluno e informar quais foram aprovados e quais foram reprovados. 

Conseguiu imaginar quantas variáveis você vai precisar? Muitas né? 

Vamos fazer uma conta rápida: 50 variáveis para armazenar os nomes dos alunos, 

(4 * 50 = ) 200 variáveis para armazenar as 4 notas de cada aluno e por fim, 

50 variáveis para armazenar as médias de cada aluno. 

300 variáveis no total, sem contar a quantidade de linhas de código que você vai precisar para ler todos os dados do usuário,

calcular as médias e apresentar os resultados. 

Mas eu tenho uma boa notícia pra você. 

Nós não precisamos criar 300 variáveis! Podemos utilizar Vetores e Matrizes (também conhecidos como ARRAYs)!



O QUE SÃO VETORES E MATRIZES?


Vetor (array uni-dimensional) é uma variável que armazena várias variáveis do mesmo tipo. 

No problema apresentado anteriormente, nós podemos utilizar um vetor de 50 posições para armazenar os nomes dos 50 alunos.

Matriz (array multi-dimensional) é um vetor de vetores. 

No nosso problema, imagine uma matriz para armazenar as 4 notas de cada um dos 50 alunos. 

Ou seja, um vetor de 50 posições, e em cada posição do vetor, há outro vetor com 4 posições. Isso é uma matriz.

Cada item do vetor (ou matriz) é acessado por um número chamado de índice.

Vamos representar os vetores e matrizes graficamente para facilitar o entendimento do conceito.

Podemos ver na imagem acima que cada posição do vetor é identificado por um número (chamado de índice), no caso da matriz são dois números (um na vertical e um na horizontal).

CONCLUSÃO

Como você pode perceber nesse artigo, Vetores e Matrizes são, na verdade, a mesma coisa: array 

a diferença é que o vetor é um array de apenas 1 dimensão 

e a matriz é um array de 2 (ou mais) dimensões.

Array é uma das estruturas de dados mais simples que existe e uma das mais utilizadas também. 

Acho que todas as linguagens de programação têm arrays, pelo menos ainda não conheço uma linguagem que não tem. 

Porém, os índices podem mudar dependendo da linguagem, algumas começam os índices do array com 1 e outras com 0, 

essa é a grande diferença que geralmente encontramos entre linguagens. 

No caso das linguagens que começam os arrays com o índice 0, o último elemento do array recebe o índice (<tamanho do array> – 1).

*/


Declaração de variaveis de vetores
aVetor:={} // sempre representada por aNomeDoVetor - como boas práticas de programação

//Alguns Vetores conhecidos no protheus

//Quando se quer saber a posição de um item do pedido de venda 
aCols:={} // Itens do pedido de venda por exemplo

aHeader:= {} // cabeçaho da tabela em questão 

aRotina:={} // matriz dos programas dentro do menu padrão








Return


