#include "protheus.ch"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

//------------------------------------------------------------------------------
/*{Protheus.doc} ADV008
Como clonar uma matriz - aClone

@author 	Rogerio Onishi Candisani
@version 	
@since   	
*/
//------------------------------------------------------------------------------
User Function ADV008()

Local aMatriz:= {} // declara uma matriz vazia
Local aMatriz1:={} 
Local aMatriz2:={}

//Comando AADD - adiciona um item numa matriz
//Sintaxe
//AAdd( < aDest >, < xExpr > )

AADD(aMatriz ,"A" )
AADD(aMatriz ,"D" )
AADD(aMatriz ,"V" )
AADD(aMatriz ,"P" )
AADD(aMatriz ,"L" )

aMatriz1:= aClone(aMatriz) // comando para aClone

Return