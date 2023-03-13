<html>
<head>
	<link rel="stylesheet" type="text/css" href="ValidacionSueldo.css" />
	<script type="text/javascript" src="../js/jquery-1.6.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/dompurify/2.4.1/purify.min.js"></script>
</head>
<body>

	<script>
	
		$(document).ready(() => {
			$("#loader-div").hide();
			$("#div-table-historico").hide();
		})
			
			
		const handleClickBuscar = () => {
			var legajo = window.sessionStorage.getItem("legajo");
			$("#loader-div").show();
			$("td").remove();
			var fechaSimulacionDesde = $("#fechaDesde").val();
			fechaSimulacionDesde = formatDate(fechaSimulacionDesde);
			var fechaSimulacionHasta = $("#fechaHasta").val();
			fechaSimulacionHasta = formatDate(fechaSimulacionHasta);
			$.getJSON("<%=request.getContextPath()%>/crucesPresentismo?action=historico&pusuario=" + legajo + "&fec_simulacion_desde=" 
			+ fechaSimulacionDesde + "&fec_simulacion_hasta=" + fechaSimulacionHasta,(json) => {
        	$.each(json, (i, item) => {
					 var pos = parseInt(i) + parseInt(2);
					 console.log("la posicion final : " + pos);
                     $("#table-historico").append("<tr><td>"+item.id_solicitud+"</td><td>"+item.usuario_corpo_empleado+"</td><td>"+formatDate(item.fec_simulacion)+"</td><td><button><img class='pdf-icon' src='../images/pdf.png'/></button></td></tr>");
					 var boton = $("button")[pos];
					 $(boton).click(() => {handleClickPDF(item)});
				}); 
				$("td").css("background-color","white");
				$("#loader-div").hide();
				$("#div-table-historico").show();
			}).fail(() => {
				$("#loader-div").hide();
				alert("Error al obtener historico");
			})
		} 
		
		
		const handleClickLimpiar = () => {
			$("#fechaDesde").val("");
			$("#fechaHasta").val("");
			$("#td").remove();
			$("#div-table-historico").hide();
		}
		
		const getHtmlValoresAdicionales = (item) =>{
			var finalHtml = "";
			if(item.conformado !== "0" || item.complemento !== "0" || item.adic_falla !== "0"){
				if(item.conformado !== "0" && item.conformado !== "null"){
					finalHtml = finalHtml + "<h2 style='margin-top:15px'>Conformado te&oacute;rico: " +  setFormatValue(item.conformado) + "</h2>"
				}
				if(item.complemento !== "0" && item.complemento !== "null"){
					finalHtml = finalHtml + "<h2 style='margin-top:15px'>Complemento posici&oacute;n: " +  setFormatValue(item.complemento) + "</h2>"
				}
				if(item.adic_falla !== "0" && item.adic_falla !== "null"){
					finalHtml = finalHtml + "<h2 style='margin-top:15px'>Falla y funci&oacute;n: " +  setFormatValue(item.adic_falla) + "</h2>"
				}
				return finalHtml;	
			}else{
				return "";
			}
		}
		
		
		const handleClickPDF = (item) =>{
			//Generación del PDF
			
			window.jsPDF = window.jspdf.jsPDF;	
			var reporte = new jsPDF({format: [400,210]}); 

			var reportHTML = "<div style='background-color:#004481;height:100px;width:1200px'><div style='height:100%;display:flex;align-items:center'><img style='margin-left: 25px;height: 45px;width: 150px' src='../images/logobanco.png'><span style='color: white;font-size:25px;margin-top:10px;margin-left:20px'>SIRSYS</span></div><div style='width:1025px;padding-left:20px;padding-top:20px;padding-bottom:20px;border: 2px solid black'><h2>Fecha simulaci&oacute;n: " + formatDate(item.fec_simulacion) + "</h2><h2 style='margin-top:15px'>N&uacute;mero solicitud: " + item.id_solicitud + "</h2><h2 style='margin-top:15px'>Solicitante: " + item.usuario_corpo_super + " - " + item.apellido_nombre_super + "</h2><h1 style='text-decoration:underline;margin-left:400px;margin-top:35px'>Datos actuales</h1><h2 style='margin-top:30px'>Empleado: " + item.usuario_corpo_empleado + " - " + item.apellido_nombre_empleado + "</h2><h2 style='margin-top:15px'>Motivo del ajuste: "+ item.descripcion_motivo +"</h2><h2 style='margin-top:15px'>Job profile: " + item.id_job_profile + " - " + item.descripcion_puesto + "</h2><h2 style='margin-top:15px'>Supervisory: " + item.id_supervisory + " - " + item.descripcion_unidad +"</h2><h2 style='margin-top:15px'>Empresa: "+ item.id_empresa + " - " + item.descripcion_empresa +"</h2><h2 style='margin-top:15px'>Mapa de Talento: " +item.id_mapa_talento + "</h2><h2 style='margin-top:15px'>Potencial: " + item.potencial +  "</h2><h2 style='margin-top:15px'>Performance: "+ item.performance +"</h2><h2 style='margin-top:15px'>RTM: " + setFormatValue(item.rtm) + "</h2>"+ getHtmlValoresAdicionales(item)+"<h2 style='margin-top:15px'>Sueldo: " + setFormatValue(item.remuneracion_tot)+ "</h2><h2 style='margin-top:15px'>BT: " + setFormatValue(item.bt) +"</h2><h1 style='text-decoration:underline;margin-left:400px;margin-top:35px'>Datos nuevos</h1><h2 style='margin-top:30px'>Nuevo supervisory: " + item.id_supervisory_nueva + " - " + item.descripcion_unidad_nueva + "</h2><h2 style='margin-top:15px'>Nuevo JP: " + item.id_job_profile_nuevo + " - " + item.descripcion_puesto_nuevo +  "</h2><h2 style='margin-top:15px'>Nueva empresa:  " + item.id_empresa_nueva + " - " + item.descripcion_empresa_nueva + "</h2><h2 style='margin-top:15px'>Sueldo actual: " + setFormatValue(item.remuneracion_tot) + "</h2><h2 style='margin-top:15px'>Importe a ajustar: " + setFormatValue(item.importe_ajustar) + "</h2><h2 style='margin-top:15px'>Porcentaje a ajustar: " + item.porcentaje_ajustar + "</h2><h2 style='margin-top:15px'>Sueldo nuevo: " + setFormatValue(item.remuneracion_total_nueva) + "</h2><h2 style='margin-top:15px'>BT sugerido: " + setFormatValue(item.bono_sugerido) + "</h2><h2 style='margin-top:15px'>BT propuesto: " + setFormatValue(item.bt_propuesto) + "</h2><h2 style='margin-top:15px'>Posicionamiento: " + item.posicionamiento + "</h2></div></div>"
		
			reporte.html(reportHTML, {
				html2canvas: {
					scale:"0.2",
				},
				callback: function (reporte) {
					reporte.save("SIRSYSReport.pdf");
				}
			});
		}
			
		
		const formatDate = (date) => {
			if(date.includes("-")){
				date = date.split("-");
				var finalDate = date[2] + "/" + date[1] + "/" + date[0];
				return finalDate;
			}else{
				date = date.split(":");
				var splitDate = date[0].split("/");
				var finalDate = splitDate[1] + "/" + splitDate[0] + "/" + splitDate[2];
				finalDate = finalDate.substring(0,finalDate.length-2);
				return finalDate;	
			}
		}
		
		const setFormatValue = (value) =>{
			return new Intl.NumberFormat('es-AR', {
                currency: 'ARS', 
                style: 'currency', 
                maximumFractionDigits: 2, 
                minimumFractionDigits: 2
            }).format(value);
        }
		
		
	</script>
	
<div class="container">
	<jsp:include page="HeaderSirsys.jsp" >
	</jsp:include>
	<div id="loader-div">
        <div id="loader"></div>
    </div>
	<div class="content">
			<div class="sub-title-div">
                	<h2 class="sub-title">Hist&oacute;rico</h2>
                	<hr class="horizontal-line-subtitle">
            </div>
        	<div class="panel">
                <div class="inputs-div" style="justify-content: center">
					<div class="input-div" style="width:25%;margin-right:3em">
                        <label class="select-label" for="fechaSimulacion">Fecha desde</label>
                        <input class="select-style" type="date" name="fechaDesde" id="fechaDesde" style="outline:none">
                    </div>
					<div class="input-div" style="width:25%;margin-right:3em">
                        <label class="select-label" for="fechaSimulacion">Fecha hasta</label>
                        <input class="select-style" type="date" name="fechaDesde" id="fechaHasta" style="outline:none">
                    </div>
					<div style="display: flex; flex-direction: column; align-self: end;margin-right:1em">
						<button class="btn-search-icon" onclick="handleClickBuscar()">&#128270;</button>
					</div>
					<div style="display: flex; flex-direction: column; align-self: end;">
						<button class="btn-search-icon" onclick="handleClickLimpiar()">&#10060;</button>
					</div>
				</div>				
				<div id="div-table-historico" style="display: flex; flex-direction:column;padding: 2%;">
				<table id="table-historico" class="table-param bordered">
					<thead>
						<tr>
							<th>ID</th>
							<th>LEGAJO</th>
							<th>FECHA</th>
							<th>REPORTE</th>
						</tr>
					</thead>
					<tbody>		
					</tbody>
				</table>
			</div>
				
			</div>
	</div>	
</div>
</body>
		
</html>


