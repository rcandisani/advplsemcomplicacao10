#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

//------------------------------------------------------------------------------
/*{Protheus.doc} ADV006()
Exemplo do comando array

@author 	Rogerio Onishi Candisani
@version 	
@since   	
*/
//------------------------------------------------------------------------------
User Function ADV006()

Local aExemplo := Nil
Local cMensagem := ""

//+----------------------------------------------------------------------------+
//|Exemplifica o uso da função Array                                           |
//+----------------------------------------------------------------------------+
aExemplo := Array(7, 7)
aExemplo[1] := {"E", "A", "S", "U", "I", "M", "F"}
aExemplo[2] := {"Ç", "X", "D", "F", "B", "N", "X"}
aExemplo[3] := {"D", "P", "E", "G", "G", "H", "B"}
aExemplo[4] := {"N", "A", "K", "M", "R", "E", "H"}
aExemplo[5] := {"R", "H", "Z", "Y", "P", "T", "Y"}
aExemplo[6] := {"K", "X", "A", "K", "J", "L", "U"}
aExemplo[7] := {"M", "S", "C", "V", "P", "O", "O"}
cMensagem += cValToChar(aExemplo[1][1])
cMensagem += cValToChar(aExemplo[2][2])
cMensagem += cValToChar(aExemplo[3][3])
cMensagem += cValToChar(aExemplo[4][4])
cMensagem += cValToChar(aExemplo[5][5])
cMensagem += cValToChar(aExemplo[6][6])
cMensagem += cValToChar(aExemplo[7][7])

//+----------------------------------------------------------------------------+
//|Apresenta uma mensagem com os resultados obtidos                            |
//+----------------------------------------------------------------------------+
  MsgInfo(cMensagem, "Exemplo do Array")
Return

Return


