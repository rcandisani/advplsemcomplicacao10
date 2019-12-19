#include "protheus.ch"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

//------------------------------------------------------------------------------
/*{Protheus.doc} ADV007
Como adicionar itens numa matriz - AADD.

@author 	Rogerio Onishi Candisani
@version 	
@since   	
*/
//------------------------------------------------------------------------------
User Function ADV007()

Local aMatriz:= {} // declara uma matriz vazia

//Comando AADD - adiciona um item numa matriz
//Sintaxe
//AAdd( < aDest >, < xExpr > )

AADD(aMatriz ,"A" )
AADD(aMatriz ,"D" )
AADD(aMatriz ,"V" )
AADD(aMatriz ,"P" )
AADD(aMatriz ,"L" )

Return