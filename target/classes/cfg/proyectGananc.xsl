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
									page-height="23cm" 
									page-width="35.7cm"
									margin-top="1cm" 
									margin-bottom="1cm" 
									margin-left="0.5cm" 
									margin-right="0.5cm" >
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
		
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
		<fo:table-column column-width="0.72cm" /><fo:table-column column-width="0.72cm" />
	                                                                                 
		
		<xsl:call-template name="header" /> 
		
		<fo:table-body>

			<xsl:apply-templates select="conceptos"/>

			<xsl:call-template name="footer" /> 

		</fo:table-body>


	</fo:table>
	
	

</xsl:template>


<xsl:template name="header">
		<fo:table-header	background-color="#EEEEEE" 
							text-align="start" font-weight="300" font-size="7pt" >
			
			<fo:table-row background-color="#FFFFFF" >
				<xsl:call-template name="header_row_b" /> 

			</fo:table-row>
			
			<fo:table-row background-color="#FFFFFF" >
				<xsl:call-template name="header_row_c" /> 
				
			</fo:table-row>
			
			<fo:table-row background-color="#FFFFFF" text-align="center" font-weight="bold" font-size="8pt" >
				<xsl:call-template name="header_row_4" /> 
				
			</fo:table-row>
			
		</fo:table-header>
</xsl:template>



<xsl:template name="header_row_b">
				<fo:table-cell	number-columns-spanned="6"  >
				</fo:table-cell>
				<fo:table-cell	number-columns-spanned="38" padding-end="0.05cm" >
					<fo:block	font-family="Times Roman" font-size="9pt" font-weight="900" text-align="center">
						PROYECTADO DE GANANCIAS: 
						<xsl:value-of select="anio_reporte"/>
					</fo:block>
				</fo:table-cell>
				
			
</xsl:template>
<xsl:template name="header_row_c">
				<fo:table-cell	padding-bottom="0.05cm" padding-start="0.05cm" number-columns-spanned="9"  >
					<fo:block	white-space-collapse="false" space-before.optimum="0.05cm" font-weight="300" font-size="5pt" > 
						<xsl:value-of select="legajo_informado"/>
					</fo:block>
					<fo:block	space-before.optimum="0.05cm" font-weight="300" font-size="5pt" > 
						<xsl:value-of select="empresa"/>
					</fo:block>
				</fo:table-cell>

</xsl:template>
<xsl:template name="header_row_4">

				<fo:table-cell	padding="0.05cm" border-width=".5pt" 
								number-columns-spanned="9">
					<fo:block> Concepto </fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt" 
								number-columns-spanned="3">
					<fo:block> Enero </fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Febrero </fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Marzo </fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Abril </fo:block>
				</fo:table-cell>
				
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Mayo </fo:block>
				</fo:table-cell>
				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Junio </fo:block>
				</fo:table-cell>

				<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Julio </fo:block>
				</fo:table-cell>
					<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Agosto </fo:block>
				</fo:table-cell>
					<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Septiembre </fo:block>
				</fo:table-cell>
					<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Octubre </fo:block>
				</fo:table-cell>
					<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Noviembre </fo:block>
				</fo:table-cell>
					<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Diciembre </fo:block>
				</fo:table-cell>
					<fo:table-cell	padding="0.05cm" border-width=".5pt"
								number-columns-spanned="3">
					<fo:block> Total </fo:block>
				</fo:table-cell>
				
				
</xsl:template>


    <xsl:template name="footer">
			
			<fo:table-row  background-color="#EEEEEE" text-align="start" font-weight="300" font-size="8pt" >
				<xsl:call-template name="footer_row_1" /> 
				
				 
			</fo:table-row>
			
</xsl:template>

<xsl:template name="footer_row_1">
				<fo:table-cell font-weight="bold" padding="0.05cm" border-width=".5pt" 
								number-columns-spanned="49">
													<fo:block color="red" > 
						Los datos del presente documento son a modo estimativo. 
					</fo:block>
				</fo:table-cell>
</xsl:template>

    <xsl:template name="separador">
			
			<fo:table-row  background-color="black" text-align="start" font-weight="300" font-size="6pt" >
				<xsl:call-template name="separador_row_1" /> 
				
				 
			</fo:table-row>
			
</xsl:template>
<xsl:template name="separador_row_1">
				<fo:table-cell	padding="0.00cm" border-width=".1pt" 
								number-columns-spanned="0">

					
				</fo:table-cell>
</xsl:template>

<xsl:template match ="conceptos">

			<xsl:apply-templates select="concepto"/>

			<xsl:variable name="max_cptos_pag" select="100" />
			<xsl:variable name="total_conceptos" select="count(concepto)" />
			
			<xsl:variable name="cptos_empties" select="$max_cptos_pag - ($total_conceptos mod $max_cptos_pag)" />

			

</xsl:template>


<xsl:template match="concepto">


				<xsl:variable name="codigo_concepto" select="descConcepto" />
				
				<xsl:if test="$codigo_concepto = 'zzz'">
				
				<fo:table-row font-family="Courier" font-weight="100" font-size="7.3pt">
				<xsl:call-template name="concepto_row" /> 
				</fo:table-row>
				
				</xsl:if>
				<xsl:if test="$codigo_concepto != 'zzz'">
						<xsl:if test="$codigo_concepto != 'separa'">
									
				<fo:table-row font-family="Courier" font-weight="100" font-size="7.3pt">
				<xsl:call-template name="concepto_row" /> 
				</fo:table-row>
										
						</xsl:if>
						<xsl:if test="$codigo_concepto = 'separa'">
						
						
		<fo:table-row  background-color="black" text-align="start" font-weight="300" font-size="6pt" >
				<xsl:call-template name="separador_row_1" /> 
				
				 
			</fo:table-row>
						
						
						</xsl:if>
											
				
				</xsl:if>
							
			

	<xsl:variable name="nro_concepto" select="position()" />

	<xsl:if test="$nro_concepto mod 100 = 0">
		<xsl:if test="not(position()=last())">
			<xsl:call-template name="footer" /> 
			<fo:table-row>
				<fo:table-cell><fo:block break-after="page"></fo:block></fo:table-cell>
			</fo:table-row>
		</xsl:if>
	</xsl:if>

</xsl:template>


<xsl:template name="concepto_row">

	<xsl:variable name="codigo_concepto" select="descConcepto" />

	
			<xsl:if test="$codigo_concepto = 'separa'">
		
			<fo:table-cell border-top="0pt" border-bottom="0.5pt" border-left="0pt" border-right="0pt" border-style="solid" background-color="black"  border-width=".3pt" 
								number-columns-spanned="49">
					
				</fo:table-cell>
			
	</xsl:if>
	
	
	
	
	
	<xsl:if test="$codigo_concepto != 'Impuesto Mensual'">
	
		<xsl:if test="$codigo_concepto != 'Neto Proyectado'">
		
			<xsl:if test="$codigo_concepto != 'Total Conceptos Tributables Acum.(A)'">
			
				<xsl:if test="$codigo_concepto != 'Retenciones de Ley Acum.(B)'">
				
					<xsl:if test="$codigo_concepto != 'Total Deducciones (C)'">
						
						<xsl:if test="$codigo_concepto != 'Impuesto total'">
	<xsl:if test="$codigo_concepto != 'separa'">

	<xsl:if test="$codigo_concepto = 'zzz'">
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".05cm" 
						border-start-width=".5pt"  number-columns-spanned="9">
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".05cm"  
						border-start-width=".5pt" text-align="end" number-columns-spanned="3">
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".05cm" 
						border-start-width=".5pt" text-align="end" number-columns-spanned="3">
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".05cm" 
						border-start-width=".5pt" text-align="end" number-columns-spanned="3">
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-start=".05cm" 
						border-start-width=".5pt" text-align="end" number-columns-spanned="3">
				</fo:table-cell>
	</xsl:if>
	<xsl:if test="$codigo_concepto != 'zzz'">
				<fo:table-cell 	padding-top=".05cm" padding-bottom=".05cm" padding-start=".1cm" border-start-width=".5pt"  number-columns-spanned="9">
					<fo:block>
						<xsl:value-of select="descConcepto"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt">
					<fo:block>
						<xsl:value-of select="enero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm"   text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="febrero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="marzo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="abril"/>
					</fo:block>
				</fo:table-cell>
	</xsl:if>
		</xsl:if>

				
					
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="mayo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="junio"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="julio"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="agosto"/>
					</fo:block>
				</fo:table-cell>
					<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="septiembre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="octubre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="noviembre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="diciembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell	font-weight="bold" padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="total"/>
					</fo:block>
				</fo:table-cell>
										</xsl:if>
									</xsl:if>
								</xsl:if>
						</xsl:if>
					</xsl:if>
				</xsl:if>
				
				
				
	<xsl:if test="$codigo_concepto = 'Impuesto Mensual'">
	

				<fo:table-cell  font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-start=".1cm" border-start-width=".5pt"  number-columns-spanned="9">
					<fo:block>
						<xsl:value-of select="descConcepto"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt">
					<fo:block>
						<xsl:value-of select="enero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm"   text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="febrero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="marzo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="abril"/>
					</fo:block>
				</fo:table-cell>
	

				
					
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="mayo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="junio"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="julio"/>
					</fo:block>
				</fo:table-cell>
				
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="agosto"/>
					</fo:block>
				</fo:table-cell>
					<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="septiembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="octubre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="noviembre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="diciembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell 	font-weight="bold" padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="total"/>
					</fo:block>
				</fo:table-cell>
				
				</xsl:if>
				<xsl:if test="$codigo_concepto = 'Neto Proyectado'">
	

				<fo:table-cell  font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-start=".1cm" border-start-width=".5pt"  number-columns-spanned="9">
					<fo:block>
						<xsl:value-of select="descConcepto"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt">
					<fo:block>
						<xsl:value-of select="enero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm"   text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="febrero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="marzo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="abril"/>
					</fo:block>
				</fo:table-cell>
	

				
					
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="mayo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="junio"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="julio"/>
					</fo:block>
				</fo:table-cell>
				
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="agosto"/>
					</fo:block>
				</fo:table-cell>
					<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="septiembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="octubre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="noviembre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="diciembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell 	font-weight="bold" padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="total"/>
					</fo:block>
				</fo:table-cell>
				
				</xsl:if>
				<xsl:if test="$codigo_concepto = 'Total Conceptos Tributables Acum.(A)'">
	

				<fo:table-cell  font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-start=".1cm" border-start-width=".5pt"  number-columns-spanned="9">
					<fo:block>
						<xsl:value-of select="descConcepto"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt">
					<fo:block>
						<xsl:value-of select="enero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm"   text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="febrero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="marzo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="abril"/>
					</fo:block>
				</fo:table-cell>
	

				
					
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="mayo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="junio"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="julio"/>
					</fo:block>
				</fo:table-cell>
				
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="agosto"/>
					</fo:block>
				</fo:table-cell>
					<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="septiembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="octubre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="noviembre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="diciembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell 	font-weight="bold" padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="total"/>
					</fo:block>
				</fo:table-cell>
				
				</xsl:if>
				<xsl:if test="$codigo_concepto = 'Retenciones de Ley Acum.(B)'">
	

				<fo:table-cell  font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-start=".1cm" border-start-width=".5pt"  number-columns-spanned="9">
					<fo:block>
						<xsl:value-of select="descConcepto"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt">
					<fo:block>
						<xsl:value-of select="enero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm"   text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="febrero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="marzo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="abril"/>
					</fo:block>
				</fo:table-cell>
	

				
					
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="mayo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="junio"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="julio"/>
					</fo:block>
				</fo:table-cell>
				
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="agosto"/>
					</fo:block>
				</fo:table-cell>
					<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="septiembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="octubre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="noviembre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="diciembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell 	font-weight="bold" padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="total"/>
					</fo:block>
				</fo:table-cell>
				
				</xsl:if>
				<xsl:if test="$codigo_concepto = 'Total Deducciones (C)'">
	

				<fo:table-cell  font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-start=".1cm" border-start-width=".5pt"  number-columns-spanned="9">
					<fo:block>
						<xsl:value-of select="descConcepto"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt">
					<fo:block>
						<xsl:value-of select="enero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm"   text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="febrero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="marzo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="abril"/>
					</fo:block>
				</fo:table-cell>
	

				
					
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="mayo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="junio"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="julio"/>
					</fo:block>
				</fo:table-cell>
				
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="agosto"/>
					</fo:block>
				</fo:table-cell>
					<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="septiembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="octubre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="noviembre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="diciembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell 	font-weight="bold" padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="total"/>
					</fo:block>
				</fo:table-cell>
				
				</xsl:if>
				<xsl:if test="$codigo_concepto = 'Impuesto total'">
	

				<fo:table-cell  font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-start=".1cm" border-start-width=".5pt"  number-columns-spanned="9">
					<fo:block>
						<xsl:value-of select="descConcepto"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt">
					<fo:block>
						<xsl:value-of select="enero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm"   text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="febrero"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="marzo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" number-columns-spanned="3" border-start-width=".5pt" >
					<fo:block>
						<xsl:value-of select="abril"/>
					</fo:block>
				</fo:table-cell>
	

				
					
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="mayo"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" 
								number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="junio"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" padding-end=".1cm" text-align="end" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="julio"/>
					</fo:block>
				</fo:table-cell>
				
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="agosto"/>
					</fo:block>
				</fo:table-cell>
					<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="septiembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="octubre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="noviembre"/>
					</fo:block>
				</fo:table-cell>
								<fo:table-cell font-weight="bold"	padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="diciembre"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell 	font-weight="bold" padding-top=".05cm" padding-bottom=".05cm" text-align="end" padding-end=".1cm" border-start-width=".5pt" border-end-width=".5pt"
								 number-columns-spanned="3">
					<fo:block>
						<xsl:value-of select="total"/>
					</fo:block>
				</fo:table-cell>
				
				</xsl:if>
			
				
				
</xsl:template>

</xsl:stylesheet>


