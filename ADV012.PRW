#INCLUDE "PROTHEUS.CH"

//------------------------------------------------------------------------------
/*{Protheus.doc} ADV012
Rotina para validação de gatilhos do campo ZZD_TECNIC
Criar gatilho pelo configurador

@author 	Rogerio Onishi Candisani
@version 	P12
@since   	
*/
//------------------------------------------------------------------------------
User Function ADV012()

Local cTecnico	:= ""
Local cStatus	:= ""
Local lRet 		:= .T.

cStatus := M->ZZD_STATUS
// nos casos em que cStatus for diferente de branco ou 1 - continua o mesmo Status
If ! Empty(ZZD_TECNIC)
	//verificar cStatus
	//se estiver em branco ou 1
	If Empty(cStatus) .OR. cStatus == "1"   
		cStatus := "2"
	Endif
Endif

Return cStatus