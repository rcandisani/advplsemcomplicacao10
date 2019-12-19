#INCLUDE "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} ADV016

Impressão de relatorio de chamados 
@sample		
@author 	Rogerio O Candisani	
@since		 
@version 	P12

@param		
/*/
//-------------------------------------------------------------------
User Function ADV016()

Local oReport

//-- Interface de impressao
oReport := ReportDef()
oReport:PrintDialog()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef 

	A funcao estatica ReportDef devera ser criada para todos os 
	relatorios que poderao ser agendados pelo usuario. 

@sample		ReportDef
@author 	Rogerio O Candisani	
@since		 
@version 	P12
@Return	ExpO1: Objeto do relatório
@param		
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

Local oReport

Local cAliasQry := GetNextAlias()
Local cPerg:= "ZZD001"

Pergunte( cPerg , .F. )

// Variaveis da secao totalizadora

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("ADV018","Relatório de Chamados","ZZD001", {|oReport| ReportPrint(oReport,cAliasQry)},"Este relatório irá emitir a relação de cadastro de tecnicos")
oReport:SetTotalInLine(.F.)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCadCham := TRSection():New(oReport,"Relatório de Chamados",{"tmpZZD"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oCadCham:SetTotalInLine(.F.)

TRCell():New(oCadCham,"ZZD_COD"		,"tmpZZD","Codigo"	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZD)->ZZD_COD})
TRCell():New(oCadCham,"ZZD_DATA"		,"tmpZZD","Data",/*Picture*/,100	,/*lPixel*/,{|| (tmpZZD)->ZZD_DATA})
TRCell():New(oCadCham,"ZZD_TIPO"		,"tmpZZD","Tipo"	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZD)->ZZD_TIPO})
TRCell():New(oCadCham,"ZZC_DESC"		,"tmpZZD","Descrição",/*Picture*/,100	,/*lPixel*/,{|| (tmpZZD)->ZZC_DESC})
TRCell():New(oCadCham,"ZZD_TECNIC"	,"tmpZZD","Cod. Tec."	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZD)->ZZD_TECNIC})
TRCell():New(oCadCham,"ZZA_NOME"		,"tmpZZD","Técnico",/*Picture*/,100	,/*lPixel*/,{|| (tmpZZD)->ZZA_NOME})
TRCell():New(oCadCham,"ZZD_PRIORI"	,"tmpZZD","Prioridade"	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZD)->ZZD_COD})
TRCell():New(oCadCham,"ZZC_TIPO"		,"tmpZZD","SLA",/*Picture*/,100	,/*lPixel*/,{|| (tmpZZD)->ZZB_DESC})
//TRCell():New(oCadCham,"ZZD_DESCR"	,"tmpZZD","Desc. Chamado"	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZD)->ZZD_DESCR})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho da secao no topo da pagina                 		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:Section(1):SetHeaderPage(.T.)

Return(oReport)

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint 

	A funcao estatica ReportPrint devera ser criada para todos os 
	relatorios que poderao ser agendados pelo usuario. 

@sample		ReportPrint
@author 	Rogerio O Candisani	
@since		 
@version 	P12
@Return	ExpO1: Objeto do relatório
@param		
/*/
//-------------------------------------------------------------------

Static Function ReportPrint(oReport,cAliasQry)

	
// Salta pagina na quebra de secao
//oReport:Section(1):SetPageBreak(.T.)
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()

tmpZZD:= GetNextAlias()	
BeginSql Alias tmpZZD //cAliasQry
	
	SELECT ZZD_COD, ZZD_DATA, ZZD_TIPO, ZZC_DESC, ZZD_TECNIC, ZZA_NOME, ZZD_PRIORI,;
	 		ZZB_DESC, ZZD_DESCR
	FROM %table:ZZD% ZZD
	LEFT OUTER JOIN ZZA990 ZZA ON ZZA_FILIAL = %xFilial:ZZD% 
		AND ZZA_COD = ZZD_TECNIC
		AND ZZA.%NotDel%
	LEFT OUTER JOIN ZZB990 ZZB ON ZZB_FILIAL = %xFilial:ZZD%
		AND ZZB_COD = ZZD_PRIORI
		AND ZZB.%NotDel%
	LEFT OUTER JOIN ZZC990 ZZC ON ZZC_FILIAL = %xFilial:ZZD%
		AND ZZC_COD = ZZD_TIPO
		AND ZZC.%NotDel%
	WHERE ZZD.ZZD_FILIAL = %xFilial:ZZD% AND 
		ZZD.ZZD_DATA BETWEEN %Exp:DtoS(MV_PAR01)% AND %Exp:DtoS(MV_PAR02)% AND
		ZZD.ZZD_COD BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04% AND
		ZZD.%NotDel%
	ORDER BY ZZD.ZZD_COD	
			
EndSql 
	getlastquery()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Relatorio                                       		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(tmpZZD)
dbGoTop()
oReport:SetMeter((tmpZZD)->(LastRec()))
oReport:Section(1):Init()
While !oReport:Cancel() .And. !(tmpZZD)->(Eof())
	
	//reinicializa a proxima seção
	oReport:Section(1):Init()
	oReport:Section(1):PrintLine()
	
	oReport:IncMeter()
	dbSelectArea(tmpZZD)
	(tmpZZD)->(dbSkip())
EndDo
oReport:Section(1):Finish()
oReport:EndPage() //-- Salta Pagina

dbSelectArea(tmpZZD)
dbCloseArea()

Return