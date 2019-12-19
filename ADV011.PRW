#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

//------------------------------------------------------------------------------
/*{Protheus.doc} ADV011
Rotina para montagem da tela de chamados de mbrowse

@author 	Rogerio Onishi Candisani
@version 	P12
@since   	
*/
//------------------------------------------------------------------------------
User Function ADV011()

Private cCadastro := "Chamados"
Private aRotina   := {{"Pesquisar","AXPESQUI",0,1},;
						{"Visualizar","AXVISUAL",0,2},;
						{"Incluir","U_ADV11",0,3},;
						{"Alterar","AXALTERA",0,4},;
						{"Excluir","AXDELETA",0,5},;
						{"Legenda","U_ADV11LEG()",0,6}}


Private aCores	:= {{ "ZZD->ZZD_STATUS = '1' .OR. Empty(ZZD->ZZD_STATUS) ","BR_VERDE"},;
						{ "ZZD->ZZD_STATUS = '2' ","BR_AZUL"},;
						{ "ZZD->ZZD_STATUS = '3' ","BR_AMARELO"},;
						{ "ZZD->ZZD_STATUS = '4' ","BR_PRETO"},;
						{ "ZZD->ZZD_STATUS = '5' ","BR_VERMELHO"}}
										 												
mBrowse(6,1,22,75,"ZZD",,,,,,aCores)

Return


//------------------------------------------------------------------------------
/*{Protheus.doc} ADV11LEG
Legenda dos chamados

@author 	Rogerio Onishi Candisani
@version 	P12
@since   	
*/
//------------------------------------------------------------------------------
Function U_ADV11LEG()

local aLegenda :={{"BR_VERDE","Chamado em Aberto"},;     
				   {"BR_AZUL","Chamado em Atendimento"},;
				   {"BR_AMARELO","Chamado Aguardando Usuario"},; 
				   {"BR_PRETO","Chamado Encerrado"},;
				   {"BR_VERMELHO","Chamado em Atraso"}}
				   
BrwLegenda(cCadastro,"Legenda",aLegenda)

Return()

//------------------------------------------------------------------------------
/*{Protheus.doc} ADVINC
Validação de Inclusão

@author 	Rogerio Onishi Candisani
@version 	P12
@since   	
*/
//------------------------------------------------------------------------------
Function U_ADV11(cAlias,nReg,nOpc)

Local lok			:= .t.
Local nOpca 		:= 0
Local _aCposNZZD    := {} 
Local aCposZZD      := {}
Local cCodigo
Local cModulo 
Local cObs    
Local Dtemis  
Local cUse    
Local cPrior

//carrega os campos do dicionario de dados 
sx3->(dbsetorder(1))
If sx3->(dbseek("ZZD"))
	while sx3->(!eof()) .and. sx3->x3_arquivo=="ZZD" 
		if  X3USO(sx3->x3_usado).and. cNivel >= sx3->x3_nivel .and.;
			ascan(_aCposNZZD, {|x| x==alltrim(sx3->x3_campo)})=0  
		   aadd(aCposZZD,sx3->x3_campo)
        endif
        sx3->(dbskip())
    enddo
endif 

if lok  
	       //AxInclui( <cAlias>, <nReg>, <nOpc>, <aAcho>, <cFunc>, <aCpos>, <cTudoOk>, <lF3>, <cTransact>, <aButtons>, <aParam>, <aAuto>, <lVirtual>, <lMaximized>) 
	nOpca := Axinclui(   cAlias,   nReg,   nOpc,aCposZZD,        ,aCposZZD, "U_VALINC1()" )
endif


Return()

//------------------------------------------------------------------------------
/*{Protheus.doc} VALINC1
Validação de Inclusão

@author 	Rogerio Onishi Candisani
@version 	P12
@since   	
*/
//------------------------------------------------------------------------------
User function VALINC1()

Local lValida := .T.

If empty(M->ZZD_TIPO)
	MsgStop("Informar tipo de atendimento","STOP")
	lValida:= .F.
Endif 

Return lValida


