<%@page import="annexe.*"%>
<%@page import="annexe.details.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
        Unite  a = new Unite();
        a.setNomTable("UNITE");
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        pi.setTitre("Enregistrement Produit");     
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
    <input name="bute" type="hidden" id="bute" value="annexe/details/unite-liste.jsp">
    <input name="classe" type="hidden" id="classe" value="annexe.details.Unite">
    <input name="nomtable" type="hidden" id="nomtable" value="unite">
    
    </form>
</div>
<% }catch(Exception e){
        e.printStackTrace();
}%>
