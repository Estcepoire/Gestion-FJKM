<%@page import="annexe.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
        Produit  a = new Produit();
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        pi.setTitre("Enregistrement Produit");
        affichage.Champ[] liste = new affichage.Champ[2];      
        TypeObjet unite = new TypeObjet();
        unite.setNomTable("UNITE");
        liste[0] = new Liste("idUnite", unite, "val", "id");        
        TypeObjet type = new TypeObjet();
        type.setNomTable("TYPEPRODUIT");
        liste[1] = new Liste("idTypeProduit", type, "val", "id");       
        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("etat").setVisible(false);      
        pi.getFormu().getChamp("val").setLibelle("Designation");      
        pi.getFormu().getChamp("desce").setLibelle("Description");      
        pi.getFormu().getChamp("idTypeProduit").setLibelle("Type Produit");      
        pi.getFormu().getChamp("idUnite").setLibelle("Unite");      
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
    <input name="bute" type="hidden" id="bute" value="annexe/produit-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="annexe.Produit">
    <input name="nomtable" type="hidden" id="nomtable" value="PRODUIT">
    
    </form>
</div>
<% }catch(Exception e){
        e.printStackTrace();
}%>
