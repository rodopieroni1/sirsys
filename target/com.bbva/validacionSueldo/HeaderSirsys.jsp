<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html>

    <head>
        <link rel="stylesheet" type="text/css" href="../css/ValidacionSueldo.css" />
    </head>

	<script>
		
		$(document).ready(() => {
			$(document).click((e) => {
				var container = $(".header-bbva");
				if(!container.is(e.target) && container.has(e.target).length === 0){
					$("#cerrarSesion").hide();
				}		
			});
			setTimeout(() =>{
				var legajo = window.AnimationPlaybackEventsessionStorage.getItem("legajo");
				var apellidoNombre = window.sessionStorage.getItem("apellidoNombre");
				$(".user-span").text(legajo + " - " + apellidoNombre.substring(0,apellidoNombre.length-2));
				$("#cerrarSesion").hide();
			},50)
		});
		
		
		

		
		const handleClickUser = () => {
			$("#cerrarSesion").show();
		}
		
		const handleClickCerrarSesion = () => {
			window.location.href = '../logoutSirsys.jsp';
		}
	</script>
	
	
    <body>

        <div class="header-bbva">
            <div class="header-div">
                <img class="bbva-logo" src="../images/logobanco.png">
        	    <span class="header-title" onclick="window.location.href='ValidacionSueldo.jsp'">SIRSYS</span>
            </div>

			<div class="user-param-hist-div">
				<div class="param-hist-div">
					<span class="param-span" onclick="window.location.href='Parametrizacion.jsp'">Parametr&iacute;a</span>
					<span class="historico-span" onclick="window.location.href='Historico.jsp'">Hist&oacute;rico</span>
				</div>
				<div class="user-div">
					<span onclick="handleClickUser()" class="user-span"></span>
					<span onclick="handleClickCerrarSesion()" id="cerrarSesion" class="cerrar-sesion">Cerrar sesi&oacute;n</span>
				</div>
			</div>
        </div>
    </body>
</html>