#include "protheus.ch"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

//------------------------------------------------------------------------------
/*{Protheus.doc} ADV010
Como ordenar uma matriz - aSort

@author 	Rogerio Onishi Candisani
@version 	
@since   	
*/
//------------------------------------------------------------------------------
User Function ADV010()

Local aMatriz:= {} // declara uma matriz vazia
Local aLetras:={}  // matriz para gravar a quantidade por letra 
Local x:= 0

//Comando AADD - adiciona um item numa matriz
//Sintaxe
//AAdd( < aDest >, < xExpr > )

AADD(aMatriz ,"A" )
AADD(aMatriz ,"D" )
AADD(aMatriz ,"V" )
AADD(aMatriz ,"P" )
AADD(aMatriz ,"L" )
AADD(aMatriz ,"S" )
AADD(aMatriz ,"E" )
AADD(aMatriz ,"M" )
AADD(aMatriz ,"C" )
AADD(aMatriz ,"O" )
AADD(aMatriz ,"M" )
AADD(aMatriz ,"P" )
AADD(aMatriz ,"L" )
AADD(aMatriz ,"I" )
AADD(aMatriz ,"C" )
AADD(aMatriz ,"A" )
AADD(aMatriz ,"C" )
AADD(aMatriz ,"A" )
AADD(aMatriz ,"O" )

//contar a quantidade por letras
For x:= 1 to len(aMatriz)
	//verifica se letra j� existe e soma a quantidade
	If aScan( aLetras, { |z| z[2] == aMatriz[x] } ) == 0
		AADD(aLetras,{1,aMatriz[x]}) 
	Else
		nPos:= aScan( aLetras, { |z| z[2] == aMatriz[x] } )
		aLetras[nPos][1]+= 1    
	Endif
 
Next x

//ordenar a matriz Letras pela maior quantidade de letra repetida 

//aSort( aLetras)
aSort(aLetras,,,{|x,y| x[2] < y[2]})

Return