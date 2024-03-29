#INCLUDE "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} ADV013 

Impress�o de relatorio de tecnicos em treport 
@sample		
@author 	Rogerio O Candisani	
@since		 
@version 	P12

@param		
/*/
//-------------------------------------------------------------------
User Function ADV013()

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
Local cPerg:= "ZZA001"

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
oReport := TReport():New("ADV013","Cadastro de T�cnicos","ZZA001", {|oReport| ReportPrint(oReport,cAliasQry)},"Este relat�rio ir� emitir a rela��o de cadastro de tecnicos")
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
oCadTec := TRSection():New(oReport,"Cadastro de Tecnicos",{"tmpZZA"},/*{Array com as ordens do relat�rio}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oCadTec:SetTotalInLine(.F.)

TRCell():New(oCadTec,"ZZA_COD"		,"tmpZZA","Codigo"	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZA)->ZZA_COD})
TRCell():New(oCadTec,"ZZA_NOME"		,"tmpZZA","Nome"	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZA)->ZZA_NOME})
TRCell():New(oCadTec,"ZZA_TIPO"		,"tmpZZA","Tipo"	 ,/*Picture*/,/*Tamanho*/	,/*lPixel*/,{|| (tmpZZA)->ZZA_TIPO})

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

tmpZZA:= GetNextAlias()	
BeginSql Alias tmpZZA //cAliasQry
	
	SELECT *  
	FROM %table:ZZA% ZZA
	Where ZZA.ZZA_FILIAL = %xFilial:ZZA% AND
		ZZA.ZZA_COD BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02% AND
		ZZA.%NotDel% 
	Order By ZZA.ZZA_COD
	
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
dbSelectArea(tmpZZA)
dbGoTop()
oReport:SetMeter((tmpZZA)->(LastRec()))
oReport:Section(1):Init()
While !oReport:Cancel() .And. !(tmpZZA)->(Eof())
	
	//reinicializa a proxima se��o
	oReport:Section(1):Init()
	oReport:Section(1):PrintLine()
	
	oReport:IncMeter()
	dbSelectArea(tmpZZA)
	(tmpZZA)->(dbSkip())
EndDo
oReport:Section(1):Finish()
oReport:EndPage() //-- Salta Pagina

dbSelectArea(tmpZZA)
dbCloseArea()

Return