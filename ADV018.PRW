#INCLUDE "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} ADV018

Impress�o de relatorio de chamados 
@sample		
@author 	Rogerio O Candisani	
@since		 
@version 	P12

@param		
/*/
//-------------------------------------------------------------------
User Function ADV018()

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
@Return	ExpO1: Objeto do relat�rio
@param		
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

Local oReport

Local cAliasQry := GetNextAlias()
Local cPerg:= "ZZD001"

Pergunte( cPerg , .F. )

// Variaveis da secao totalizadora

//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�                                                                        �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//�                                                                        �
//��������������������������������������������������������������������������
oReport := TReport():New("ADV018","Relat�rio de Chamados","ZZD001", {|oReport| ReportPrint(oReport,cAliasQry)},"Este relat�rio ir� emitir a rela��o de cadastro de tecnicos")
oReport:SetTotalInLine(.F.)


//������������������������������������������������������������������������Ŀ
//�Criacao da secao utilizada pelo relatorio                               �
//�                                                                        �
//�TRSection():New                                                         �
//�ExpO1 : Objeto TReport que a secao pertence                             �
//�ExpC2 : Descricao da se�ao                                              �
//�ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   �
//�        sera considerada como principal para a se��o.                   �
//�ExpA4 : Array com as Ordens do relat�rio                                �
//�ExpL5 : Carrega campos do SX3 como celulas                              �
//�        Default : False                                                 �
//�ExpL6 : Carrega ordens do Sindex                                        �
//�        Default : False                                                 �
//�                                                                        �
//��������������������������������������������������������������������������
//������������������������������������������������������������������������Ŀ
//�Criacao da celulas da secao do relatorio                                �
//�                                                                        �
//�TRCell():New                                                            �
//�ExpO1 : Objeto TSection que a secao pertence                            �
//�ExpC2 : Nome da celula do relat�rio. O SX3 ser� consultado              �
//�ExpC3 : Nome da tabela de referencia da celula                          �
//�ExpC4 : Titulo da celula                                                �
//�        Default : X3Titulo()                                            �
//�ExpC5 : Picture                                                         �
//�        Default : X3_PICTURE                                            �
//�ExpC6 : Tamanho                                                         �
//�        Default : X3_TAMANHO                                            �
//�ExpL7 : Informe se o tamanho esta em pixel                              �
//�        Default : False                                                 �
//�ExpB8 : Bloco de c�digo para impressao.                                 �
//�        Default : ExpC2                                                 �
//�                                                                        �
//��������������������������������������������������������������������������
oCadCham := TRSection():New(oReport,"Relat�rio de Chamados",{"tmpZZD"},/*{Array com as ordens do relat�rio}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oCadCham:SetTotalInLine(.F.)

TRCell():New(oCadTec,"ZZD_COD"		,"tmpZZD","Codigo"	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZD)->ZZD_COD})
TRCell():New(oCadTec,"ZZD_DATA"		,"tmpZZD","Data",/*Picture*/,100	,/*lPixel*/,{|| (tmpZZD)->ZZD_DATA})
TRCell():New(oCadTec,"ZZD_TIPO"		,"tmpZZD","Tipo"	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZD)->ZZD_TIPO})
TRCell():New(oCadTec,"ZZD_TECNIC"	,"tmpZZD","Cod. Tec."	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZD)->ZZD_TECNIC})
TRCell():New(oCadTec,"ZZA_NOME"		,"tmpZZD","T�cnico",/*Picture*/,100	,/*lPixel*/,{|| (tmpZZD)->ZZA_NOME})
TRCell():New(oCadTec,"ZZD_PRIORI"	,"tmpZZD","Prioridade"	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZD)->ZZD_COD})
TRCell():New(oCadTec,"ZZC_TIPO"		,"tmpZZD","SLA",/*Picture*/,100	,/*lPixel*/,{|| (tmpZZD)->ZZB_DESC})
TRCell():New(oCadTec,"ZZD_DESCR"	,"tmpZZD","Desc. Chamado"	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZD)->ZZD_DESCR})

//������������������������������������������������������������������������Ŀ
//� Imprime cabecalho da secao no topo da pagina                 		   �
//��������������������������������������������������������������������������

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
@Return	ExpO1: Objeto do relat�rio
@param		
/*/
//-------------------------------------------------------------------

Static Function ReportPrint(oReport,cAliasQry)

	
// Salta pagina na quebra de secao
//oReport:Section(1):SetPageBreak(.T.)
	
//������������������������������������������������������������������������Ŀ
//�Query do relat�rio da secao 1                                           �
//��������������������������������������������������������������������������
oReport:Section(1):BeginQuery()

tmpZZD:= GetNextAlias()	
BeginSql Alias tmpZZD //cAliasQry
	
	SELECT ZZD_COD, ZZD_DATA, ZZD_TIPO, ZZC_DESC, ZZD_TECNIC, ZZA_NOME, ZZD_PRIORI,
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
		ZZD.ZZD_COD BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02% AND
		ZZD.ZZD_TECNIC BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04% AND
		ZZD.%NotDel%
	ORDER BY ZZD.ZZD_COD	
			
EndSql 
	
//������������������������������������������������������������������������Ŀ
//�Metodo EndQuery ( Classe TRSection )                                    �
//�                                                                        �
//�Prepara o relat�rio para executar o Embedded SQL.                       �
//�                                                                        �
//�ExpA1 : Array com os parametros do tipo Range                           �
//�                                                                        �
//��������������������������������������������������������������������������
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

//������������������������������������������������������������������������Ŀ
//� Impressao do Relatorio                                       		   �
//��������������������������������������������������������������������������
dbSelectArea(tmpZZD)
dbGoTop()
oReport:SetMeter((tmpZZD)->(LastRec()))
oReport:Section(1):Init()
While !oReport:Cancel() .And. !(tmpZZD)->(Eof())
	
	//reinicializa a proxima se��o
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