<?xml version="1.0" encoding="ISO-8859-1" ?> 
  
<!-- This is a template stylesheet for conversion
 of agreement xmls to pdf for bug standard agreement type.
Last updated by M.Reddy @ 3/4/2001 -->

<xsl:stylesheet
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
     xmlns:fo="http://www.w3.org/1999/XSL/Format">


<xsl:template match="liquidacion">
	<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"
               xmlns:fox="http://xml.apache.org/fop/extensions">

		<!-- defines page layout -->
		<fo:layout-master-set>

			<fo:simple-page-master	master-name="recibo"
									page-height="21cm" 
									page-width="29.7cm"
									margin-top="1cm" 
									margin-bottom="1cm" 
									margin-left="1cm" 
									margin-right="1cm" >
				<fo:region-body		 />
				<fo:region-before	 />
				<fo:region-after	 />
			</fo:simple-page-master>

		</fo:layout-master-set>


		<!-- RECIBOS -->
		<fo:page-sequence master-name="recibo">
			<!--put all the dynamic stuff here in a table -->
			
			<fo:flow flow-name="xsl-region-body">
				<xsl:apply-templates /> 
			</fo:flow>
		</fo:page-sequence>
		
	</fo:root>
</xsl:template>


<xsl:template match ="recibos">
	<xsl:apply-templates /> 
</xsl:template>


<xsl:template match ="recibo">

	<fo:table >
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />

		<fo:table-column column-width="1.5cm" background-color="white" />

		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />
		<fo:table-column column-width="0.5cm" /><fo:table-column column-width="0.5cm" />

		<xsl:call-template name="header" /> 
		
		<fo:table-body>

			<xsl:apply-templates select="conceptos"/>

			<xsl:call-template name="footer" /> 

		</fo:table-body>


	</fo:table>
	
	
	<!-- <fo:block break-after="page"></fo:block> -->

</xsl:template>


<xsl:template name="header">
		<fo:table-header	background-color="#EEEEEE" 
							text-align="start" font-weight="300" font-size="7pt" >
			<fo:table-row background-color="#FFFFFF" >
				<xsl:call-template name="header_row_a" /> 
				<fo:table-cell	background-color="white" ></fo:table-cell>
				<xsl:call-template name="header_row_a" /> 
			</fo:table-row>
			<fo:table-row background-color="#FFFFFF" >
				<xsl:call-template name="header_row_b" /> 
				<fo:table-cell	background-color="white" ></fo:table-cell>
				<xsl:call-template name="header_row_b" /> 
			</fo:table-row>
			<fo:table-row background-color="#FFFFFF" >
				<xsl:call-template name="header_row_c" /> 
				<fo:table-cell	background-color="white" ></fo:table-cell>
				<xsl:call-template name="header_row_c" /> 
			</fo:table-row>

			<fo:table-row font-size="6pt" >
				<xsl:call-template name="header_row_1" /> 
				<fo:table-cell	background-color="white" border-start-width=".5pt" ></fo:table-cell>
				<xsl:call-template name="header_row_1" /> 
			</fo:table-row>
			<fo:table-row font-size="6pt" >
				<xsl:call-template name="header_row_2" /> 
				<fo:table-cell	background-color="white" border-start-width=".5pt" ></fo:table-cell>
				<xsl:call-template name="header_row_2" /> 
			</fo:table-row>
			<fo:table-row font-size="6pt" >
				<xsl:call-template name="header_row_3" /> 
				<fo:table-cell	background-color="white" border-start-width=".5pt" ></fo:table-cell>
				<xsl:call-template name="header_row_3" /> 
			</fo:table-row>
			<fo:table-row background-color="#FFFFFF" text-align="center" font-size="5pt" >
				<xsl:call-template name="header_row_4" /> 
				<fo:table-cell	background-color="white" border-start-width=".5pt" ></fo:table-cell>
				<xsl:call-template name="header_row_4" /> 
			</fo:table-row>
			<fo:table-row background-color="#FFFFFF"  border-top-width=".5pt" 
					font-family="Courier" font-weight="900" font-size="8pt">
				<fo:table-cell	padding-top=".15cm" border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="8"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="4"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="3"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" border-end-width=".5pt" number-columns-spanned="3"></fo:table-cell>
				<fo:table-cell	background-color="white" border-start-width=".5pt" ></fo:table-cell>
				<fo:table-cell	padding-top=".15cm" border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="8"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="4"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="3"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" border-end-width=".5pt" number-columns-spanned="3"></fo:table-cell>
			</fo:table-row>
		</fo:table-header>
</xsl:template>

<xsl:template name="header_row_a">
				<fo:table-cell	number-columns-spanned="16"  >
					<fo:block	space-after.optimum="6pt" font-family="Times Roman" text-align="start" > 
						<xsl:variable name="logo2" select="/liquidacion/empresa_logo" />
						<fo:external-graphic	src="{$logo2}"  />
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	number-columns-spanned="10"  >
					<fo:block	space-after.optimum="6pt" font-family="Times Roman" 
								font-weight="900" font-size="12pt" > 
						<!-- <xsl:value-of select="/liquidacion/empresa_nombre"/> -->
					</fo:block>
				</fo:table-cell>
</xsl:template>

<xsl:template name="header_row_b">
				<fo:table-cell	number-columns-spanned="16"  >
				</fo:table-cell>
				<fo:table-cell	number-columns-spanned="10" padding-end="0.05cm" >
					<fo:block	font-family="Times Roman" font-size="9pt" font-weight="900" text-align="end">
						Recibo de Haberes
					</fo:block>
				</fo:table-cell>
</xsl:template>

<xsl:template name="header_row_c">
				<fo:table-cell	padding-bottom="0.05cm" padding-start="0.05cm" number-columns-spanned="10"  >
					<fo:block	space-before.optimum="0.05cm" font-weight="300" font-size="5pt" > 
						<xsl:value-of select="/liquidacion/empresa_direccion"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	number-columns-spanned="16" padding-end="0.05cm" >
					<fo:block	space-before.optimum="0.05cm" text-align="end" 
								font-weight="300" font-size="5pt" > 
						C.U.I.T. Nº <xsl:value-of select="/liquidacion/empresa_cuit"/> - Nro ANSES empleador: <xsl:value-of select="substring(/liquidacion/empresa_cuit,4,8)"/>
					</fo:block>
				</fo:table-cell>
<!--			<fo:table-cell	padding-end="0.15cm" number-columns-spanned="4"  >
					<fo:block	space-before.optimum="0.05cm" text-align="end" font-size="9pt" 
								font-family="Courier" font-weight="900" >
							 <xsl:value-of select="recibo_nro"/> 
					</fo:block>
				</fo:table-cell>	-->
</xsl:template>

<xsl:template name="header_row_1">
				<fo:table-cell	padding="0.05cm" border-width=".5pt" 
								number-columns-spanned="9">
					<fo:block> Sector </fo:block>
					<fo:block	space-before.optimum="3pt"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="sector"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="13">
					<fo:block> Apellido y nombre </fo:block>
					<fo:block	space-before.optimum="3pt"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="apeynom"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="4">
					<fo:block> Legajo nº </fo:block>
					<fo:block	space-before.optimum="3pt" text-align="end"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="legajo"/>
					</fo:block>
				</fo:table-cell>
</xsl:template>

<xsl:template name="header_row_2">
				<fo:table-cell	padding-top="0.05cm" padding-bottom="0.05cm" padding-start="0.05cm" 
								border-width=".5pt" number-columns-spanned="5">
					<fo:block> CUIL </fo:block>
					<fo:block	space-before.optimum="3pt" text-align="center"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="cuil"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="7">
					<fo:block> Categoría </fo:block>
					<fo:block	space-before.optimum="3pt"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="calificacion"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="10">
					<fo:block> Función </fo:block>
					<fo:block	space-before.optimum="3pt"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="funcion"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="4">
					<fo:block> RTM </fo:block>
					<fo:block	space-before.optimum="3pt" text-align="end"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="rtm"/>
					</fo:block>
				</fo:table-cell>
</xsl:template>

<xsl:template name="header_row_3">
				<fo:table-cell	padding="0.05cm" border-width=".5pt" 
								number-columns-spanned="4">
					<fo:block> Fecha Ingreso </fo:block>
					<fo:block	space-before.optimum="3pt" text-align="center"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="fecha_ingreso"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt" 
								number-columns-spanned="3">
					<fo:block> Antigüedad </fo:block>
					<fo:block	space-before.optimum="3pt" text-align="center"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="antiguedad"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt" 
								number-columns-spanned="4">
					<fo:block> Fecha depósito </fo:block>
					<fo:block	space-before.optimum="3pt" text-align="center" 
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="/liquidacion/fecha" />
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt" 
								number-columns-spanned="5">
					<fo:block> Periodo depositado </fo:block>
					<fo:block	space-before.optimum="3pt"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="/liquidacion/periodo_depositado" />
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" text-align="start" border-width=".5pt" 
								number-columns-spanned="5">
					<fo:block> Banco </fo:block>
					<fo:block	space-before.optimum="3pt"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="/liquidacion/banco" />
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt" text-align="start"
								number-columns-spanned="5">
					<fo:block> Periodo liquidado </fo:block>
					<fo:block	space-before.optimum="3pt"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="/liquidacion/periodo_liquidado" />
					</fo:block>
				</fo:table-cell>
</xsl:template>

<xsl:template name="header_row_4">
				<fo:table-cell	padding="0.05cm" border-width=".5pt" 
								number-columns-spanned="2">
					<fo:block> Código </fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt" 
								number-columns-spanned="8">
					<fo:block> Concepto </fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="2">
					<fo:block> Unid. </fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="2">
					<fo:block> Valor </fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="2">
					<fo:block> Porc. </fo:block>
				</fo:table-cell>
				
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="4">
					<fo:block> Remuneraciones sujetas a retención </fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Remuneraciones exentas </fo:block>
				</fo:table-cell>

				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Retenciones </fo:block>
				</fo:table-cell>
</xsl:template>


<xsl:template name="footer">
			<fo:table-row font-family="Courier" font-weight="900" font-size="8pt">
				<fo:table-cell	padding-top=".15cm" border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="8"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="4"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="3"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" border-end-width=".5pt" number-columns-spanned="3"></fo:table-cell>
				<fo:table-cell	background-color="white" border-start-width=".5pt" ></fo:table-cell>
				<fo:table-cell	padding-top=".15cm" border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="8"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="2"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="4"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" number-columns-spanned="3"></fo:table-cell>
				<fo:table-cell	border-start-width=".5pt" border-end-width=".5pt" number-columns-spanned="3"></fo:table-cell>
			</fo:table-row>
			<fo:table-row  background-color="#EEEEEE" text-align="start" font-weight="300" font-size="6pt" >
				<xsl:call-template name="footer_row_1" /> 
				<fo:table-cell	background-color="white" border-start-width=".5pt" ></fo:table-cell>
				<xsl:call-template name="footer_row_1" /> 
			</fo:table-row>
			<fo:table-row  background-color="#EEEEEE" text-align="start" font-weight="300" font-size="6pt" >
				<xsl:call-template name="footer_row_2" /> 
				<fo:table-cell	background-color="white" border-start-width=".5pt" ></fo:table-cell>
				<xsl:call-template name="footer_row_2" /> 
			</fo:table-row>
			<fo:table-row background-color="#FFFFFF" text-align="start" font-weight="300" font-size="6pt" >
				<xsl:call-template name="footer_row_3_dupli" /> 
				<fo:table-cell	background-color="white" border-start-width=".5pt" ></fo:table-cell>
				<xsl:call-template name="footer_row_3_origi" /> 
			</fo:table-row>
			<fo:table-row background-color="#FFFFFF" text-align="start" font-weight="300" font-size="6pt" >
				<xsl:call-template name="footer_row_4_dupli" /> 
				<fo:table-cell	background-color="white" border-start-width=".5pt" ></fo:table-cell>
				<xsl:call-template name="footer_row_4_origi" /> 
			</fo:table-row>
</xsl:template>

<xsl:template name="footer_row_1">
				<fo:table-cell	padding="0.05cm" border-width=".5pt" 
								number-columns-spanned="16">
					<fo:block > 
						Acreditado en 
					</fo:block>
					<fo:block space-before.optimum="3pt" font-family="Courier" font-weight="900" font-size="7pt"> 
						<xsl:if test="name() != 'concepto' ">
							<xsl:value-of select="acreditado_en_cuenta_tipo"/>
							Nro: 
							<xsl:value-of select="acreditado_en_cuenta_nro"/>
						</xsl:if>
						<xsl:if test="name() = 'concepto' ">
							<fo:inline color="#EEEEEE" >.</fo:inline>
						</xsl:if>
					</fo:block>
								
<!--
					<fo:block> 
						Acreditado en 
						<fo:inline font-family="Courier" font-weight="900" font-size="8pt">
							<xsl:value-of select="acreditado_en_banco"/>
						</fo:inline>  
					</fo:block>
					<fo:block	font-family="Courier" font-weight="900" font-size="8pt" > 
							<xsl:value-of select="acreditado_en_cuenta_tipo"/>
							<xsl:if test="name() = 'concepto' ">
								<fo:inline color="#EEEEEE" >.</fo:inline>
							</xsl:if>
					</fo:block>
					<fo:block	font-family="Courier" font-weight="900" font-size="8pt" > 
							<xsl:value-of select="acreditado_en_cuenta_nro"/>
							<xsl:if test="name() = 'concepto' ">
								<fo:inline color="#EEEEEE" >.</fo:inline>
							</xsl:if>
					</fo:block>
-->					
				</fo:table-cell>
				
				<fo:table-cell	padding-top="0.05cm" padding-bottom="0.05cm" padding-start="0.05cm" padding-end="0.1cm" border-width=".5pt"
								number-columns-spanned="4">
					<fo:block text-align="start" font-size="5pt"> Total sujeto a retenc. </fo:block>
					<fo:block	space-before.optimum="6pt" text-align="end"
								font-family="Courier" font-weight="900" font-size="6pt" > 
							<xsl:value-of select="haberes_con_aporte"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top="0.05cm" padding-bottom="0.05cm" padding-start="0.05cm" padding-end="0.1cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block text-align="start" font-size="5pt"> Total exento </fo:block>
					<fo:block	space-before.optimum="6pt" text-align="end"
								font-family="Courier" font-weight="900" font-size="6pt" > 
							<xsl:value-of select="haberes_sin_aporte"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top="0.05cm" padding-bottom="0.05cm" padding-start="0.05cm" padding-end="0.1cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block text-align="start" font-size="5pt"> Total retenc. </fo:block>
					<fo:block	space-before.optimum="6pt" text-align="end"
								font-family="Courier" font-weight="900" font-size="6pt" > 
							<xsl:value-of select="descuentos"/>
							<xsl:if test="name() = 'concepto' ">
								<fo:inline color="#EEEEEE" >.</fo:inline>
							</xsl:if>
					</fo:block>
				</fo:table-cell>
</xsl:template>

<xsl:template name="footer_row_2">
				<fo:table-cell	padding="0.05cm" border-width=".5pt" 
								number-columns-spanned="20">
					<fo:block> Son pesos </fo:block>
					<fo:block	space-before.optimum="6pt"
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:value-of select="son_pesos"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top="0.05cm" padding-bottom="0.05cm" padding-start="0.05cm" padding-end="0.1cm" border-width="1.5pt"
								number-columns-spanned="6">
					<fo:block font-weight="900" > NETO A COBRAR </fo:block>
					<fo:block	space-before.optimum="6pt" text-align="end" 
								font-family="Courier" font-weight="900" font-size="7pt" > 
							<xsl:if test="name() != 'concepto' ">
								$ <xsl:value-of select="neto"/>
							</xsl:if>
							<xsl:if test="name() = 'concepto' ">
								<fo:inline color="#EEEEEE" >.</fo:inline>
							</xsl:if>
					</fo:block>
				</fo:table-cell>
</xsl:template>

<xsl:template name="footer_row_3_dupli">
				<fo:table-cell	border-start-width="0.5pt" border-top-width="0.5pt" border-end-width="0.5pt"  
								number-columns-spanned="11"   >
					<fo:table>
						<fo:table-column column-width="2cm" />
						<fo:table-column column-width="3.5cm" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell padding="0.05cm" border-bottom-width="0.5pt" >
									<fo:block> Fecha de Pago </fo:block>
									<fo:block	space-before.optimum="3pt" text-align="center"
											font-family="Courier" font-weight="900" font-size="7pt" > 
										<xsl:if test="name() = 'recibo' ">
											<fo:inline ><xsl:value-of select="/liquidacion/fecha_pago" /></fo:inline>
										</xsl:if>
										<xsl:if test="name() = 'concepto' ">
											<fo:inline color="#FFFFFF" >.</fo:inline>
										</xsl:if>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding="0.05cm" border-bottom-width="0.5pt" border-start-width="0.5pt" >
									<fo:block> 
										Lugar de Pago 
										<fo:inline font-family="Courier" font-weight="900" font-size="7pt">
											<xsl:value-of select="lugar_pago_edificio"/>
											<xsl:if test="name() = 'concepto' ">
												<fo:inline color="#FFFFFF" >.</fo:inline>
											</xsl:if>
										</fo:inline>
									</fo:block>
									<fo:block	font-family="Courier" font-weight="900" font-size="7pt" > 
										<xsl:value-of select="lugar_pago_direccion"/>
										<xsl:if test="name() = 'concepto' ">
											<fo:inline color="#FFFFFF" >.</fo:inline>
										</xsl:if>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row>
								<fo:table-cell padding-top="0.1cm" padding-start="0.05cm" padding-end="0.1cm" 
										number-columns-spanned="2" >
									<fo:block font-size="5pt" text-align="justify" >
										Esta suma incluye todos los conceptos remunerativos que corresp. 
										por básico de convenio, adicionales, aumento de gobierno, aumento 
										voluntario, el adic. vol. es absorbible y a cta. de cualq. 
										incremento legal dispuesto por el gob. nac. sobre salarios reales y 
										tot. o convenc. de la conv. col. vig. y actualiz. e incluye decreto 261/91.
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:table-cell>
<!--			<fo:table-cell	padding="0.15cm" border-start-width="0.5pt" border-top-width="0.5pt" border-end-width="0.5pt"  
								number-columns-spanned="11" >
					<fo:block> Fecha y Lugar de Pago </fo:block>
					<fo:block	space-before.optimum="6pt"
								font-family="Courier" font-weight="900" font-size="8pt" > 
						<xsl:if test="name() = 'recibo' ">
							<fo:inline ><xsl:value-of select="/liquidacion/fecha_pago" /></fo:inline>
						</xsl:if>
						<xsl:if test="name() = 'concepto' ">
							<fo:inline color="#FFFFFF" >.</fo:inline>
						</xsl:if>
					</fo:block>
					<fo:block	font-family="Courier" font-weight="900" font-size="8pt" > 
						<xsl:value-of select="lugar_pago_edificio"/>
						<xsl:if test="name() = 'concepto' ">
							<fo:inline color="#FFFFFF" >.</fo:inline>
						</xsl:if>
					</fo:block>
					<fo:block	font-family="Courier" font-weight="900" font-size="8pt" > 
						<xsl:value-of select="lugar_pago_direccion"/>
						<xsl:if test="name() = 'concepto' ">
							<fo:inline color="#FFFFFF" >.</fo:inline>
						</xsl:if>
					</fo:block>
				</fo:table-cell>
-->				
				
				<fo:table-cell	padding-top="0.15cm" padding-start="0.15cm" padding-end="0.15cm" border-top-width=".5pt"
								number-columns-spanned="8">
					<fo:block text-align="justify" font-size="6pt" > 
						El presente es copia fiel del recibo original que obra en nuestro poder firmado por el interesado.
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	border-top-width=".5pt" number-columns-spanned="1" >
				</fo:table-cell>
				<fo:table-cell	padding-top="0.15cm" border-top-width=".5pt"
								number-columns-spanned="5" >
					<xsl:variable name="firma" select="/liquidacion/firma_empleador" />
					<fo:block space-before.optimum="6pt" >
						<xsl:if test="name() = 'recibo' ">
							<fo:external-graphic	src="{$firma}"  />
						</xsl:if>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	border-end-width=".5pt" border-top-width=".5pt"
								number-columns-spanned="1" >
				</fo:table-cell>
</xsl:template>

<xsl:template name="footer_row_3_origi">
				<fo:table-cell	border-start-width="0.5pt" border-top-width="0.5pt" border-end-width="0.5pt"  
								number-columns-spanned="11"   >
					<fo:table>
						<fo:table-column column-width="2cm" />
						<fo:table-column column-width="3.5cm" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell padding="0.05cm" border-bottom-width="0.5pt" >
									<fo:block> Fecha de Pago </fo:block>
									<fo:block	space-before.optimum="3pt" text-align="center"
											font-family="Courier" font-weight="900" font-size="7pt" > 
										<xsl:if test="name() = 'recibo' ">
											<fo:inline ><xsl:value-of select="/liquidacion/fecha_pago" /></fo:inline>
										</xsl:if>
										<xsl:if test="name() = 'concepto' ">
											<fo:inline color="#FFFFFF" >.</fo:inline>
										</xsl:if>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding="0.05cm" border-bottom-width="0.5pt" border-start-width="0.5pt" >
									<fo:block> 
										Lugar de Pago 
										<fo:inline font-family="Courier" font-weight="900" font-size="7pt">
											<xsl:value-of select="lugar_pago_edificio"/>
											<xsl:if test="name() = 'concepto' ">
												<fo:inline color="#FFFFFF" >.</fo:inline>
											</xsl:if>
										</fo:inline>
									</fo:block>
									<fo:block	font-family="Courier" font-weight="900" font-size="7pt" > 
										<xsl:value-of select="lugar_pago_direccion"/>
										<xsl:if test="name() = 'concepto' ">
											<fo:inline color="#FFFFFF" >.</fo:inline>
										</xsl:if>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row>
								<fo:table-cell padding-top="0.1cm" padding-start="0.05cm" padding-end="0.1cm" 
										number-columns-spanned="2" >
									<fo:block font-size="5pt" text-align="justify" >
										Esta suma incluye todos los conceptos remunerativos que corresp. 
										por básico de convenio, adicionales, aumento de gobierno, aumento 
										voluntario, el adic. vol. es absorbible y a cta. de cualq. 
										incremento legal dispuesto por el gob. nac. sobre salarios reales y 
										tot. o convenc. de la conv. col. vig. y actualiz. e incluye decreto 261/91.
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:table-cell>
				<fo:table-cell	padding-top="0.15cm" padding-start="0.15cm" padding-end="0.15cm" border-top-width=".5pt"
								number-columns-spanned="8">
					<fo:block text-align="justify" font-size="6pt" > 
						Recibí de:
						<fo:inline font-family="Courier" font-weight="900" font-size="7pt" >
							<xsl:value-of select="/liquidacion/empresa_nombre" />
						</fo:inline>  
						el importe que se indica mas arriba en concepto de pago total de los rubros que se detallan precedentemente, asimismo recibí el duplicado de este recibo.
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top="0.15cm" border-end-width=".5pt" border-top-width=".5pt"
								number-columns-spanned="7" >
				</fo:table-cell>
</xsl:template>

<xsl:template name="footer_row_4_dupli">
				<fo:table-cell	padding="0.15cm" border-start-width=".5pt" border-bottom-width=".5pt" 
								number-columns-spanned="11" >
				</fo:table-cell>
				<fo:table-cell	padding-top="0.15cm" padding-start="0.15cm" border-bottom-width=".5pt" border-start-width=".5pt" 
								number-columns-spanned="8" >
					<fo:block	font-weight="900" > 
						DUPLICADO
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top="0.15cm" border-end-width=".5pt" border-bottom-width=".5pt" 
								number-columns-spanned="7" >
					<fo:block	text-align="center" > 
						Firma del Empleador
					</fo:block>
				</fo:table-cell>
</xsl:template>

<xsl:template name="footer_row_4_origi">
				<fo:table-cell	padding="0.15cm" border-start-width=".5pt" border-bottom-width=".5pt" 
								number-columns-spanned="11" >
				</fo:table-cell>
				<fo:table-cell	padding-top="0.15cm" padding-start="0.15cm" border-bottom-width=".5pt" border-start-width=".5pt" 
								number-columns-spanned="8" >
					<fo:block	font-weight="900" > 
						<!-- ORIGINAL -->
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top="0.15cm" border-end-width=".5pt" border-bottom-width=".5pt" 
								number-columns-spanned="7" >
					<fo:block	text-align="center" > 
						Firma del Empleado
					</fo:block>
				</fo:table-cell>
</xsl:template>

<xsl:template match ="conceptos">

			<xsl:apply-templates select="concepto"/>

			<xsl:variable name="max_cptos_pag" select="25" />
			<xsl:variable name="total_conceptos" select="count(concepto)" />
			
			<xsl:variable name="cptos_empties" select="$max_cptos_pag - ($total_conceptos mod $max_cptos_pag)" />

			<xsl:if test="$cptos_empties &lt; $max_cptos_pag">
				<xsl:call-template name="concepto_empty">
					<xsl:with-param name="p1" select="$cptos_empties" />
				</xsl:call-template>
			</xsl:if>

</xsl:template>

<xsl:template match="concepto">
			<fo:table-row font-family="Courier" font-weight="900" font-size="6pt"> 
				<xsl:call-template name="concepto_row" /> 
				<fo:table-cell	background-color="white" border-start-width=".5pt" ></fo:table-cell>
				<xsl:call-template name="concepto_row" /> 
			</fo:table-row>

	<xsl:variable name="nro_concepto" select="position()" />

	<xsl:if test="$nro_concepto mod 25 = 0">
		<xsl:if test="not(position()=last())">
			<xsl:call-template name="footer" /> 
			<fo:table-row>
				<fo:table-cell><fo:block break-after="page"></fo:block></fo:table-cell>
			</fo:table-row>
		</xsl:if>
	</xsl:if>

</xsl:template>

<xsl:template name="concepto_row">

	<xsl:variable name="codigo_concepto" select="codigo" />

	<xsl:if test="$codigo_concepto = 'zzz'">
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".05cm" 
						border-start-width=".5pt" number-columns-spanned="2">
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".15cm" padding-end=".15cm" 
						border-start-width=".5pt" number-columns-spanned="8">
					<fo:block>
						<!-- <xsl:value-of select="descripcion"/>  ***** VER SI QUEDA !!!! ****** -->
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".05cm" 
						border-start-width=".5pt" number-columns-spanned="2">
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".05cm" 
						border-start-width=".5pt" number-columns-spanned="2">
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".05cm" 
						border-start-width=".5pt" number-columns-spanned="2">
				</fo:table-cell>
	</xsl:if>
	<xsl:if test="$codigo_concepto != 'zzz'">
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".1cm" border-start-width=".5pt"
								number-columns-spanned="2">
					<fo:block>
						<xsl:value-of select="codigo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".1cm" border-start-width=".5pt"
								number-columns-spanned="8">
					<fo:block>
						<xsl:value-of select="descripcion"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end"
								number-columns-spanned="2" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="unidades"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end"
								number-columns-spanned="2" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="valor"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end"
								number-columns-spanned="2" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="porcentaje"/>
					</fo:block>
				</fo:table-cell>
	</xsl:if>
				
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" border-start-width=".5pt" text-align="end"
								number-columns-spanned="4">
					<fo:block>
						<xsl:value-of select="haberes"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" border-start-width=".5pt" text-align="end"
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="haberes_exentos"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								text-align="end" number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="descuento"/>
					</fo:block>
				</fo:table-cell>
</xsl:template>

<xsl:template name="concepto_empty">
	<xsl:param name="p1" />
	
			<fo:table-row font-family="Courier" font-weight="900" font-size="6pt">
				<xsl:call-template name="concepto_row_empty" /> 
				<fo:table-cell	background-color="white" border-start-width=".5pt" ></fo:table-cell>
				<xsl:call-template name="concepto_row_empty" /> 
			</fo:table-row>
			
	<xsl:if test="$p1 > 1">
		<xsl:call-template name="concepto_empty">
			<xsl:with-param name="p1" select="$p1 - 1" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="concepto_row_empty">
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".15cm" border-start-width=".5pt"
								number-columns-spanned="2">
					<fo:block color="white" >.</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".15cm" border-start-width=".5pt" 
								number-columns-spanned="8">
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".15cm" border-start-width=".5pt" 
								number-columns-spanned="2">
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".15cm" text-align="end" border-start-width=".5pt"
								number-columns-spanned="2">
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".15cm" text-align="end" border-start-width=".5pt"
								number-columns-spanned="2">
				</fo:table-cell>
				
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".15cm" border-start-width=".5pt" text-align="end" 
								number-columns-spanned="4">
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".15cm" border-start-width=".5pt" text-align="end"
								number-columns-spanned="3">
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".15cm" border-start-width=".5pt" border-end-width=".5pt"
								text-align="end" number-columns-spanned="3">
				</fo:table-cell>
</xsl:template>


</xsl:stylesheet>


