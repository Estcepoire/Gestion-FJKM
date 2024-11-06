<%-- 
    Document   : recensement-saisie
    Created on : Nov 6, 2024, 7:41:54 PM
    Author     : sarobidy
--%>


<%@page import="affichage.Liste"%>
<%@page import="affichage.PageInsert"%>
<%@page import="user.UserEJB"%>
<%@page import="recensement.Recensement"%>
<%
     
    Recensement rec = new Recensement();
    UserEJB u = (UserEJB) session.getAttribute("u");
    String lien = (String) session.getAttribute("lien");
    
    PageInsert pi = new PageInsert(rec, request, u);
    pi.setLien(lien);
    pi.setTitre("Saisie de recensement");
    
    pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    pi.getFormu().getChamp("annee").setLibelle("Ann&eacute;e");
    pi.getFormu().getChamp("annee").setType("number");
    pi.getFormu().getChamp("annee").setDefaut(utilitaire.Utilitaire.getAnneeEnCours());
    pi.getFormu().getChamp("annee").setAutre("min='1970'");
    pi.getFormu().getChamp("nombre").setLibelle("Croyant Recens&eacute;");
    
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
    
    String apresPost = "administrateur/recensement/recensement-fiche.jsp",
    mappingClass = "recensement.Recensement",
    nomTable = "reportCroyant";
    
%>

<div class="content-wrapper">
    <h1 class="text-align-center">
        <%= pi.getTitre() %>
    </h1>
    

    <form action="<%= pi.getLien() %>?but=apresTarif.jsp" data-parsley-validate method="post">
        <%= pi.getFormu().getHtmlInsert() %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= apresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= mappingClass %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>

</div>