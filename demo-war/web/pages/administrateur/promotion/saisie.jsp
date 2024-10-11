<%-- 
    Document   : saisie
    Created on : Oct 6, 2024, 9:08:07 PM
    Author     : sarobidy
--%>
<%@page import="affichage.PageInsert"%>
<%@page import="croyance.promotion.Promotion" %>

<%
         
    Promotion promotion = new Promotion();
    
    PageInsert pi = new PageInsert( promotion, request, (user.UserEJB) session.getValue("u") );
    String lien = (String) session.getValue("lien");
    
    pi.getFormu().getChamp("nomPromotion").setLibelle("Nom de la Promotion");
    pi.getFormu().getChamp("anneePromotion").setLibelle("Annee de la Promotion");
    pi.getFormu().getChamp("dateSortie").setLibelle("Date de Sortie de la promotion");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.setTitre("Cr&eacute;ation de Promotion");
    pi.setLien(lien);
    pi.preparerDataFormu();
    String afterPost = "administrateur/promotion/liste.jsp",
                mappingClass = "croyance.promotion.Promotion",
                nomTable = "promotionmpandray";
    
    pi.getFormu().makeHtmlInsertTabIndex();
%>

<div class="content-wrapper">
    <h1 class="text-align-center">
        <%= pi.getTitre() %>
    </h1>
    

    <form action="<%= pi.getLien() %>?but=apresTarif.jsp" data-parsley-validate method="post">
        <%= pi.getFormu().getHtmlInsert() %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= afterPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= mappingClass %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>

</div>