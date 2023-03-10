<%@ page import="java.io.IOException" %>
<%
String dest = "http://wstamprod.arg.igrupobbva/pkmslogout-nomas";
//String dest = "http://" + UtilsConfigurationManager.confWebSEALServerName() + "/pkmslogout";
response.sendRedirect(dest);
%>
