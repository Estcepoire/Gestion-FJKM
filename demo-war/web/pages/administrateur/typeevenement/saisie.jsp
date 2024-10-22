<%-- 
    Document   : saisie
    Created on : Oct 21, 2024, 6:58:45 PM
    Author     : sarobidy
--%>

<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsert"%>
<%@page import="evenement.TypeEvenement"%>

<%
          
          TypeEvenement type = new TypeEvenement();
          UserEJB u =(UserEJB) session.getValue("u");
          String lien = (String) session.getValue("lien");
          
          PageInsert pi = new PageInsert( type , request, u);
          pi.setTitre("Saisie Nouveau type d&apos;evenement");
          pi.setLien(lien);
          pi.getFormu().getChamp("val").setLibelle("Type d&apos;evenement");
          pi.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
          pi.preparerDataFormu();
          pi.getFormu().makeHtmlInsertTabIndex();
          
          String apresPost = "administrateur/typeevenement/fiche.jsp",
            mappingClass = "evenement.TypeEvenement",
            nomTable = "typeevenement";

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