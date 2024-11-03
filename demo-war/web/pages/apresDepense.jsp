<%@ page import="bean.*" %>
<%@ page import="depense.*" %>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%
try {
    UserEJB u = (UserEJB) session.getAttribute("u");
    String lien = (String) session.getValue("lien");
    String id = request.getParameter("id");
    Depense depense = (Depense) new Depense().getById(id,"v_Depenselib",null);
    String idMvtCaisse = depense.genererCaisse(""+u.getUser().getRefuser(), null, depense.getIdCaisse());
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