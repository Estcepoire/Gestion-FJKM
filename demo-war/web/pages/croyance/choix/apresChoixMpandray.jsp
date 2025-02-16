<%-- 
    Document   : apresChoixMpandray
    Created on : Oct 26, 2024, 10:57:20 AM
    Author     : sarobidy
--%>
<%@ page import="utilitaire.Utilitaire" %>

<html>
    <script language="JavaScript">
<%
    try{
        String[] choix = request.getParameterValues("choix");
        if(choix==null||choix.length==0)throw new Exception("Veuillez cocher au moins un element");
        String id = "";
        String libelle = "";
        for (int i = 0; i < choix.length; i++) {
            String[] temp = choix[i].split(";");
            id = temp[0];
            libelle = temp[1];
%>
            window.opener.document.all.idMpivavaka_<%= i %>.value = "<%=id%>";
             window.opener.document.all.idMpivavaka_<%=i %>libelle.value = "<%=libelle%>";
<%
        }
%>

        window.close();

<%}catch(Exception e){
    e.printStackTrace();
}%>
        </script>
</html>