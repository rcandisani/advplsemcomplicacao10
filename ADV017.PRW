#INCLUDE "VKEY.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"                                                                                    
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH" 
#INCLUDE "FILEIO.CH"

#Command @ <nRow>, <nCol> BMPBUTTON TYPE <nType> ACTION <cAction> [OBJECT <oBmt>] [<lEnable:ENABLE>] => [ <oBmt> := ] SButton():New(<nRow>, <nCol>, <nType>, [{|| <cAction>}],,<lEnable>)

//------------------------------------------------------------------------------
/*{Protheus.doc} ADV017
Rotina para montagem da tela de atendimento do chamado Modelo 3 - MsDialog com folder

@author 	Rogerio Onishi Candisani
@version 	P12
@since   	
*/
//------------------------------------------------------------------------------
User Function ADV017()

Local pString:="ZZA",pCadastro:="Atendimentos por T้cnico"
Private cCadastro := "Consulta de "+pCadastro+" ("+pString+")"
Private cString   := pString
Private aRotina   := fMontaRot()  //Monta o aRotina
Private cDelFunc  := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock
Private aAreaSm0  := SM0->(GetArea())
oDlgFol := ""

dbSelectArea(cString)
dbSetOrder(1)
mBrowse(6,1,22,75,cString,,,,,,)

Return    

//-----------------------------------------------------------------------------

Static Function fMontaRot()  //Monta o aRotina
Local aRotina:={},aRotina1:={}

AAdd(aRotina,{"Pesquisar"   ,"AxPesqui"  ,0,1})
AAdd(aRotina,{"Visualizar"  ,"AxVisual"  ,0,2})
//AAdd(aRotina,{"Incluir"     ,"AxInclui"  ,0,3})
//AAdd(aRotina,{"Alterar"     ,"U_ZZAAlt"  ,0,6})
AAdd(aRotina,{"Atendimentos","U_ZZAATE()",0,2})

Return(aRotina)

//----------------------------------------------------------------------
// Atendimentos - consulta 
//----------------------------------------------------------------------
User Function ZZAATE() 

Local cTitJan:="Atendimentos"
Local nStyle:=GD_INSERT + GD_UPDATE + GD_DELETE
Local nPos,oDlg,oDlgSer,lRet:=.f.
Local aButtons

//
Private nOpc    
Private nOpcManu  //Usada para Visualizar
//

//
nStyle:=If(nOpcManu==2,0,nStyle)  //2=Visualizar
//

//Monta os bot๕es da barra de ferramentas
aButtons:={}
AAdd(aButtons,{"S4WB001N",{||fSalvar900()  },OemToAnsi("Salvar"         ),OemToAnsi("Salvar" )})

Private oArial10N1:=TFont():New("Arial",10,16,,.T.,,,,.T.,.F.)
Private oArial10N2:=TFont():New("Arial",10,16,,.T.,,,,.T.,.F.)
oFont1:=oArial10N1  //Say
oFont2:=oArial10N2  //Get

//
//ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
//บMaximizacao da area de trabalho                                          บ
//ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

Private aObjects  := {}
Private aInfo     := {}
Private aPosGet   := {}
Private aPosObj   := {}

aSizeAut 	 := MsAdvSize()

If oMainWnd:nClientWidth > 800
	AAdd( aObjects, {  100, 008, .T., .T. } )  //Enchoice
	AAdd( aObjects, {  100, 092, .T., .T. } )  //MsGetDados
Else
	AAdd( aObjects, {  100, 010, .T., .T. } )  //Enchoice
	AAdd( aObjects, {  100, 090, .T., .T. } )  //MsGetDados
EndIf

aInfo 	:= {aSizeAut[1],aSizeAut[2],aSizeAut[3],aSizeAut[4],3,3}
aPosObj := MsObjSize( aInfo, aObjects, .T. , .F. )
aPosGet := MsObjGetPos((aSizeAut[3]-aSizeAut[1]),315,{{004,024,240,270}} )

//ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
//บMontagem da tela que sera apresentada para usuario (lay-out)            บ
//ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
DEFINE MSDIALOG oDlg FROM aSizeAut[7],0           TO aSizeAut[6],aSizeAut[5] TITLE OemToAnsi(cTitJan) Of oMainWnd PIXEL

Private aHeader:={}
Private aCols:={}
Private oDlg,nFolder

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Criacao da Interface                                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

nFolderCh:=0

aPages :={}
aTitles:={}

AAdd(aTitles,"Chamados"  ) ; nFolderCh:=Len(aTitles) 

nLin1:=aPosObj[2,1]
nCol1:=aPosObj[2,2]
nLin2:=aPosObj[2,4]-aPosObj[2,2]  //Largura
nCol2:=aPosObj[2,3]-aPosObj[2,1]  //Altura

//       TFolder():New(<nRow>,<nCol>,<cPrompt>,<cDlgNameN>,<oWnd> ,<nOption>,<nClrFore>,<nClrBack>,<.lPixel.>,<.lDesign.>,<nWidth>,<nHeight>,<cMsg>)
oFolder:=TFolder():New(nLin1 ,nCol1 ,aTitles  ,aPages     ,oDlg   ,         ,          ,          ,.T.       ,.F.        ,nLin2   ,nCol2    ,      )

For nPos:=1 to Len(aTitles)
	oFolder:aDialogs[nPos]:oFont:=oDlg:oFont
Next

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Consistencia a cada mudanca de pasta do Objeto Folder                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oFolder:bSetOption:={|nIndo|U_ZZAMUDA(nIndo,oFolder:nOption,@oDlg,@oFolder)}

cCodTec :=ZZA->ZZA_COD
cNomeTec:=ZZA->ZZA_NOME

cAlias:="ZZA"
aSayZZA:={}
aGetZZA:={}

SX3->(dbSetOrder(1))
SX3->(dbSeek(cAlias))
While SX3->(!Eof() .and. X3_ARQUIVO==cAlias)
	If X3Uso(SX3->X3_USADO) .AND. cNivel >= SX3->X3_NIVEL
		AAdd(aSayZZA,SX3->X3_CAMPO)
		If SX3->X3_CONTEXT <> "V"
			M->&(SX3->X3_CAMPO) := (cAlias)->&(SX3->X3_CAMPO)
		Else
			M->&(SX3->X3_CAMPO) := CriaVar(SX3->X3_CAMPO)
		EndIf
	EndIf
	SX3->(dbSkip())
End

//Dados do Tecnico
nLin1:=aPosObj[1,1]
nCol1:=aPosObj[1,2]
nLin2:=aPosObj[1,3]
nCol2:=aPosObj[1,4]             

@ nLin1,nCol1 to nLin2,nCol2 Of oDlg PIXEL
@ nLin1+06,nCol1+005 Say OemToAnsi("Codigo:") Size 050,8 Of oDlg PIXEL COLOR CLR_BLUE FONT oFont1
@ nLin1+06,nCol1+050 Say oCodTec Var cCodTec Size 050,8 Of oDlg PIXEL COLOR CLR_BLUE FONT oFont2 //When fWhen(.f.)
@ nLin1+06,nCol1+120 Say OemToAnsi("Nome:") Size 050,8 Of oDlg PIXEL COLOR CLR_BLUE FONT oFont1
@ nLin1+06,nCol1+200 Say oNomTec Var cNomeTec Size 200,8 Of oDlg PIXEL COLOR CLR_BLUE FONT oFont2 //When fWhen(.f.)
 
//inicio do folder

If nFolderCh>0  //Dados Atendimento
	nLin1:=002
	nCol1:=003
	nLin2:=aPosObj[2,3]-55
	nCol2:=aPosObj[2,4]-07
	fFolderCh(nFolderCh,nLin1,nCol1,nLin2,nCol2)
EndIf
Activate MsDialog oDlg CENTERED On Init EnchoiceBar(oDlg,{||fSalvar(oDlg)},{||fSair(oDlg)},,aButtons)

Return

//-----------------------------------------------------------------------------
// Folder Chamado Atendimento
//-----------------------------------------------------------------------------
STATIC FUNCTION fFolderCh(nFolder,nLin1,nCol1,nLin2,nCol2)

Local aCamposNao := {}
Local aCamposSim := {}
Local nStyle:= GD_UPDATE //escolha o estilo da sua grid
//Local nStyle:=GD_INSERT + GD_UPDATE + GD_DELETE
Local cProduto:=""
Local cFornece:=""

Local cAlias,cChave,cCondicao,nIndice,cFiltro

nStyle:=If(nOpcManu==2,0,nStyle)  //2=Visualizar

cAlias   :="ZZD"
cChave   :=xFILIAL(cAlias)+cCodTec
cCondicao:='ZZD_FILIAL+ZZD_TECNIC=="'+cChave+'"'
nIndice  :=1  
cFiltro  :=cCondicao
AAdd(aCamposSim,{"ZZD_DATA",""})
AAdd(aCamposSim,{"ZZD_TIPO",""})
AAdd(aCamposSim,{"ZZD_DESCR",""})
AAdd(aCamposSim,{"ZZD_DESTIP",""})

aHeader:=fHeader(aCamposSim)
aCols:=fCols(aHeader,cAlias,nIndice,cChave,cCondicao,cFiltro)

//                           nTop ,nLeft,nBottom,nRight,nStyle,cLinhaOk,cTudoOk,cIniCpos     ,aAlter,nFreeze,nMax,cFieldOk,cSuperDel,cDelOk,oWnd                     ,aHeader,aCols}
oDlgFol:=MsNewGetDados():New(nLin1,nCol1,nLin2  ,nCol2 ,nStyle,        ,       ,             ,      ,       ,110 ,        ,         ,.t.   ,oFolder:aDialogs[nFolder],aHeader,aCols)

Return

//-----------------------------------------------------------------------------
Static Function fHeader(aCamposSim)
Local nPos,aTabAux,aHeader:={}

dbSelectArea("SX3")
dbSetOrder(2)  //X3_CAMPO
For nPos:=1 to Len(aCamposSim)
	If SX3->(dbSeek(PadR(AllTrim(aCamposSim[nPos,1]),Len(X3_CAMPO))))
		aTabAux:={}
		AAdd(aTabAux,TRIM(x3Titulo()))
		AAdd(aTabAux,x3_campo        )
		AAdd(aTabAux,x3_picture      )
		AAdd(aTabAux,x3_tamanho      )
		AAdd(aTabAux,x3_decimal      )
		AAdd(aTabAux,x3_valid        )
		AAdd(aTabAux,x3_usado        )
		AAdd(aTabAux,x3_tipo         )
		AAdd(aTabAux,x3_f3           )
		AAdd(aTabAux,x3_context      )
		AAdd(aTabAux,x3_cbox         )
		AAdd(aTabAux,x3_relacao      )
 		AAdd(aTabAux,x3_when         )

		If !Empty(aCamposSim[nPos,2])
			AAdd(aTabAux,aCamposSim[nPos,2])
		Else
			AAdd(aTabAux,x3_visual       )
		EndIf
			AAdd(aTabAux,X3_VLDUSER      )
		
		AAdd(aTabAux,X3_PICTVAR      )
		AAdd(aTabAux,X3_OBRIGAT      )
		AAdd(aHeader,aTabAux         )
	EndIf
Next

dbSetOrder(1)  //X3_ARQUIVO+X3_ORDEM

Return(AClone(aHeader))
//-----------------------------------------------------------------------------

Static Function fCols(aHeader,cAlias,nIndice,cChave,cCondicao,cFiltro)
Local nPos,aCols0,aCols:={}
Local cAliasAnt:=Alias()

dbSelectArea(cAlias)

(cAlias)->(DbSetOrder(nIndice))
(cAlias)->(DbSeek(cChave,.t.))
While (cAlias)->(!Eof() .and. &cCondicao)
	If !(cAlias)->(&cFiltro)
		(cAlias)->(DbSkip())
        Loop
	EndIf
	aCols0:={}
	For nPos:=1 to Len(aHeader)
		If !aHeader[nPos,10]=="V"  //x3_context
			(cAlias)->(AAdd(aCols0,FieldGet(FieldPos(aHeader[nPos,2]))))
		Else
			(cAlias)->(AAdd(aCols0,CriaVar(aHeader[nPos,2])))
			(cAlias)->(AAdd(aCols0,CriaVar(aHeader[nPos,2])))
		EndIf
	Next
	AAdd(aCols0,.F.  )  //Deleted
	AAdd(aCols,aCols0)
	(cAlias)->(DbSkip())
End

If Empty(aCols)
	aCols0:={}
	For nPos:=1 to Len(aHeader)
		(cAlias)->(AAdd(aCols0,CriaVar(aHeader[nPos,2])))
	Next
	AAdd(aCols0,.F.  )  //Deleted
	AAdd(aCols,aCols0)
EndIf

//
aCols0:={}
For nPos:=1 to Len(aHeader)
	(cAlias)->(AAdd(aCols0,CriaVar(aHeader[nPos,2])))
Next
AAdd(aCols0,.F.  )  //Deleted

dbSelectArea(cAliasAnt)

Return(AClone(aCols))

//-----------------------------------------------------------------------------
STATIC FUNCTION fSalvar(oDlg)
Local nPos

If .t.//MsgYesNo("Confirma a atualiza็ใo das tabelas ??")
	fSalvarCh()
	If .t.//MsgYesNo("Tabelas atualizadas com sucesso. Deseja sair ??")
		oDlg:end()
	EndIf
EndIf
Return
//-----------------------------------------------------------------------------
STATIC FUNCTION fSair(oDlg)
If .t.//MsgYesNo("SAIR SEM GRAVAR. Confirma ??")
	oDlg:end()
ENDIF
Return