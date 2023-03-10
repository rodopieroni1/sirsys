<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <title>SIRSYS</title>
        <link rel="stylesheet" type="text/css" href="aumentoSueldo.css" />
		<script type="text/javascript" src="../js/jquery-1.6.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/dompurify/2.4.1/purify.min.js"></script>
		<!-- <script type="text/javascript" src="../js/jsPDF-master/dist/jspdf.umd.min.js"></script> -->
		<!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script> -->
		<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.4.1/jspdf.debug.js"></script> -->
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    </head>
<body>
	<script>
		// VARIABLES
		var btnSave = "<button name=btnSave onclick=handleClickEditar(event)>&#128190;</button>";
		var inputValor = "<input class=select-style type=text id= valorEdit >";
		var btnAll = "<div class=btn-div>"
							+"<button name=btnEditarPreParam onclick=handleClickEditar(event)>&#9998;</button>"
							+"<button name=Sumar onclick=handleClickSumar(event)>&plus;</button>"
							+"<button name=Replicar onclick=handleClickSumar(event)>R</button>"
						+"</div>";
		var btnEdit = "<div class=btn-div><button name=Editar onclick=handleClickEditar(event)>&#9998;</button></div>";
		var btnAddRow = "<div class=btn-div>"
						+"<button onclick=handleClickSaveRow(event)>&#128190;</button>"
						+"<button name=addRowBtn onclick=handleClickAddRowBtn(event)>&plus;</button>"
						//+"<button onclick=handleClickSubRowBtn(event)>&#10006;</button>"
						+"</div>";
		var btnSubs = "<button onclick=handleClickSubRowBtn(event)>&#10006;</button>";
		var optionsSelectAction = [];
		var tableValues = [
			{
				id:1,
				motivo:"promocion",
				validacion:"puesto y unidad",
				tabla:"usnidad",
				campo:"id_algo",
				fechaDesde:"11/01/2023",
				fechaHasta:"30/01/2023",
				valor:"JOPP"
			},
			{
				id:1,
				motivo:"promocion",
				validacion:"puesto y unidad",
				tabla:"usnidad",
				campo:"id_unidad",
				fechaDesde:"11/01/2023",
				fechaHasta:"30/01/2023",
				valor:"JO"
			},
			{
				id:1,
				motivo:"promocion",
				validacion:"puesto y unidad",
				tabla:"usnidad",
				campo:"id_campo",
				fechaDesde:"11/01/2023",
				fechaHasta:"30/01/2023",
				valor:"JOHH"
			},
			{
				id:2,
				motivo:"promocion",
				validacion:"puesto y unidad",
				tabla:"usnidad",
				campo:"campo",
				fechaDesde:"11/01/2023",
				fechaHasta:"30/01/2023",
				valor:"JOPP"
			},
			{
				id:2,
				motivo:"promocion",
				validacion:"puesto y unidad",
				tabla:"usnidad",
				campo:"campo",
				fechaDesde:"11/01/2023",
				fechaHasta:"30/01/2023",
				valor:"JOPP"
			},
			{
				id:3,
				motivo:"promocion",
				validacion:"puesto y unidad",
				tabla:"usnidad",
				campo:"campo",
				fechaDesde:"11/01/2023",
				fechaHasta:"30/01/2023",
				valor:"JOPP"
			},
		];
		
		const tablePos = [
			{
				id:1,
				mapa:9,
				potencial:3,
				minimo:3,
				maximo:5,
				tope_pc:"Si",
				tope_maximo:"Si",
				genero:6
			},
			{
				id:1,
				mapa:6,
				potencial:2,
				minimo:3,
				maximo:5,
				tope_pc:"No",
				tope_maximo:"Si",
				genero:3
			},
			{
				id:1,
				mapa:4,
				potencial:1,
				minimo:4,
				maximo:2,
				tope_pc:"No",
				tope_maximo:"No",
				genero:2
			},
		];
		// FIN VARIABLES
		
		// DOC. READY
		$(document).ready(() => {
			$("#modal-preparam").hide();
			$("#modal-posparam").hide();
			fillTable();
			fillPosParam();
			fillSelectMapaTalento();
			fillSelectPotencial();
			fillSelectTope();
			//Motivos
			$("#motivoAjuste").append("<option value='' disabled selected hidden></option>");
				$.getJSON("<%=request.getContextPath()%>/crucesPresentismo?action=motivos",(json) => {
					$.each(json,(i,item)=>{
					var resp= item.split("-");
					var option = "<option value=" + item + ">" + resp[1].trim() + "</option>"
					$("#motivoAjuste").append(option);  
				})
			});
		});
		// FIN DOC. READY

		const fillPosParam = () =>{
			var rowsPos =tablePos.map((row,i) =>{
				return(
						"<tr style='background-color: white';><td>"+ row.mapa +"</td>"
						+"<td>"+ row.potencial +"</td>"
						+"<td>"+ row.minimo +"</td>"
						+"<td>"+ row.maximo +"</td>"
						+"<td>"+ row.tope_pc +"</td>"
						+"<td>"+ row.tope_maximo +"</td>"
						+"<td>"+ row.genero +"</td>"
						+"<td>"
							+"<div class=btn-div>"
									+"<button class=btnTablePosParam name=btnEditarPosParam onclick=handleClickEditar(event)>&#9998;</button>"
									+"<button class=btnTablePosParam onclick=handleClickLimpiarRow(event)>&#10060;</button>"
							+"</div></td>"
						+"</tr>"
					);
			});
			$("#pos-param-table tbody").html("");
			rowsPos.forEach((row,i)=>{
				$("#pos-param-table tbody").append(row);
			})
		};
		const fillTable = () => {
			var id = 0;
			var rowBtn = "";
			var rowStyle = "";
			var rows = tableValues.map((row,i)=>{
				
				rowStyle = (row.id % 2 != 0) ? " style='background-color: aliceblue;'":" style='background-color: white;'";
				if (id !== row.id) {
					id = row.id;
					rowBtn = btnAll;
				}else{
					rowBtn = "";
				}
				return(
						"<tr"+ rowStyle +"><td>"+ row.id +"</td>"
						+"<td>"+ row.motivo +"</td>"
						+"<td>"+ row.validacion +"</td>"
						+"<td>"+ row.tabla +"</td>"
						+"<td>"+ row.campo +"</td>"
						+"<td>"+ row.fechaDesde +"</td>"
						+"<td>"+ row.fechaHasta +"</td>"
						+"<td>"+ row.valor +"</td>"
						+"<td>"+rowBtn+"</td>"
						+"</tr>"
					);
			});
			$("#pre-param-table tbody").html("");
			rows.forEach((row,i)=>{
				$("#pre-param-table tbody").append(row);
			})
		};
		// PREPARAM
		// panel preparam
		const handleClickBuscar = () => {
			$.getJSON("<%=request.getContextPath()%>/crucesPresentismo?action=parametriaf&motivo=PRO&fec_validacion_desde=31/12/2022&fec_validacion_hasta=31/12/2022",(json) => {
			var id = 0;
			var rowBtn = "";
			var rowStyle = "";
			var rows = $.map(json, (row, i) => {
				rowStyle = (row.id_par_valida % 2 != 0) ? " style='background-color: aliceblue;'":" style='background-color: white;'";
				if (id !== row.id_par_valida) {
					id = row.id_par_valida;
					rowBtn = btnAll;
				}/*else{
					rowBtn = btnEdit;
				}*/
				return(
						"<tr"+ rowStyle +"><td>"+ row.id_par_valida +"</td>"
						+"<td>"+ row.descripcion_motivo +"</td>"
						+"<td>"+ row.descripcion_validacion +"</td>"
						+"<td>"+ row.tabla +"</td>"
						+"<td>"+ row.campo +"</td>"
						+"<td>"+ row.fecha_inicio +"</td>"
						+"<td>"+ row.fecha_fin +"</td>"
						+"<td>"+ row.valor +"</td>"
						+"<td>"+rowBtn+"</td>"
						+"</tr>"
					);
            	});
				$("#pre-param-table tbody").html("");
				rows.forEach((row,i)=>{
				$("#pre-param-table tbody").append(row);
			})         
        });
		};
		// funcion sumar
		const handleClickSumar = (e) => {
			var tableBody = [];
			optionsSelectAction.length = 0;
			var id = $(e.currentTarget).closest("tr").find("td").eq(0).html();
			var rowSelected = $(e.currentTarget).closest("tr");
			tableBody = fillModalTable(id);
			tableBody.forEach((row,i) =>{
				$("#modal-param-table tbody").append(row);
			});
			handleClickAddRowBtn(e);
			$("#modalTitle").html(e.currentTarget.name);
			$("#fecha_inicio_pre").hide();
			$("#fecha_fin_pre").hide();
			$("#modal-preparam").show();
		};

		const handleClickCleanPanelPreParam = () => {
			$("#pre-param-table tbody").html("");
			$("#fecha_inicio_pre").val("");
			$("#fecha_fin_pre").val("");
			$("#motivoAjuste").val("");
		};
		const editarPreParam = (e) => {
			var tableBody = [];
			var fechaHoy = "30/01/2023";
			var vencido = ($(e.currentTarget).closest("tr").find("td").eq(6).html() <= fechaHoy)? true : false;
			var id = $(e.currentTarget).closest("tr").find("td").eq(0).html();
			var addRow = fillModalTable(id);
			addRow.forEach((row,i) =>{
				$("#modal-param-table tbody").append(row);
				// si esta vencido permite editar el bloque
				if (vencido) {
					var value = $("#modal-param-table tbody tr:last").find("td").eq(7).html();
					$("#modal-param-table tbody tr:last").find("td")
						.eq(7).html("<input class=select-style type=text id= valorEdit value="+value+" >");
				}else {
					$("#modal-param-table tbody tr:last td:last").html("<div class=btn-div>"
						+"<button name=Editar onclick=handleClickEditRowModal(event)>&#9998;</button></div>"
					);
				}
			});
			if (!vencido) {
				$("#modalTitle").html("Editar");
			}else{
				$("#modal-param-table tbody tr:last td:last").append(btnSave);
				$("#modalTitle").html("Editar Bloque");
			}
			$("#fecha_inicio_pre").hide();
			$("#fecha_fin_pre").hide();
			$("#modal-preparam").show();
		};

		/*
			 funciones modal preparam
		*/
		
		// armo la tabla del modal segun accion
		const fillModalTable = (id) => {
			var addArray = [];
			$("#modal-param-table tbody").html("");
			$("#pre-param-table tbody tr").each((i,item)=>{
				if (item.cells[0].innerText === id) {
					optionsSelectAction.push(item.cells[4].innerHTML);
					var newTr = "<tr><td>"+ item.cells[0].innerHTML +"</td>"
						+"<td>"+ item.cells[1].innerHTML +"</td>"
						+"<td>"+ item.cells[2].innerHTML +"</td>"
						+"<td>"+ item.cells[3].innerHTML +"</td>"
						+"<td>"+ item.cells[4].innerHTML +"</td>"
						+"<td>"+ item.cells[5].innerHTML +"</td>"
						+"<td>"+ item.cells[6].innerHTML +"</td>"
						+"<td>"+ item.cells[7].innerHTML +"</td>"
						+"<td></td>"
						+"</tr>";
					addArray.push(newTr);
				}
			});
			return addArray;
		};
		
		// Agrego la fila con botones segun accion
		const handleClickAddRowBtn = (e) => {
			var rowSelected = $(e.currentTarget).closest("tr");
			// armo combo por los multiples valores de las row
			selectAction = "<select class=select-style name=selectAction id=slc_action>";
			optionsSelectAction.forEach((option,i) =>{
				selectAction += "<option>"+option+"</option>";
			});
			selectAction += "</select>";

			var addRow = "<tr name=editRow><td>"+ rowSelected[0].cells[0].innerHTML +"</td>"
						+"<td>"+ rowSelected[0].cells[1].innerHTML +"</td>"
						+"<td>"+ rowSelected[0].cells[2].innerHTML +"</td>"
						+"<td>"+ rowSelected[0].cells[3].innerHTML +"</td>"
						+"<td>"+ selectAction +"</td>"
						+"<td>"+ rowSelected[0].cells[5].innerHTML +"</td>"
						+"<td>"+ rowSelected[0].cells[6].innerHTML +"</td>"
						+"<td>"+ inputValor +"</td>"
						+"<td>"+btnAddRow+"</td>"
						+"</tr>";
			$("#modal-param-table tbody tr:last td:last").html("");

			if ($("#modal-param-table tbody tr:last").attr('name') === "editRow") {
				$("#modal-param-table tbody tr:last td:last").append(btnSubs);
			}
			$("#modal-param-table tbody").append(addRow);			
			// si la accion es replicar, se pueden editar las fechas
			if (e.currentTarget.name === "Replicar") {
				$("#modal-param-table tbody tr:last").find("td").eq(5).html("<input class=select-style type=date name=fecha>");
				$("#modal-param-table tbody tr:last").find("td").eq(6).html("<input class=select-style type=date name=fecha>");
			}
		};
		
		// eliminar row de tabla modal
		const handleClickSubRowBtn = (e) => {
			if ($("#modal-param-table tbody tr:last").attr('name') === "editRow") {
				$(e.currentTarget).closest("tr").remove();
				$("#modal-param-table tbody tr:last td:last").html("");
				$("#modal-param-table tbody tr:last td:last").append(btnAddRow);
			}	
		};

		const handleClickEditRowModal = (e) => {
			var row = $(e.currentTarget).closest("tr").find("td");
			row.eq(8).find("div").append(btnSave + "<button name=btnLimpiarRow onclick=handleClickLimpiarRow(event)>&#10060;</button>");
			row[7].innerHTML = "<input class=select-style type=text id= valorEdit value="+row[7].innerHTML+" >";
		};

		const handleClickLimpiarRow = (e) => {
			var row = $(e.currentTarget).closest("tr").find("td");
			row.eq(8).find("div button:last").remove();
			row.eq(8).find("div button:last").remove();
			var inputValue = row.eq(7).find("input").val();
			row.eq(7).find("input").remove();
			row.eq(7).html(inputValue);
		};

		const handleClickCancelar = () => {
			$("#modal-preparam").hide();
			$("#modal-posparam").hide();
			$("#fecha_inicio_pre").show();
			$("#fecha_fin_pre").show();
			$(".btnTablePosParam").prop('disabled', false);

		};
		/*
			fin funciones modal preparam
			FIN PREPARAM
		*/				
		// POSPARAM
		const fillSelectTope = () => {
			var option = "<option value=1>Si</option>"
			+"<option value=0>No</option>";
			$("#slc_tope_pc").append(option);
			$("#slc_tope_maximo").append(option);
		};
		const fillSelectMapaTalento = () =>{
			for (let i = 1; i < 10; i++) {
				$("#slc_mapa_talento").append("<option value="+i+">"+i+"</option>");
				$("#mapa_de_talento_filter").append("<option value="+i+">"+i+"</option>");
			}
		};
		const fillSelectPotencial = () =>{
			for (let i = 1; i < 4; i++) {
				$("#slc_potencial").append("<option value="+i+">"+i+"</option>");
				$("#potencial_filter").append("<option value="+i+">"+i+"</option>");
			}
		};
		const cleanModalInputs = () => {
			$("#slc_mapa_talento").val(1).change();
			$("#slc_potencial").val(1).change();
			$("#input_minimo").val(0);
			$("#input_maximo").val(0);
			$("#slc_tope_pc").val(1).change();
			$("#slc_tope_maximo").val(1).change();
			$("#input_genero").val(0);
		};
		const editarPosParam = (e) => {
			row = $(e.currentTarget).closest("tr");
			$("#slc_mapa_talento").val(row.find("td").eq(0).html());
			$("#slc_potencial").val(row.find("td").eq(1).html());
			$("#input_minimo").val(row.find("td").eq(2).html());
			$("#input_maximo").val(row.find("td").eq(3).html());
			$("#slc_tope_pc").val((row.find("td").eq(4).html()==="SI"?1:0)).change();
			$("#slc_tope_maximo").val((row.find("td").eq(5).html()==="SI"?1:0)).change();
			$("#input_genero").val(row.find("td").eq(6).html());
			
			$(".btnTablePosParam").prop('disabled', true);
			$("#slc_mapa_talento").prop('disabled', true);
			$("#slc_potencial").prop('disabled', true);
			$("#modalTitle").html("Editar");
			$("#panel-preparam").css("display","none");

			$("#modal-posparam").show();
			$("#input_minimo").focus();
		};

		const handleClickNuevoPosParam = () => {
			cleanModalInputs();
			$(".btnTablePosParam").prop('disabled', true);
			$("#slc_mapa_talento").prop('disabled', false);
			$("#slc_potencial").prop('disabled', false);
			$("#modalTitle").html("Nuevo");
			$("#modal-posparam").show();
		};
		// FIN POSPARAM
		const handleClickDivBtn = (e) => {
			var id = e.currentTarget.id;
			if(id === "btn-preparam"){
				ocultarPanel("#panel-preparam",$("#panel-preparam").css("display"));
			}else{
				ocultarPanel("#panel-posparam",$("#panel-posparam").css("display"));
			}
		};

		const ocultarPanel = (panel, style) => {
			if (style === "flex") {
				$(panel).css("transition","opacity 2s lenear");
				$(panel).css("display","none");
			}else{
				$(panel).css("display","flex")
			}
		};

		const handleClickEditar = (e) => {
			if (e.originalTarget.name === "btnEditarPosParam") {
				editarPosParam(e);
			} 
			if(e.originalTarget.name === "btnEditarPreParam") {
				editarPreParam(e);
			}
		}

	</script>
	<!--PREPARAM-->
	<div id="modal-preparam" class="modal-validar">
		<div class="modal-validar-content">
			<div class="container">
				<h2 id="modalTitle" class="sub-title"></h2>
			</div>
			<div style="display: flex; flex-direction:column;padding: 2%;">
				<table id="modal-param-table" class="table-param bordered">
					<thead>
						<tr>
							<th>ID</th>
							<th>MOTIVO</th>
							<th>VALIDACI&Oacute;N</th>
							<th>TABLA</th>
							<th>CAMPO</th>
							<th>FECHA INICIO</th>
							<th>FECHA FIN</th>
							<th>VALOR</th>
							<th></th>
						</tr>
					</thead>
					<tbody>		
					</tbody>
				</table>
			</div>
			<div class="modal-input-row">
                <div class="modal-div-btn">
                    <button class="cancelar-button" onclick= "handleClickCancelar()">Volver</button>
                </div>
			</div>
		</div>
	</div>
	<!--POSPARAM-->
	<div id="modal-posparam" class="modal-validar">
		<div class="modal-validar-content">
			<div class="container">
				<h2 id="modalTitle" class="sub-title"></h2>
			</div>
			<div class="inputs-div">
				<div class="motivo-div">
					<label class="select-label" for="mapaTalento">* Mapa de talento</label>
					<select class="select-style" id="slc_mapa_talento" name="mapaTalento" disabled></select>
				</div>
				<div class="motivo-div">
					<label class="select-label" for="potencial">* Potencial</label>
					<select class="select-style" id="slc_potencial" name="potencial" disabled></select>
				</div>
			</div>
			<div class="inputs-div">
				<div class="motivo-div">
					<label class="select-label" for="minimo">* % M&iacute;nimo</label>
					<input class="select-style" type="text" id="input_minimo" name="minino"/>
				</div>
				<div class="motivo-div">
					<label class="select-label" for="maximo">* % M&aacute;ximo</label>
					<input class="select-style" type="text" id="input_maximo" name="maximo"/>
				</div>
				<div class="motivo-div">
					<label class="select-label" for="topePc">* Tope PC</label>
					<select class="select-style" id="slc_tope_pc" name="topePc"></select>
				</div>
			</div>
			<div class="inputs-div">
				<div class="motivo-div">
					<label class="select-label" for="topeMaximo">* Tope m&aacute;ximo</label>
					<select class="select-style" id="slc_tope_maximo" name="topeMaximo"></select>
				</div>
				<div class="motivo-div">
					<label class="select-label" for="genero">* % Por g&eacute;nero</label>
					<input class="select-style" type="text" id="input_genero" name="genero"/>
				</div>
				<div class="motivo-div">
					<label class="select-label" for="multi">* Multiselect</label>
					<select class="select-style" onchange="handleChangeMotivo()" name="Motivo" id="definir">
					</select>
				</div>
			</div>
			<div class="modal-input-row">
				<div class="validar-button-div" id="validar-button-div2">
					<button onclick="handleClickNuevoPosParam()" class="validar-button">Guardar &#128190;</button>
				</div>
                <div class="modal-div-btn">
                    <button class="cancelar-button" onclick= "handleClickCancelar()">Volver</button>
                </div>
			</div>
		</div>
		
	</div>
	<!---->
	<div class="container">
		<jsp:include page="HeaderSirsys.jsp" >
		</jsp:include>
		<div class="content">
			<div class="btn-div-desplegar" id="btn-preparam" onclick="handleClickDivBtn(event)">
				<div class="accordion-card">
					<h5 class="h5-desplegar">PRE PARAM</h5>
					<span class="jp-arrow" style="align-self: center;">&#9660;</span>
					<span class="jp-arrow" style="align-self: center; display: none;">&#9650;</span>
				</div>
			</div>			
			<div id="panel-preparam" class="panel" style="margin: 1% 0; display: none;">
				<div class="inputs-div">
					<div class="motivo-div">
						<label class="select-label" for="motivoAjuste">* Motivo</label>
						<select class="select-style" onchange="handleChangeMotivo()" name="Motivo" id="motivoAjuste">
						</select>
					</div>
					<div class="fecha-div">
						<label class="select-label" for="fechaInicio">Fecha Inicio</label>
						<input class="select-style" type="date" name="fechaInicioPre" id="fecha_inicio_pre">
					</div>
					<div class="fecha-div">
						<label class="select-label" for="fechaFin">Fecha Fin</label>
						<input class="select-style" type="date" name="fechaFinPre" id="fecha_fin_pre">
					</div>
					<div style="display: flex; flex-direction: column; align-self: end;">
                    	<button class="btn-search-icon" onclick="handleClickBuscar()">&#128270;</button>
	                </div>
					<div style="display: flex; flex-direction: column; align-self: end;">
                    	<button class="btn-search-icon" onclick="handleClickCleanPanelPreParam()">&#10060;</button>
	                </div>
				</div>
				<div style="display: flex; flex-direction:column;">
					<table id="pre-param-table" class="table-param bordered">
						<thead>
							<tr>
								<th>ID</th>
								<th>MOTIVO</th>
								<th>VALIDACI&Oacute;N</th>
								<th>TABLA</th>
								<th>CAMPO</th>
								<th>FECHA DESDE</th>
								<th>FECHA HASTA</th>
								<th>VALOR</th>
								<th></th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>

			</div>
			<div id="btn-posparam" class="btn-div-desplegar" onclick=handleClickDivBtn(event)>
				<div class="accordion-card">
					<h5 class="h5-desplegar">POS PARAM</h5>
					<span class="jp-arrow" style="align-self: center;">&#9660;</span>
					<span class="jp-arrow" style="align-self: center; display: none;">&#9650;</span>
				</div>
			</div>
			<div id="panel-posparam" class="panel" style="margin: 1% 0; display: none;">
				<div class="inputs-div">
					<div class="motivo-div">
						<label class="select-label" for="mapaTalento">* Mapa de talento</label>
						<select class="select-style" onchange="handleChangeMotivo()" name="mapaDeTalentoFilter" id="mapa_de_talento_filter">
						</select>
					</div>
					<div class="motivo-div">
						<label class="select-label" for="fechaSimulacion">* Potencial</label>
						<select class="select-style" onchange="handleChangeMotivo()" name="potencialFilter" id="potencial_filter"></select>
					</div>
					<div style="display: flex; width: 10%; flex-direction: row; justify-content: space-around;">
						<div style="display: flex; flex-direction: column; align-self: end;">
							<button class="btn-search-icon" onclick="handleClickBuscar()">&#128270;</button>
						</div>
						<div style="display: flex; flex-direction: column; align-self: end;">
							<button class="btn-search-icon" onclick="handleClickCleanPanelPreParam()">&#10060;</button>
						</div>
					</div>
				</div>
				<table id="pos-param-table" class="table-param bordered">
					<thead>
						<tr>
							<th>MAPA DE TALENTO</th>
							<th>POTENCIAL</th>
							<th>% M&Iacute;NIMO</th>
							<th>M&Aacute;XIMO</th>
							<th>TOPE PC</th>
							<th>TOPE M&Aacute;XIMO</th>
							<th>% POR G&Eacute;NERO</th>
							<th></th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
				<div class="button-div">
					<div class="validar-button-div" id="validar-button-div2">
						<button onclick="handleClickNuevoPosParam()" class="validar-button">Nuevo</button>
					</div>
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>