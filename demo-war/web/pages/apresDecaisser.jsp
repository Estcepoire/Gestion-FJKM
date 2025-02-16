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
    
    String idDepense = facture.genererDepense(""+u.getUser().getRefuser(), null, idCaisse);
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=depense/depense-fiche.jsp&id=<%=idDepense%>");</script>
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