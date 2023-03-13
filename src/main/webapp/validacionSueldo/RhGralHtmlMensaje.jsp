<html>

<head>
<title>Mensaje</title>
<%@ include file="RhGralHead.jsp" %>
</head>

<body  <%@ include file="styles/style.body" %> >
<br><br><br>
<p align="center"><img border="0" src="../images/info.gif"></p>
<br><br>

<table width=95% align=center>
<tr>
<td><font <%@ include file="styles/font.texto" %>><%= (String) request.getParameter ( "MENSAJE" ) %></font>
</td>
</tr>
<tr>
<td><br>

<%
	String opcion = (String) request.getParameter ( "OPCION" );
	if ( opcion!= null ) {
		if ( opcion.equals ( "1" ) ) {
%>
			<font <%@ include file="styles/font.texto" %>>Seleccione una opci&oacute;n del men&uacute; para continuar.</font>
<%
		}
        else if ( opcion.equals ( "2" ) ) {
%>
			<a href="javascript:history.back();"><font <%@ include file="styles/font.link" %>>Volver</font></a>
<%             session.invalidate();
        }
	}
%>



</td>
</tr>
</table>

<br>
<hr>
</body>
</html>
