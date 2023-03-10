<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="gral.*" %>
<%@ page import="rhgral.present.*" %>
<%@ page import="rhgral.bizlayer.*" %>
<%@ page import="rhgral.valueobj.*" %>
<%@ page import="org.apache.commons.logging.Log" %>
<%@ page import="org.apache.commons.logging.LogFactory" %>
<%@ page import="ar.com.itrsa.sam.IContext" %>
<%@ page import="ar.com.itrsa.sam.IServiceAccessManager" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html>



<%!
	public  static final String 	LOG_CATEGORY_PREFIX = "web.jsp.";
	private static       Log		log = null;

	public ServletContext getApplication()
	{
		return this.getServletConfig().getServletContext();
	}

	public IServiceAccessManager getSam() 
	{
		return (IServiceAccessManager) getApplication().getAttribute(ar.com.bbva.utils.IConstants.SAM);
	}
	public	IContext	getSamContext(String szId) 
	{
		IServiceAccessManager	sam = getSam();
		IContext		samctx = (IContext) getApplication().getAttribute(ar.com.bbva.utils.IConstants.SAM_CONTEXT);
		Map 			cxtParams = null;
	
		log.info("getSamContext para id=" + szId + " sam:" + sam);
		if (sam != null && samctx == null) {
			log.info("Creando un contexto SAM para: " + szId);	
			cxtParams = new HashMap();
			try {
				samctx = sam.getContextManager().createContext(szId, cxtParams);
			} catch (Throwable _) {}
		}	
		return samctx;
	}
%>
<%

	log = LogFactory.getLog(LOG_CATEGORY_PREFIX + request.getRequestURI());

	IServiceAccessManager	samAux = getSam();
	IContext 				contextSAM = getSamContext(session.getId());
	
	if (samAux == null || contextSAM == null)
		throw new Exception("Algun objeto nulo: sam o samContext");
	
	SAMConnection.setSamContext(contextSAM);
	//session.setAttribute("contextSAM",contextSAM);
%>
<%
   String userId = request.getHeader( "IV-USER" ); 

    String password = null;
	RhGralSessAdmIngresos ai = new RhGralSessAdmIngresos();


// Validar Legajo, obtener datos del usuario y cargarlos en HttpSession
	RhGralSessAdmLegajos al = new RhGralSessAdmLegajos();
	RhGralLegajo legajo = new RhGralLegajo();
	String numeroLegajo = RutinasFormatos.legajoFormateado(new String(userId));

	legajo.setUsrId(userId.toUpperCase());
	legajo.setNumeroLegajo ( numeroLegajo );
    try {
		al.obtenerLegajo ( legajo );
	}
	catch ( Exception me ) {
	      System.out.println("Error en RhGralSessAdmLegajos.obtenerLegajo: " + me.toString());
		%><jsp:forward page="RhGralHtmlMensaje.jsp">
			<jsp:param name="OPCION" value="2"/>
			<jsp:param name="MENSAJE" value="<%= me.getMessage() %>" />
		</jsp:forward><%
	}
	// invalida session anterior y crea nueva
	session.invalidate();
	session = request.getSession(true);
	RhGralAppSessionContext asc = new RhGralAppSessionContext();
	try {
		asc.setUsuario ( session, userId.toUpperCase()  );
		asc.setLegajo (  session, legajo );
		asc.setLogin ( session );
		asc.setEmpresaDefault ( session, legajo.getIdEmpresa() );
		asc.setEmpresaEstructura ( session, "00" );
				
				
		asc.setGrupoLiquidacion ( session, legajo.getGrupoLiquidacion() );
		System.out.println(" legajo.getGrupoLiquidacion(); "+ legajo.getGrupoLiquidacion());
				
	
	}
	catch ( Exception me ) {
		out.println ( "Error al establecer la sesion del usuario - " +
		me.getMessage() );
		return;
	}

	RutinasSeguridad.generarClave ( session );
    String xyz = URLEncoder.encode ( RutinasSeguridad.encrypt ( (new Date()).toString(), session ));
%>

    <head>
        <title>SIRSYS</title>
        <link rel="stylesheet" type="text/css" href="ValidacionSueldo.css" />
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

    var reportesFuente = [];
     
	var reportesVariable = [];

	var supervisoryFuente = [];
	
	var supervisoryVariable = [];
	
	var empresaFuente = [];
	
	var nuevoJPFuente = [];

    var nuevoJPVariable = [];

	var validacionesIncumplidas = [];
	
	var validacionAjusteIncumplida = "";
	
	var idSolicitud = 0;
	
	var actualJP = "";
	
	var actualSupervisory="";
	
	var actualEmpresa = "";
	
	var actualRTM = 0;
	
	var actualConformado = 0;
	
	var actualComplemento = 0;
	
	var actualFalla = 0;
	
	var actualBT = 0;
	
	var actualMapaTalento = 0;
	
	var actualPerformance = 0;

	var actualPotencial = 0;
	
	var btSugerido = 0;


	

        $(document).ready(() => {
			window.sessionStorage.setItem("legajo","<%= legajo.getUsrId() %>");
			window.sessionStorage.setItem("apellidoNombre", "<%= legajo.getApellidoYNombre() %>");
	        $(document).click((e) => {
                	var container = $("#reporte-div");
                	if (!container.is(e.target) && container.has(e.target).length === 0){
                    		$("#search-content-reportes").hide();
                    		$("#reporte").css("border-radius","8px 0px 0px 8px");
                    		$("#search-button-reportes").css("border-radius","0px 8px 8px 0px");
                    		$("#search-div-reportes").css("border-radius","8px");
                	}
					container = $("#supervisory-div");
                    if (!container.is(e.target) && container.has(e.target).length === 0){
                    		$("#search-content-supervisory").hide();
                    		$("#supervisory").css("border-radius","8px 0px 0px 8px");
                    		$("#search-button-supervisory").css("border-radius","0px 8px 8px 0px");
                    		$("#search-div-supervisory").css("border-radius","8px");
                	}
					container = $("#nuevoJP-div");
                    if (!container.is(e.target) && container.has(e.target).length === 0){
                    		$("#search-content-nuevoJP").hide();
                    		$("#nuevoJP").css("border-radius","8px 0px 0px 8px");
                    		$("#search-button-nuevoJP").css("border-radius","0px 8px 8px 0px");
                    		$("#search-div-nuevoJP").css("border-radius","8px");
                	}
					
            	});
				$("#loader-div").show();
				$("#validar-button-1").css("visibility","hidden");
				$("#cancelar-panel1").css("visibility","hidden");
				getDatos();
            	$("#search-content-reportes").hide();
            	$("#reporte").css("border-radius","8px 0px 0px 8px");
            	$("#search-button-reportes").css("border-radius","0px 8px 8px 0px");
            	$("#search-div-reportes").css("border-radius","8px");
				$("#search-content-supervisory").hide();
				$("#search-content-nuevoJP").hide();
            	$("#modal-validar").hide();
            	$(".jp-div").hide();
            	$("#subtitle-propuesta").hide();
            	$("#propuesta-panel").hide();
				$(".finalizar-div").hide();
				$(".validacion-ajuste-div").hide();
        })
        var esElegible = true;

    const getDatos = () => {

        // Reportes
        $("#search-content-reportes").append("<ul class='lista' id='lista-reportes'></ul>");
		
		$.ajax({
			contentType: 'application/json',
			data: JSON.stringify({"usuarioCorpo": "<%=legajo.getUsrId()%>"}),
			dataType: 'json',
			success: function(json){
				$.each(json, (i, item) => {
                     reportesFuente.push(item);
				});            
			},
			error: function(){
				alert("Ha ocurrido un error al obtener los reportes");
			},
			type: 'POST',
			url: "<%=request.getContextPath()%>/crucesPresentismo?action=reportes"
		});
	

        //Motivos
	$("#motivoAjuste").append("<option value='' disabled selected hidden></option>");
        $.getJSON("<%=request.getContextPath()%>/crucesPresentismo?action=motivos",(json) => {
            $.each(json,(i,item)=>{
        	var resp= item.split("-");
        	var option = "<option value=" + item + ">" + resp[1].trim() + "</option>"
        	$("#motivoAjuste").append(option);  
            })
        });


        //NuevoJP
        $("#search-content-nuevoJP").append("<ul class='lista' id='lista-nuevoJP'></ul>");
		$.ajax({
			contentType: 'application/json',
			data: JSON.stringify({"pusuario": "<%=legajo.getUsrId()%>"}),
			dataType: 'json',
			success: function(json){
				$.each(json, (i, item) => {
                     nuevoJPFuente.push(item);
				});     				
			},
			error: function(){
				alert("Ha ocurrido un error al obtener los job profiles");
			},
			complete: function(){
				$("#loader-div").hide();
			},
			type: 'POST',
			url: "<%=request.getContextPath()%>/crucesPresentismo?action=jp"
		});

        //Supervisory
        $("#search-content-supervisory").append("<ul class='lista' id='lista-supervisory'></ul>");
       	$.getJSON("<%=request.getContextPath()%>/crucesPresentismo?action=supervisory",(json) => {
        	$.each(json, (i, item) => {
                     supervisoryFuente.push(item);
            });            
        });


        //Empresa
		$("#empresa").append("<option value='' disabled selected hidden></option>");
        $.getJSON("<%=request.getContextPath()%>/crucesPresentismo?action=empresa",(json) => {
            $.each(json, (i, item) => {
				empresaFuente.push(item);
				var resp= item.split("-");
				var option = "<option>" + resp[1].trim() + "</option>"
                $("#empresa").append(option);
            });
        });
    }
	
	
	const handleChangeMotivo = () => {
		$("#motivoAjuste").css("border-color","gray");
	}


 	 const handleInput = (event) => {
		 
        var id = event.target.id;
		
        if(id === "reporte"){
                reportesVariable = [];
                if ($("#reporte").val() === "") {
                    $("#lista-reportes").html("");
                    $.each(reportesFuente,(i,item) => {
                        const li = "<li class='lista-element' onclick='handleClickOption(event)'>"+item+"</li>";
                        $("#lista-reportes").append(li);
                    });
                    $("#reporte").css("border-radius","8px 0px 0px 0px");
                    $("#search-button-reportes").css("border-radius","0px 8px 0px 0px");
                    $("#search-div-reportes").css("border-radius","8px 8px 0px 0px");
                    $("#search-content-reportes").show();

            } else {
                $.each(reportesFuente, (i, item) => {
                    if ((item.toLowerCase()).includes(($("#reporte").val()).toLowerCase())) {
                        reportesVariable.push(item);
                    }
                });
                $("#lista-reportes").html("");
		        if(reportesVariable.length !== 0){
                	$.each(reportesVariable, (i, item) => {
                    		const li = "<li class='lista-element' onclick='handleClickOption(event)'>" + item + "</li>";
                    		$("#lista-reportes").append(li);
                	    });
		        }else{
		            const li = "<li class='lista-element'>" + 'No se han encontrado resultados ...' + "</li>"
               	    $("#lista-reportes").append(li);
		        }
                $("#reporte").css("border-radius","8px 0px 0px 0px");
                $("#search-button-reportes").css("border-radius","0px 8px 0px 0px");
                $("#search-div-reportes").css("border-radius","8px 8px 0px 0px");
                $("#search-content-reportes").show();
            }
            
        }
		
		        if(id === "supervisory"){
                supervisoryVariable = [];
                if ($("#supervisory").val() === "") {
                    $("#lista-supervisory").html("");
                    $.each(supervisoryFuente,(i,item) => {
                        const li = "<li class='lista-element' onclick='handleClickOption(event)'>"+item+"</li>";
                        $("#lista-supervisory").append(li);
                    });
                    $("#supervisory").css("border-radius","8px 0px 0px 0px");
                    $("#search-button-supervisory").css("border-radius","0px 8px 0px 0px");
                    $("#search-div-supervisory").css("border-radius","8px 8px 0px 0px");
                    $("#search-content-supervisory").show();

            } else {
                $.each(supervisoryFuente, (i, item) => {
                    if ((item.toLowerCase()).includes(($("#supervisory").val()).toLowerCase())) {
                        supervisoryVariable.push(item);
                    }
                });
                $("#lista-supervisory").html("");
		        if(supervisoryVariable.length !== 0){
                	$.each(supervisoryVariable, (i, item) => {
                    		const li = "<li class='lista-element' onclick='handleClickOption(event)'>" + item + "</li>";
                    		$("#lista-supervisory").append(li);
                	    });
		        }else{
		            const li = "<li class='lista-element'>" + 'No se han encontrado resultados ...' + "</li>";
               	    $("#lista-supervisory").append(li);
		        }
                $("#supervisory").css("border-radius","8px 0px 0px 0px");
                $("#search-button-supervisory").css("border-radius","0px 8px 0px 0px");
                $("#search-div-supervisory").css("border-radius","8px 8px 0px 0px");
                $("#search-content-supervisory").show();
            }
            

        }
		
		        if(id === "nuevoJP"){
                nuevoJPVariable = [];
                if ($("#nuevoJP").val() === "") {
                    $("#lista-nuevoJP").html("");
                    $.each(nuevoJPFuente,(i,item) => {
                        const li = "<li class='lista-element' onclick='handleClickOption(event)'>"+item+"</li>";
                        $("#lista-nuevoJP").append(li);
                    });
                    $("#nuevoJP").css("border-radius","8px 0px 0px 0px");
                    $("#search-button-nuevoJP").css("border-radius","0px 8px 0px 0px");
                    $("#search-div-nuevoJP").css("border-radius","8px 8px 0px 0px");
                    $("#search-content-nuevoJP").show();

            } else {
                $.each(nuevoJPFuente, (i, item) => {
                    if ((item.toLowerCase()).includes(($("#nuevoJP").val()).toLowerCase())) {
                        nuevoJPVariable.push(item);
                    }
                });
                $("#lista-nuevoJP").html("");
		        if(nuevoJPVariable.length !== 0){
                	$.each(nuevoJPVariable, (i, item) => {
                    		const li = "<li class='lista-element' onclick='handleClickOption(event)'>" + item + "</li>";
                    		$("#lista-nuevoJP").append(li);
                	    });
		        }else{
		            const li = "<li class='lista-element'>" + 'No se han encontrado resultados ...' + "</li>"
               	    $("#lista-nuevoJP").append(li);
		        }
                $("#nuevoJP").css("border-radius","8px 0px 0px 0px");
                $("#search-button-nuevoJP").css("border-radius","0px 8px 0px 0px");
                $("#search-div-nuevoJP").css("border-radius","8px 8px 0px 0px");
                $("#search-content-nuevoJP").show();
            }


		}
	}	




const handleClickOption = (event) =>  {
    var id = event.target.parentNode.id;

    if(id === "lista-reportes"){
        $("#hd-conf").remove();
	    $("#conf").remove();
	    $("#hd-pos").remove();
	    $("#pos").remove();
	    $("#hd-fall").remove();
	    $("#fall").remove();
	
	    $("td").each((i, item) => {
		    item.innerHTML = 0;
	    })
	    $("#info-job-profile").html("Job Profile: ");
        $("#info-supervisory").html("Supervisory: ");
        $("#info-empresa").html("Empresa: ");
        $("#info-mapa-talento").html("Mapa de Talento: ");
        $("#info-potencial").html("Potencial: ");
        $("#info-performance").html("Performance: ");
		
		$("#supervisory").val("");
		$("#nuevoJP").val("");
		$("#empresa").val("");


		$("#loader-div").show();
		$("body").css("overflow", "hidden");
	    setTimeout(() => {
		    var reporteLegajo = ($("#reporte").val()).split("-");
		    var sueldoActual = 0;
			var sueldoFuturo = 0;
			
			
		    $.ajax({
			contentType: 'application/json',
			data: JSON.stringify({"usuarioCorpo": reporteLegajo[0].trim()}),
			dataType: 'json',
			success: function(json){
				actualRTM = json.rtm;
			    $("#rtm").html(setFormatValue(json.rtm));
				$("#rtm_propuesto").html(setFormatValue(json.rtm));
				
			    sueldoActual = sueldoActual + parseFloat(json.rtm);
				sueldoFuturo = sueldoFuturo + parseFloat(json.rtm);
			
			    if(json.adic_falla !== "0"){
					actualFalla = json.adic_falla;
				    $("<th id='hd-fall'>Falla y Funci&oacuten</th>").insertAfter("#hd-rtm");
				    $("<td id='fall'>" + setFormatValue(json.adic_falla) + "</td>").insertAfter("#rtm");
				    sueldoActual = sueldoActual + parseFloat(json.adic_falla);
					
					$("<th id='hd-fall_propuesto'>Falla y Funci&oacuten</th>").insertAfter("#hd_rtm_propuesto");
				    $("<td id='fall_propuesto'>" + setFormatValue(json.adic_falla) + "</td>").insertAfter("#rtm_propuesto");
					sueldoFuturo = sueldoFuturo + parseFloat(json.adic_falla);
			    }
			    if(json.comp_pos !== "0"){
					actualComplemento = json.comp_pos;
				    $("<th id='hd-pos'>Comp. Posici&oacuten</th>").insertAfter("#hd-rtm");
				    $("<td id='pos'>" + setFormatValue(json.comp_pos) + "</td>").insertAfter("#rtm");
				    sueldoActual = sueldoActual + parseFloat(json.comp_pos);
					
					$("<th id='hd-pos_propuesto'>Comp. Posici&oacuten</th>").insertAfter("#hd_rtm_propuesto");
				    $("<td id='pos_propuesto'>" + setFormatValue(json.comp_pos) + "</td>").insertAfter("#rtm_propuesto");
					sueldoFuturo = sueldoFuturo + parseFloat(json.comp_pos);
			    }
			    if(json.conf !== "0"){
					actualConformado = json.conf;
				    $("<th id='hd-conf'>Conformado Te&oacuterico</th>").insertAfter("#hd-rtm");
				    $("<td id='conf'>" + setFormatValue(json.conf) + "</td>").insertAfter("#rtm");
				    sueldoActual = sueldoActual + parseFloat(json.conf);
					
					
					$("<th id='hd-conf_propuesto'>Conformado Te&oacuterico</th>").insertAfter("#hd-rtm_propuesto");
				    $("<td id='conf_propuesto'>" + setFormatValue(json.conf) + "</td>").insertAfter("#rtm_propuesto");
				    sueldoFuturo = sueldoFuturo + parseFloat(json.conf);
			    }

			    $("#sueldo").html(setFormatValue(sueldoActual));
				$("#sueldo_propuesto").html(setFormatValue(sueldoFuturo));
				actualBT = json.bt;
			    $("#bt").html(setFormatValue(json.bt));
				$("bt_propuesto").html(setFormatValue(json.bt));
			    $("#posic-actual").val(json.posicion);
			    $("#bon").val(setFormatValue(json.bono_sugerido));
				$("#input_rtm_total").val(setFormatValue(json.rtm));
				btSugerido = json.bono_sugerido;
				$("#input_rtm_bn_sugerido").val(setFormatValue(json.bono_sugerido));
				$("#bt_propuesto").html($("#input_rtm_bn_sugerido").val());
				
				if(json.bono_a === json.bono_sugerido){
					$("#slc_bn_nuevo").append("<option selected class='bn'>" + setFormatValue(json.bono_a) + "</option>");
				}else{
					$("#slc_bn_nuevo").append("<option class='bn'>" + setFormatValue(json.bono_a) + "</option>");
				}
				
				if(json.bono_b === json.bono_sugerido){
					$("#slc_bn_nuevo").append("<option selected class='bn'>" + setFormatValue(json.bono_b) + "</option>");
				}else{
					$("#slc_bn_nuevo").append("<option class='bn'>" + setFormatValue(json.bono_b) + "</option>");
				}
				
				if(json.bono_c === json.bono_sugerido){
					$("#slc_bn_nuevo").append("<option selected class='bn'>" + setFormatValue(json.bono_c) + "</option>");
				}else{
					$("#slc_bn_nuevo").append("<option class='bn'>" + setFormatValue(json.bono_c) + "</option>");
				}


				actualJP = json.puesto;
				actualEmpresa = json.empresa;
				actualSupervisory = json.unidad
			    $("#info-job-profile").html("Job Profile: " + json.puesto);
                $("#info-supervisory").html("Supervisory: " + json.unidad);
                $("#info-empresa").html("Empresa: " + json.empresa);
				actualMapaTalento = json.id_mapa_talento;
                $("#info-mapa-talento").html("Mapa de Talento: " + json.id_mapa_talento);
				actualPotencial = json.id_potencial;
                $("#info-potencial").html("Potencial: " + json.id_potencial);
				actualPerformance = json.id_performance;
                $("#info-performance").html("Performance: " + json.id_performance);
				
				var defaultSupervisory = json.unidad;
				var defaultJP = json.puesto;
				var defaultEmpresa = json.empresa;
				$("#supervisory").click();
				$("#nuevoJP").click();
				$.each($(".lista-element"),(i,item) => {
					if(item.parentNode.id === "lista-supervisory"){
						var arraySupervisory = (item.innerHTML).split("-");
						if(((arraySupervisory[1]).trim()) === defaultSupervisory){
							$("#supervisory").val(item.innerHTML);
						}
					}
					if(item.parentNode.id === "lista-nuevoJP"){
						var arrayNuevoJP = (item.innerHTML).split("-");
						if(((arrayNuevoJP[1]).trim()) === defaultJP){
							$("#nuevoJP").val(item.innerHTML);
						}
					}
				});
				
				$.each($("#empresa option"),(i,item) => {
					if(item.innerHTML === defaultEmpresa){
						$("#empresa").val(item.innerHTML);
					}
				});
			},
			error: function(){
				alert("Ha ocurrido un error al obtener los datos del empleado");
				$("#hd-conf").remove();
				$("#conf").remove();
				$("#hd-pos").remove();
				$("#pos").remove();
				$("#hd-fall").remove();
				$("#fall").remove();
	
				$("td").each((i, item) => {
					item.innerHTML = 0;
				})
				$("#info-job-profile").html("Job Profile: ");
				$("#info-supervisory").html("Supervisory: ");
				$("#info-empresa").html("Empresa: ");
				$("#info-mapa-talento").html("Mapa de Talento: ");
				$("#info-potencial").html("Potencial: ");
				$("#info-performance").html("Performance: ");
		
				$("#reporte").val("");
				$("#reporte").attr("disabled",false);
				$("#search-button-reportes").attr("disabled",false);
				$("#search-button-reportes").css("background-color","white");
				$("#supervisory").val("");
				$("#nuevoJP").val("");
				$("#empresa").val("");
				$("#validar-button-1").css("visibility","hidden");
				$("#cancelar-panel1").css("visibility","hidden");
				$(".table-first-panel").hide();
				$("#motivoAjuste").append("<option value='' disabled selected hidden></option>");
				$(".jp-div").hide();
			},
			complete: function(){ 
				$("#loader-div").hide();
				$("body").css("overflow", "visible");	
			},
			type: 'POST',
			url: "<%=request.getContextPath()%>/crucesPresentismo?action=datosemple"
			});
			

				
				
		

	    }, 500);

	    $("#reporte").val(event.target.textContent);
	    $("#search-content-reportes").hide();
	    $("#reporte").css("border-radius", "8px 0px 0px 8px");
	    $("#search-button-reportes").css("border-radius", "0px 8px 8px 0px");
	    $("#search-div-reportes").css("border-radius", "8px");
		$("#reporte").attr("disabled",true);
		$("#search-button-reportes").attr("disabled",true);
		$("#search-button-reportes").css("background-color","#EDEDED ");
	    $(".jp-div").show();
	    $(".table-first-panel").show();
	    $("#validar-button-1").css("visibility", "visible");
		$("#cancelar-panel1").css("visibility","visible");
    }

    if(id === "lista-supervisory"){
        $("#supervisory").val(event.target.textContent);
        $("#search-content-supervisory").hide();
	    $("#supervisory").css("border-radius", "8px 0px 0px 8px");
	    $("#search-button-supervisory").css("border-radius", "0px 8px 8px 0px");
	    $("#search-div-supervisory").css("border-radius", "8px");
    }
	
	 if(id === "lista-nuevoJP"){
        $("#nuevoJP").val(event.target.textContent);
        $("#search-content-nuevoJP").hide();
	    $("#nuevoJP").css("border-radius", "8px 0px 0px 8px");
	    $("#search-button-nuevoJP").css("border-radius", "0px 8px 8px 0px");
	    $("#search-div-nuevoJP").css("border-radius", "8px");
    }

}








  const handleClickValidar = () => {
	var reporteLegajo = ($("#reporte").val()).split("-");
	var motivo = ($("#motivoAjuste").val()).split("-");
	validacionesIncumplidas = [];
	$("#condicion-column-1").html("");
	$("#condicion-column-2").html("");
	
	
	var validacionMotivoAjuste = true;
	$.each($("#motivoAjuste option"),(i,item) => {
		if(item.selected){
			if(item.value === ""){
				validacionMotivoAjuste = false;
				$("#motivoAjuste").css("border-color","red");						
			}
		}
	});

	if(validacionMotivoAjuste){
		
		
		$.ajax({
			contentType: 'application/json',
			data: JSON.stringify({"pusuario": reporteLegajo[0].trim(), "motivo": motivo[0].trim()}),
			dataType: 'json',
			success: function(json){
				$.each(json,(i,item)=>{
					idSolicitud = item.id_solicitud;
					if(item.resultado === "S"){
						validacionesIncumplidas.push(item.descripcion);
					}
				});
				if(validacionesIncumplidas.length === 0){
					esElegible = true;
				}else{
					esElegible = false;
					$.each(validacionesIncumplidas,(i,item)=>{
						var cond = "<div class='condicion'><img class='icon'src='../images/wrong.png'><h4>" + item +"</h4></div>";
						if(i%2==0){
							$("#condicion-column-1").append(cond);
						}else{
							$("#condicion-column-2").append(cond);
						}
					});
				}
				validar();
			},
			error: function(){
				alert("Ha ocurrido un error al obtener los reportes");
			},
			type: 'POST',
			url: "<%=request.getContextPath()%>/crucesPresentismo?action=validar"
		});
	}
 }



        const validar = () => {
            $("#loader-div").show();
            $("body").css("overflow","hidden");
            if(!esElegible){
                $("#modal-validar").show();
            }
            else{
                $("#button-div1").hide();
                $("#search-content-reportes").hide();
                $("#reporte").css("border-radius","8px 0px 0px 8px");
                $("#search-button-reportes").css("border-radius","0px 8px 8px 0px");
                $("#search-div-reportes").css("border-radius","8px");
                $("#reporte").attr("disabled",true);
                $("#motivoAjuste").attr("disabled",true);
                $("#search-button-reportes").attr("disabled",true);
                $("#search-button-reportes").css("background-color","#EDEDED ");
                $(".jp-div").show();
                $(".table-first-panel").show();
                $("#subtitle-propuesta").show();
                $("#propuesta-panel").show();
				document.getElementById("subtitle-propuesta").scrollIntoView();

		$(".validar-button-div-2").show();
		$(".cancelar-button-div").show();
		

            }
            setTimeout(() => {
                $("#loader-div").hide();
                $("body").css("overflow","visible");
            },"500")
        }



        const handleClickAceptar = () => {
            if(confirm("El empleado no cumple los requisitos. ¿Desea continuar?")){
                esElegible = true;
                validar()
            }else{
                esElegible = false;
            }
            $("#modal-validar").hide();
        }

        const handleClickVolver = () => {
            $("#modal-validar").hide()
        }

     const handleClickCancelar = (event) => {        
		var id = event.target.id;
		clean();
        if(id === "cancelar-panel1"){
            $("#hd-conf").remove();
	        $("#conf").remove();
	        $("#hd-pos").remove();
	        $("#pos").remove();
	        $("#hd-fall").remove();
	        $("#fall").remove();
	
	        $("td").each((i, item) => {
		        item.innerHTML = 0;
	        })
	        $("#info-job-profile").html("Job Profile: ");
			$("#info-supervisory").html("Supervisory: ");
			$("#info-empresa").html("Empresa: ");
			$("#info-mapa-talento").html("Mapa de Talento: ");
			$("#info-potencial").html("Potencial: ");
			$("#info-performance").html("Performance: ");
		
			$("#reporte").val("");
			$("#reporte").attr("disabled",false);
			$("#search-button-reportes").attr("disabled",false);
			$("#search-button-reportes").css("background-color","white");
		    $("#supervisory").val("");
		    $("#nuevoJP").val("");
		    $("#empresa").val("");
			$("#validar-button-1").css("visibility","hidden");
			$("#cancelar-panel1").css("visibility","hidden");
			$(".table-first-panel").hide();
			$("#motivoAjuste").append("<option value='' disabled selected hidden></option>");
			$("#motivoAjuste").css("border-color","gray");
            $(".jp-div").hide();
			

        }
		

        if(id === "cancelar-panel2" || id === "finalizar-button"){
			
			if(id === "finalizar-button"){
				handleClickPDF();
			}
			
			//Limpiar columnas de la primera tabla
			
			$("#hd-conf").remove();
	        $("#conf").remove();
			
	        $("#hd-pos").remove();
	        $("#pos").remove();
			
	        $("#hd-fall").remove();
	        $("#fall").remove();
			
			//Limpiar columnas de la segunda tabla
			$("#hd-conf_propuesto").remove();
			$("#conf_propuesto").remove();
			
			$("#hd-pos_propuesto").remove();
			$("#pos_propuesto").remove();
			
			$("#hd-fall_propuesto").remove();
			$("#fall_propuesto").remove();
			
			$("#posic-nuevo").val("");
            $("#propuesta-panel").hide();
            $("#subtitle-propuesta").hide();
            $(".table-first-panel").hide();
            $(".jp-div").hide();
            $("#search-button-reportes").css("background-color","white");
            $("#reporte").attr("disabled",false);
            $("#motivoAjuste").attr("disabled",false);
            $("#button-div1").show();
            $("#validar-button-1").css("visibility","hidden");
			$("#cancelar-panel1").css("visibility","hidden");
			$(".validacion-ajuste-div").hide();
			$("#finalizar-div").hide();
			$("#button-div2").show();
	        $("#reporte").val("");
	        $("#motivoAjuste").val("");
        }

 	}
	
	const handleChangeBono = () => {
        $("#bt_propuesto").html($("#slc_bn_nuevo").val());
	}
	
	const handleBlurInput = () => {
		var reporte = ($("#reporte").val()).split("-");
		var legajo = reporte[0].trim();
		var nuevoJP = ($("#nuevoJP").val()).split("-");
		var codigoJP = nuevoJP[0].trim();
		var nuevoSueldo = getFormatValue($("#sueldo_propuesto").html());
		$.ajax({
			contentType: 'application/json',
			data: JSON.stringify({"pusuario": legajo, "nuevoJP": codigoJP, "nuevoSueldo": nuevoSueldo}),
			dataType: 'json',
			success: function(json){
				$("#posic-nuevo").val(json.nueva_pos);
			},
			error: function(){
				alert("Ha ocurrido un error al calcular el posicionamiento");
			}, 
			type: 'POST',
			url: "<%=request.getContextPath()%>/crucesPresentismo?action=posiciona"
		});
}

	
	
	const propuesta_rb = () => {
			$("#input_rtm_importe").val(0);
			$("#input_rtm_porcent").val(0);
			$("#input_rtm_importe").css("border-color","gray");
			$("#input_rtm_porcent").css("border-color","gray");
            let chk = $('input[name="rtm_total"]:checked').val();
            let rtm = getFormatValue($('#rtm').html());
			let sueldo = getFormatValue($("#sueldo").html());
            if(chk === "porcent"){
                $("#input_rtm_importe").attr("disabled",true);
                $("#input_rtm_porcent").attr("disabled",false);
            }else {
                $("#input_rtm_importe").attr("disabled",false);
                $("#input_rtm_porcent").attr("disabled",true);
            }
            $("#input_rtm_total").val(setFormatValue(rtm));
			$("#rtm_propuesto").html(setFormatValue(rtm));
			$("#sueldo_propuesto").html(setFormatValue(sueldo));
        }

        const validar_numerico = (e) =>{
			var importeLength = ($("#input_rtm_importe").val()).length;
			var percentAmount = ($("#input_rtm_porcent").val());
            if((e.charCode >=48 && e.charCode <=57) || e.charCode === 46){
                if(e.target.id === "input_rtm_importe"){
					if(importeLength < 10){
						return true;
					}
					else{
						return false;
					}
				}
				if(e.target.id === "input_rtm_porcent"){
					if((percentAmount + e.key)<=200){
						return true;
					}else{
						return false;
					}
				}
            }else {
                return false;
            }
        }
	
	
	
	const relacion_input_ajuste = () =>{
            let chk = $('input[name="rtm_total"]:checked').val();
            let total = getFormatValue($('#rtm').html());
            let importe = 0.00;
            let porcent = 0.00;
            let aumento = 0.00;
			let nuevoSueldo = 0.00;
			$("#input_rtm_importe").css("border-color","gray");
			$("#input_rtm_porcent").css("border-color","gray");
            if(chk === "porcent"){
                aumento = parseFloat($("#input_rtm_porcent").val());
                porcent = isNaN(aumento) ? 0 : (parseFloat(aumento).toFixed(2));
                importe = isNaN(aumento) ? 0 : (total * (porcent / 100));
                total = isNaN(aumento) ? total : (total + (total * (porcent / 100)));
                $("#input_rtm_importe").val(setFormatValue(importe));
                $("#input_rtm_total").val(setFormatValue(total));
            }else{
                aumento = parseFloat($("#input_rtm_importe").val());
                importe = isNaN(aumento) ? 0 : aumento;
                porcent = isNaN(aumento) ? 0 : (importe/total) * 100;
                total = isNaN(aumento) ? total : (total + importe) *1;
                $("#input_rtm_porcent").val(setPercentValue(porcent));
                $("#input_rtm_total").val(setFormatValue(total));
            }
            $("#rtm_propuesto").html(setFormatValue(total));
			nuevoSueldo = total;
			$.each($("td"),(i,item)=>{
				if(item.id === "conf_propuesto"){
					nuevoSueldo = nuevoSueldo + getFormatValue(item.innerHTML);
				}
				if(item.id === "pos_propuesto"){
					nuevoSueldo = nuevoSueldo + getFormatValue(item.innerHTML);
				}
				if(item.id === "fall_propuesto"){
					nuevoSueldo = nuevoSueldo + getFormatValue(item.innerHTML);
				}
			});
			
			$("#sueldo_propuesto").html(setFormatValue(nuevoSueldo));
			
		
    }
	
	const setFormatValue = (value) =>{
            return new Intl.NumberFormat('es-AR', {
                currency: 'ARS', 
                style: 'currency', 
                maximumFractionDigits: 2, 
                minimumFractionDigits: 2
            }).format(value);
        }
		
    const getFormatValue = (currency) =>{
        currency = currency.split(";");
        currency = currency[1].replace(/\./g,"");
		currency = currency.replace(",",".");
        return Number(currency);
    }
		
	const setPercentValue = (value) =>{
		var percent = (parseFloat(value)).toFixed(2) + "%";
		return percent;	
	}
		
		
        const clean = () => {
            $("#input_rtm_importe").val(0);
            $("#input_rtm_porcent").val(0);
            $("option[class='bn']").remove();
        }
    
	
	const getHtmlValidacionesIncumplidas = () =>{
		var finalHtml = "<h1 style='text-decoration:underline;margin-left:400px'>Validaciones</h1>";
		if(validacionesIncumplidas.length > 0){
			for(let i=0;i<validacionesIncumplidas.length;i++){
				finalHtml = finalHtml + "<h2 style='margin-top:15px'>" + validacionesIncumplidas[i] + "</h2>";
			}
			return finalHtml;
		}else{
			return "";
		}
	}
	
		const getHtmlValidacionesAjuste = () =>{
			var finalHtml = "<h1 style='text-decoration:underline;margin-left:320px'>Validaciones de ajuste</h1>";
			if(validacionAjusteIncumplida !== ""){
				finalHtml = finalHtml + "<h2 style='margin-top:15px'>" + validacionAjusteIncumplida+ "</h2>";
				return finalHtml;
			}else{
				return "";
			}
	}
	
	const getHtmlValoresAdicionales = () =>{
		var finalHtml = "";
		if(actualConformado !== 0 || actualComplemento !== 0 || actualFalla !== 0){
			if(actualConformado !== 0){
				finalHtml = finalHtml + "<h2 style='margin-top:15px'>Conformado teórico: " +  setFormatValue(actualConformado) + "</h2>"
			}
			if(actualComplemento !== 0){
				finalHtml = finalHtml + "<h2 style='margin-top:15px'>Complemento posición: " +  setFormatValue(actualComplemento) + "</h2>"
			}
			if(actualFalla !== 0){
				finalHtml = finalHtml + "<h2 style='margin-top:15px'>Falla y función: " +  setFormatValue(actualFalla) + "</h2>"
			}
			return finalHtml;	
		}else{
			return "";
		}
	}
	
	
	const determinarImportePorcentaje = () =>{
		
		var importe = $("#input_rtm_importe").val();
		var porcentaje = $("#input_rtm_porcent").val();
		var chk = $('input[name="rtm_total"]:checked').val();
		var pesoArray= [];
		var puntoArray= [];
		var cantidadSeparadores = 0;
		var posicion = 0;
		var importeFinal = 0;
		var arrayResult = [];
		
		
		// Está checkeado el "importe"? entonces se debe sacar el formato al porcentaje
		if(chk === "importe"){
			var porcentajeSinFormato = porcentaje.substring(0,porcentaje.length-1);
			arrayResult.push(importe);
			arrayResult.push(porcentajeSinFormato);
			return arrayResult;
			//return '&importe=' + importe + "&porcentaje=" + porcentajeSinFormato; 
			
		// Está checkeado el "porcentaje"? entonces se debe sacar el formato al importe
		}else{
				// Verifico cuantos separadores de miles tiene importe
				posicion= importe.indexOf(".");
				while (posicion !== -1) {
					cantidadSeparadores++;
					posicion = importe.indexOf(".", posicion + 1);
				}
				
				// 0 separadores (numero entre 0,00 y 999,99)
				if(cantidadSeparadores === 0){
					pesoArray = importe.split("$");
					importeFinal = (pesoArray[1]).replace(",",".");
					importeFinal = importeFinal.substring(1,importeFinal.length);
					arrayResult.push(importeFinal);
					arrayResult.push(porcentaje);
					return arrayResult;
					//return '&importe=' + importeFinal + "&porcentaje=" + porcentaje;
				}

				// 1 separador (numero entre 1.000,00 y 999.999,99)
				if(cantidadSeparadores === 1){
					pesoArray = importe.split("$");
					puntoArray = pesoArray[1].split(".");
					importeFinal = puntoArray[0] + puntoArray[1];
					importeFinal = importeFinal.replace(",",".");
					importeFinal = importeFinal.substring(1,importeFinal.length);
					arrayResult.push(importeFinal);
					arrayResult.push(porcentaje);
					return arrayResult;
					//return '&importe=' + importeFinal + "&porcentaje=" + porcentaje;
				}
	
				// 2 separadores (numero entre 1.000.000,00 y 999.999.999,99  )
				if(cantidadSeparadores === 2){
					pesoArray = importe.split("$");
					puntoArray = pesoArray[1].split(".");
					importeFinal = puntoArray[0] + puntoArray[1] + puntoArray[2];
					importeFinal = importeFinal.replace(",",".");
					importeFinal = importeFinal.substring(1,importeFinal.length);
					arrayResult.push(importeFinal);
					arrayResult.push(porcentaje);
					return arrayResult;
					//return '&importe=' + importeFinal + "&porcentaje=" + porcentaje;
				}
			}
	}
	
	
	const handleClickRegistrar = () =>{
		
		var chk = $('input[name="rtm_total"]:checked').val();
		var importe = $("#input_rtm_importe").val();
		var porcentaje = $("#input_rtm_porcent").val();
		
		if(validarNuevoJP() && validarSupervisory() && validarAumento()){
		//if((importe !== "0" && importe !== "" ) && (porcentaje !== "0" && porcentaje !== "")){
			$("#loader-div").show();
			$(".button-div").hide();
			$(".validacion-ajuste-div").show();
			$(".finalizar-div").show();
		
			var reporteLegajo = ($("#reporte").val()).split("-");
			var idMotivoAjuste = $("#motivoAjuste").val();
			var fecSimulacion = $("#fechaSimulacion").val();
		
			// Obtengo el codigo del JP actual
			var codigoJP = "";
			$.each(nuevoJPFuente,(i,item)=>{
			if(((item).toLowerCase()).includes(actualJP.toLowerCase())){
				let arrayJP = (item).split("-");
				codigoJP = arrayJP[0].trim();
			}
			});
		
			// Obtengo el codigo del supervisory actual
			var codigoSupervisory = "";
			$.each(supervisoryFuente,(i,item)=>{
				if(((item).toLowerCase()).includes(actualSupervisory.toLowerCase())){
					let arraySup = (item).split("-");
					codigoSupervisory= arraySup[0].trim();
				}
			});
			
			// Obtengo el codigo de la empresa actual
			var codigoEmpresa = "";
			$.each(empresaFuente,(i,item)=>{
				if(((item).toLowerCase()).includes(actualEmpresa.toLowerCase())){
					let arrayEmp = (item).split("-");
					codigoEmpresa= arrayEmp[0].trim();
				}
			});
		
		
			//Obtengo el codigo de la empresa futura
			var codigoEmpresaFutura = "";
			$.each(empresaFuente,(i,item)=>{
				if(((item).toLowerCase()).includes(($("#empresa").val()).toLowerCase())){
					let arrayEmp = (item).split("-");
					codigoEmpresaFutura= arrayEmp[0].trim();
				}
			});
		
			var arrayNuevoJP = ($("#nuevoJP").val()).split("-");
			var nuevoJPid = (arrayNuevoJP[0]).trim();
			var arrayNuevoSupervisory = ($("#supervisory").val()).split("-");
			var nuevoSupervisoryId = (arrayNuevoSupervisory[0]).trim();
			var empresaNueva = $("#empresa").val();
			var remuneracionTotal = getFormatValue($("#sueldo").html());
			var remuneracionTotalNueva = getFormatValue($("#sueldo_propuesto").html());
			var btPropuesto = getFormatValue($("#bt_propuesto").html());
			var posicionamientoNuevo = $("#posic-nuevo").val();
			
			var importePorcentajeArray = determinarImportePorcentaje();
		
		
			// Registro de la solicitud
			
			
			
			$.ajax({
			contentType: 'application/json',
			data: JSON.stringify({"idSolicitud": idSolicitud, "usuarioCorpoSuper": "<%=legajo.getUsrId()%>","usuarioCorpoEmpleado": reporteLegajo[0].trim(),
			"idMotivoAjuste": idMotivoAjuste, "fecSimulacion": fecSimulacion, "idJobProfile": codigoJP, "idSupervisory": codigoSupervisory,"idEmpresa":codigoEmpresa,
			"rtm":actualRTM,"conformado":actualConformado,"complemento":actualComplemento,"adicFalla":actualFalla,"remuneracionTot":remuneracionTotal,"bt":actualBT,
			"idMapaTalento":actualMapaTalento,"performance":actualPerformance,"potencial":actualPotencial,"idJobProfileNuevo":nuevoJPid,"idSupervisoryNueva":nuevoSupervisoryId,
			"idEmpresaNueva":codigoEmpresaFutura,"importe":importePorcentajeArray[0],"porcentaje":importePorcentajeArray[1],"remuneracionTotalNueva":remuneracionTotalNueva,"btPropuesto":btPropuesto,"posicionamiento":posicionamientoNuevo,"bonoSugerido":btSugerido
			}),
			dataType: 'json',
			success: function(){
				alert("Solicitud registrada con éxito");
			},
			error: function(){
				alert("Ha ocurrido un error al registrar la solicitud");
			},
			type: 'POST',
			url: "<%=request.getContextPath()%>/crucesPresentismo?action=registrar"
		});
		
		
		
		
		
		
			// Validacion post-aumento
		
			$.ajax({
			contentType: 'application/json',
			data: JSON.stringify({"idSolicitud":idSolicitud,"pusuario":reporteLegajo[0].trim(),"nuevojp":nuevoJPid,"importe":importePorcentajeArray[0],"porcentaje":importePorcentajeArray[1],"motivoAjuste":idMotivoAjuste}),
			dataType: 'json',
			success: function(){
				$.each(json,(i,item)=>{
					if(item.resultado === "S"){
						validacionAjusteIncumplida = item.mensaje;
						$("#validacion-ajuste-span").text(validacionAjusteIncumplida);
					}
				});
			
			},
			error: function(){
				alert("Error al validar el ajuste");
				$("#loader-div").hide();
			},
			type: 'POST',
			url: "<%=request.getContextPath()%>/crucesPresentismo?action=validarpost"
		});
		
	
			$("#loader-div").hide();
			
		}/*else{
			if(chk === "importe"){
				$("#input_rtm_importe").css("border-color","red");
			}else{
				$("#input_rtm_porcent").css("border-color","red");
			}
		}*/
	}
	
	const handleClickPDF = () =>{
		
		// Obtencion de datos
		var date = new Date();
		var hours = date.getHours();
		var minutes = date.getMinutes();
		var seconds = date.getSeconds();
		var today = date.getDate().toString() + "/" +  (date.getMonth()+1).toString() + "/" + date.getFullYear().toString() + " " +("0" + hours).slice(-2) + ":"+("0" + minutes).slice(-2) +":"+ ("0" + seconds).slice(-2);
		var legajoSupervisor ="<%= legajo.getUsrId() %>";
		var nombreSupervisor = "<%= legajo.getApellidoYNombre() %>";
		var motivoAjuste = $('#motivoAjuste').find(":selected").text();
		var nombreArray = ($("#reporte").val()).split();
		var nombre = (nombreArray[0]).trim();
		var importe = $("#input_rtm_importe").val();
		var porcentaje = $("#input_rtm_porcent").val();
		var chk = $('input[name="rtm_total"]:checked').val();
		if(chk === "importe"){
			importe = setFormatValue(importe);
		}else{
			porcentaje = setPercentValue(porcentaje);
		}
		// Obtengo codigoJP actual
		var codigoJP = "";
		$.each(nuevoJPFuente,(i,item)=>{
			if(((item).toLowerCase()).includes(actualJP.toLowerCase())){
				let arrayJP = (item).split("-");
				codigoJP = arrayJP[0].trim();
			}
		});
	
		// Obtengo codigoSupervisoryActual
		var codigoSupervisory = "";
		$.each(supervisoryFuente,(i,item)=>{
			if(((item).toLowerCase()).includes(actualSupervisory.toLowerCase())){
				let arraySup = (item).split("-");
				codigoSupervisory= arraySup[0].trim();
			}
		});

		// Obtengo codigoEmpresaActual
		var codigoEmpresaActual = "";
		$.each(empresaFuente,(i,item)=>{
			if(((item).toLowerCase()).includes((actualEmpresa).toLowerCase())){
				let arrayEmp = (item).split("-");
				codigoEmpresaActual= arrayEmp[0].trim();
			}
		});

		// Obtengo codigoEmpresaFutura
		var codigoEmpresaFutura = "";
		$.each(empresaFuente,(i,item)=>{
			if(((item).toLowerCase()).includes(($("#empresa").val()).toLowerCase())){
				let arrayEmp = (item).split("-");
				codigoEmpresaFutura= arrayEmp[0].trim();
			}
		});


		//Generación del PDF
		window.jsPDF = window.jspdf.jsPDF;	
		var reporte = new jsPDF({format: [400,210]}); 

		var reportHTML = "<div style='background-color:#004481;height:100px;width:1200px'><div style='height:100%;display:flex;align-items:center'><img style='margin-left: 25px;height: 45px;width: 150px' src='../images/logobanco.png'><span style='color: white;font-size:25px;margin-top:10px;margin-left:20px'>SIRSYS</span></div><div style='width:1025px;padding-left:20px;padding-top:20px;padding-bottom:20px;border: 2px solid black'><h2>Fecha simulación: " + today + "</h2><h2 style='margin-top:15px'>Número solicitud: " + idSolicitud + "</h2><h2 style='margin-top:15px'>Solicitante: " + legajoSupervisor + " - " + nombreSupervisor + "</h2><h1 style='text-decoration:underline;margin-left:400px;margin-top:35px'>Datos actuales</h1><h2 style='margin-top:30px'>Empleado: " + nombre + "</h2><h2 style='margin-top:15px'>Motivo del ajuste: "+ motivoAjuste +"</h2><h2 style='margin-top:15px'>Job profile: " + codigoJP + " - " + actualJP + "</h2><h2 style='margin-top:15px'>Supervisory: " + codigoSupervisory + " - " + actualSupervisory+"</h2><h2 style='margin-top:15px'>Empresa: " + codigoEmpresaActual + " - " + actualEmpresa + "</h2><h2 style='margin-top:15px'>Mapa de Talento: " +actualMapaTalento + "</h2><h2 style='margin-top:15px'>Potencial: " + actualPotencial +  "</h2><h2 style='margin-top:15px'>Performance: "+ actualPerformance+"</h2><h2 style='margin-top:15px'>RTM: " + $("#rtm").html() +"</h2>" + getHtmlValoresAdicionales() +"<h2 style='margin-top:15px'>Sueldo: " + $("#sueldo").html() + "</h2><h2 style='margin-top:15px'>BT: " + $("#bt").html() +"</h2><h1 style='text-decoration:underline;margin-left:400px;margin-top:35px'>Datos nuevos</h1><h2 style='margin-top:30px'>Nuevo supervisory: " + $("#supervisory").val() + "</h2><h2 style='margin-top:15px'>Nuevo JP: " + $("#nuevoJP").val() + "</h2><h2 style='margin-top:15px'>Nueva empresa:  " + codigoEmpresaFutura + " - " + $("#empresa").val() + "</h2><h2 style='margin-top:15px'>Sueldo actual: " + $("#sueldo").html() + "</h2><h2 style='margin-top:15px'>Importe a ajustar: " + importe + "<h2 style='margin-top:15px'>Porcentaje a ajustar: " + porcentaje + "<h2 style='margin-top:15px'>Sueldo nuevo: " + $("#sueldo_propuesto").html() + "<h2 style='margin-top:15px'>BT sugerido: " + $("#input_rtm_bn_sugerido").val() + "</h2><h2 style='margin-top:15px'>BT propuesto: " + $("#bt_propuesto").html() + "</h2><h2 style='margin-top:15px'>Posicionamiento: " + $("#posic-nuevo").val() + "</h2>" + getHtmlValidacionesIncumplidas() + getHtmlValidacionesAjuste() +  "</div></div>"
		
		
		
		reporte.html(reportHTML, {
			html2canvas: {
					scale:"0.2",
			},
			callback: function (reporte) {
				reporte.save("SIRSYSReport.pdf");
			}
		});
	}
	//Validaciones propuesta
	const validarNuevoJP = () => {
		if(!nuevoJPFuente.includes($("#nuevoJP").val())){
			$("#search-div-nuevoJP").css("border-color","red");
			return false;
		}
		$("#search-div-nuevoJP").css("border-color","gray");
		return true;
	}
	const validarSupervisory = () => {
		if(!supervisoryFuente.includes($("#supervisory").val())){
			$("#search-div-supervisory").css("border-color","red");
			return false;
		}
		$("#search-div-supervisory").css("border-color","gray");
		return true;
	}
	const validarAumento = () => {
		var chk = $('input[name="rtm_total"]:checked').val();
		var importe = $("#input_rtm_importe").val();
		var porcentaje = $("#input_rtm_porcent").val();
		
		if(chk === "importe"){
			if(importe === "0" || importe === ""){
				$("#input_rtm_importe").css("border-color","red");
				return false;
			}
		}else{
			if(porcentaje === "0" || porcentaje === ""){
				$("#input_rtm_porcent").css("border-color","red");
				return false;
			}
		}
		
		/*if(!(importe !== "0" && importe !== "" ) && !(porcentaje !== "0" && porcentaje !== "")){
			if(chk === "importe"){
				$("#input_rtm_importe").css("border-color","red");
			}else{
				$("#input_rtm_porcent").css("border-color","red");
			}
			return false;
		}*/
		return true;
	}
	  
    </script>
	
    <div id="modal-validar">
        <div class="modal-validar-content">
            <div class="text-content">
                <h3>El empleado no es elegible para un ajuste</h3>
            </div>
            <div class="condicion-content">
                <div class="condicion-column" id="condicion-column-1"></div>
                <div class="condicion-column" id="condicion-column-2"></div>                
            </div>
            <div class="aceptar-button-div">
                    <div class="modal-div-btn">
                    	<button class="validar-button" onclick="handleClickAceptar()">Continuar</button>
                    </div>
                    <div class="modal-div-btn">
                    	<button class="cancelar-button" onclick= "handleClickVolver()">Volver</button>
                    </div>           
            </div>
        </div>
    </div>

    <div id="loader-div">
        <div id="loader"></div>
    </div>

	<div class="container">
		<jsp:include page="HeaderSirsys.jsp" >
		</jsp:include>
    		<div class="content">
			<div class="sub-title-div">
                	<h2 class="sub-title">Colaborador</h2>
                	<hr class="horizontal-line-subtitle">
            	</div>
        		<div class="panel">
                		<div class="inputs-div">
                    			<div class="input-div" id="reporte-div">
                    				<label class="select-label" for="reporte">Mi equipo</label>
		     	 			<div class="search-div" id="search-div-reportes">
                         				<div class="search-content" id="search-content-reportes"></div>
                                				<input type="search" oninput="handleInput(event)"  onclick="handleInput(event)" class="search-style" name="reporte" id="reporte"></input>
                                				<button class="search-button" id="search-button-reportes"> <img class="icon" src="../images/search.png"></button>
                        				</div>
                    				</div>

                    				<div class="motivo-div">
                        			<label class="select-label" for="motivoAjuste">* Motivo del ajuste</label>
                        			<select class="select-style" onchange="handleChangeMotivo()" name="Motivo" id="motivoAjuste">
                        			</select>
                    			</div>
                    			<div class="fecha-div">
                        			<label class="select-label" for="fechaSimulacion">Fecha de simulaci&oacute;n</label>
                        			<input class="select-style" type="text" name="fecha" id="fechaSimulacion" disabled>
                    			</div>
                		</div>
						<div class="jp-div">
								<hr class="horizontal-line-jp">
								<div class="jp-title">
									<div class="info-card-column">
										<div class="container-h3">
											<span class="jp-arrow">&#10148;</span>
											<h3 class="jp-h3" id="info-job-profile"/>
										</div>
										<div class="container-h3">
											<span class="jp-arrow">&#10148;</span>
											<h3 class="jp-h3" id="info-supervisory"/>
										</div>
										<div class="container-h3">
											<span class="jp-arrow">&#10148;</span>
											<h3 class="jp-h3" id="info-empresa"/>
										</div>     
									</div>
									<div class="info-card-column">
										<div class="container-h3">
											<span class="jp-arrow">&#10148;</span>
											<h3 class="jp-h3" id="info-mapa-talento"/>
										</div>
										<div class="container-h3">
											<span class="jp-arrow">&#10148;</span>
											<h3 class="jp-h3" id="info-potencial"/>
										</div>
										<div class="container-h3">
											<span class="jp-arrow">&#10148;</span>
											<h3 class="jp-h3" id="info-performance"/>
										</div>     
									</div>
								</div>
							</div>

                	<table class="table-first-panel">
                    		<tr class="table-first-panel-header">
                			<th id="hd-rtm">RTM</th>
                			<th id="hd-sueldo">Sueldo</th>
                			<th id="hd-bt">BT</th>                    
		    		</tr>
                    		<tr class="table-first-panel-cells">
                        		<td id="rtm"></td>
					<td id="sueldo"></td>
					<td id="bt"></td>
                    		</tr>
                	</table>

                <div class="button-div" id="button-div1">
		    		<div class="validar-button-div">
                    	<button onclick="handleClickValidar()" class="validar-button" id="validar-button-1">Validar</button>
					</div>
				    <div class="cancelar-button-div">
						<button onclick="handleClickCancelar(event)" id="cancelar-panel1" class="cancelar-button">Cancelar</button>
                    </div>
               	</div>
          </div>

	  <div class="sub-title-propuesta-div" id="subtitle-propuesta">
		<h2 class="sub-title">Propuesta</h2>
            	<hr class="horizontal-line-subtitle">
	  </div>
	  <div class="panel" id="propuesta-panel">
                <div class="inputs-div">
                    <div class="input-div" id="supervisory-div">
                        <label class="select-label" for="supervisory">Supervisory</label>
                        <div class="search-div" id="search-div-supervisory">
						<div class="search-content" id="search-content-supervisory"></div>
                            <input type="search" class="search-style" oninput="handleInput(event)"  onclick="handleInput(event)" name="supervisory" id="supervisory"></input>
                            <button class="search-button" id="search-button-supervisory"> <img class="icon" src="../images/search.png"></button>
                        </div>
                    </div>
                    
                    <div class="input-div" id="nuevoJP-div">
                        <label class="select-label" for="nuevoJP">Nuevo JP</label>
                        <div class="search-div" id="search-div-nuevoJP">
						<div class="search-content" id="search-content-nuevoJP"></div>
                            <input type="search" class="search-style" oninput="handleInput(event)"  onclick="handleInput(event)" name="nuevoJP" id="nuevoJP"></input>
                            <button class="search-button" id="search-button-nuevoJP"> <img class="icon" src="../images/search.png"></button>
                        </div>
                    </div>

                    <div class="empresa-div">
                        <label class="select-label" for="empresa">Empresa</label>
                        <select class="select-style" name="empresa" id="empresa" disabled></select>
                    </div>
                </div>
                <div class="rtm-row-propuesta-panel">
				<div class="propuesta-rtm-div">
                        <label>Remuneración Total:</label>
                 </div>
                    <div class="propuesta-rtm-div">
                        <div class="propuesta-radio-button">
                            <input class="radio-button" type="radio" value="importe" name="rtm_total" onchange="propuesta_rb()"/>
                        </div>
                        <div class="input-panel-propuesta">
                            <label class="select-label" for="importe">Importe a ajustar</label>
                            <input type="text" value="" class="input-propuesta" name="importe" id="input_rtm_importe" disabled
                                onkeypress="return validar_numerico(event)" onkeyup="relacion_input_ajuste()" onblur="handleBlurInput()"/>
                        </div>
                    </div>
                    <div class="propuesta-rtm-div">
                        <div class="propuesta-radio-button">
                            <input class="radio-button" type="radio" value="porcent" name="rtm_total" checked="checked" onchange="propuesta_rb()"/>
                        </div>
                        <div class="input-panel-propuesta">
                            <label class="select-label" for="porcent">Porcentaje a ajustar</label>
                            <input type="text" value="" class="input-propuesta" name="porcent" id="input_rtm_porcent"
                                onkeypress="return validar_numerico(event)" onkeyup="relacion_input_ajuste()" onblur="handleBlurInput()"/>
                        </div>
                    </div>
                    <div class="propuesta-rtm-div">
                        <div class="input-panel-propuesta">
                            <label class="select-label" for="total">Total</label>
                            <input type="text" value="" class="input-propuesta" name="total" id="input_rtm_total" disabled/>
                        </div>
                    </div>
                </div>
				
                <hr class="propuesta-panel-hr">
                <div class="row-propuesta-panel">
                    <div class="propuesta-input-div">
                        <label>Bono: </label>
                    </div>
                    
                    <div class="propuesta-input-div">
                        <div class="input-panel-propuesta">
                            <label class="select-label" for="posic">Sugerido</label>
                                <input type="text" value="" class="input-propuesta" name="bn_sugerido" id="input_rtm_bn_sugerido" disabled/>
                            </div>
                        </div>
                        <div class="propuesta-input-div">
                        <div class="input-panel-propuesta">
                            <label class="select-label" for="posic">Nuevo/Futuro</label>
                            <select class="select-style" onchange="handleChangeBono()" name="bn_nuevo" id="slc_bn_nuevo"></select>
                        </div>
                        </div>
                </div>
      
                <hr class="propuesta-panel-hr">
                <div class="row-propuesta-panel">
                    <div class="propuesta-input-div">
                        <label>Posicionamiento: </label>
                    </div>
                    
                    <div class="propuesta-input-div">
                        <div class="input-panel-propuesta">
                            <label class="select-label" for="posic">Actual</label>
                            <input type="text"  class="input-propuesta" name="posic" id="posic-actual" disabled/>
                            </div>
                        </div>
                        <div class="propuesta-input-div">
                        <div class="input-panel-propuesta">
                            <label class="select-label" for="posic">Nuevo/Futuro</label>
                            <input type="text" class="input-propuesta" name="posic" id="posic-nuevo" disabled/>
                        </div>
                        </div>
                </div>
                <hr class="propuesta-panel-hr">
                <table class="table-first-panel">
                    <tr class="table-first-panel-header">
                        <th id="hd_rtm_propuesto">RTM</th>
                        <th id="hd_sueldo_propuesto">Sueldo</th>
                        <th id="hd_bt_propuesto">BT</th> 
                    </tr>
                    <tr class="table-first-panel-cells">
                        <td id="rtm_propuesto"></td>
                        <td id="sueldo_propuesto"></td>
                        <td id="bt_propuesto"></td>
                    </tr>
                </table>
                <div class="button-div" id="button-div2">
                    <div class="validar-button-div" id="validar-button-div2">
                        <button onclick="handleClickRegistrar()" class="validar-button">Validar</button>
                    </div>
                    <div class="cancelar-button-div">
                        <button onclick="handleClickCancelar(event)" id="cancelar-panel2" class="cancelar-button">Cancelar</button>
                    </div>
                </div>
				<div class="validacion-ajuste-div" style='display:flex;justify-content:center;margin-top:3em'>
					<span id="validacion-ajuste-span" style='font-size:30px'></span> 
				</div>
				<div class="finalizar-div" id="finalizar-div">
					<div class="finalizar-button-div">
						<button onclick="handleClickCancelar(event)" class="validar-button" id="finalizar-button">Finalizar</button>
					</div>
					<div class="pdf-div">
						<span class="pdf-span">Exportar a PDF</span>
						<button onclick="handleClickPDF()"><img class="pdf-icon" src="../images/pdf.png"/></button>
					</div>
				</div>
            </div>
	    <div class="footer"></div>
   </div>
    <script>
        var date = new Date();
        var today = date.getDate().toString() + "/" +  (date.getMonth()+1).toString() + "/" + date.getFullYear().toString();
        document.getElementById("fechaSimulacion").value = today;
    </script>

    </body>
</html>