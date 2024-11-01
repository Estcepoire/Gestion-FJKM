<%@page import="ligneCredit.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
        LigneCredit  a = new LigneCredit();
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        pi.setTitre("Enregistrement Ligne Credit");

        affichage.Champ[] liste = new affichage.Champ[1];      
        TypeObjet typelc = new TypeObjet();
        typelc.setNomTable("typelc");
        liste[0] = new Liste("idTypelc", typelc, "val", "id"); 
    
        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("val").setLibelle("Designation");      
        pi.getFormu().getChamp("desce").setLibelle("Description");      
        pi.getFormu().getChamp("idTypelc").setLibelle("Type de ligne");      
        pi.getFormu().getChamp("annee").setLibelle("Ann&eacute;e");      
        pi.getFormu().getChamp("etat").setVisible(false);      
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
    <input name="bute" type="hidden" id="bute" value="ligne-credit/ligne-credit-liste.jsp">
    <input name="classe" type="hidden" id="classe" value="ligneCredit.LigneCredit">
    <input name="nomtable" type="hidden" id="nomtable" value="lignecredit">
    
    </form>
</div>
<% }catch(Exception e){
        e.printStackTrace();
}%>
