<%@page import="magasin.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
        Magasin  a = new Magasin();
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        pi.setTitre("Enregistrement Magasin");     
        pi.getFormu().getChamp("val").setLibelle("Designation");      
        pi.getFormu().getChamp("desce").setLibelle("Description");    
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=pi.getTitre()%> </h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" data-parsley-validate>
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="magasin/magasin-liste.jsp">
    <input name="classe" type="hidden" id="classe" value="magasin.Magasin">
    <input name="nomtable" type="hidden" id="nomtable" value="MAGASIN">
    </form>
</div>
<% }catch(Exception e){
        e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% } %>
