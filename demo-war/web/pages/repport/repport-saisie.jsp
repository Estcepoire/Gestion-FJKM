<%@page import="repport.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
        Repport  a = new Repport();
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        pi.setTitre("Enregistrement Repport de Caisse");
        affichage.Champ[] liste = new affichage.Champ[1];      
        TypeObjet caisse = new TypeObjet();
        caisse.setNomTable("caisse");
        liste[0] = new Liste("idCaisse", caisse, "val", "id");

        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("daty").setLibelle("Date");      
        pi.getFormu().getChamp("daty").setDefaut(""+Utilitaire.dateDuJourSql()); 

        pi.getFormu().getChamp("remarque").setLibelle("Remarque");         
        pi.getFormu().getChamp("idCaisse").setLibelle("Caisse");     

        pi.getFormu().getChamp("etat").setVisible(false);      
        pi.getFormu().getChamp("montanttheorique").setVisible(false);      
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
    <input name="bute" type="hidden" id="bute" value="repport/repport-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="repport.Repport">
    <input name="nomtable" type="hidden" id="nomtable" value="reportcaisse">
    
    </form>
</div>
<% }catch(Exception e){
        e.printStackTrace();
}%>
