<%@ page import="bean.*" %>
<%@ page import="facture.*" %>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%
try {
    UserEJB u = (UserEJB) session.getAttribute("u");
    String lien = (String) session.getValue("lien");;
    String idCaisse = request.getParameter("idCaisse");
    String id = request.getParameter("id");
    FactureFournisseur facture = (FactureFournisseur) new FactureFournisseur().getById(id,"facturefournisseur_cpl",null);
    
    String idMvtCaisse = facture.genererMvtCaisse(""+u.getUser().getRefuser(), null, idCaisse);
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=caisse/mvt-caisse-fiche.jsp&id=<%=idMvtCaisse%>");</script>
    <%
    }catch (Exception e) {
        e.printStackTrace();
    %>
<script language="JavaScript"> 
    alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
    history.back();</script>
    <%
        return;
    }
    %>
</script>