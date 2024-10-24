<%-- 
    Document   : evenement-saisie
    Created on : Oct 23, 2024, 9:20:01 PM
    Author     : sarobidy
--%>

<%@page import="affichage.PageInsert"%>
<%@page import="user.UserEJB"%>
<%@page import="evenement.Evenement"%>
<%
         Evenement event = new Evenement();
         String lien = (String) session.getValue("lien");
         UserEJB user = (UserEJB) session.getValue("u");
         PageInsert pi = new PageInsert( event, request, user );
         pi.setTitre("Ajout d'un evenement");
         pi.setLien(lien);
         pi.getFormu().getChamp("heureDebut").setType("time");
         pi.getFormu().getChamp("heureDebut").setAutre("step=\"1\"");
         pi.getFormu().getChamp("heureFin").setType("time");
         pi.getFormu().getChamp("heureFin").setAutre("step=\"1\"");
         pi.preparerDataFormu();
         pi.getFormu().makeHtmlInsertTabIndex();
         
         String afterPost = "",
            mappingClass = "evenement.Evenement",
            nomTable = "evenement";
%>

<div class="content-wrapper">
    <section class="content-header">
        <%= pi.getTitre() %>
    </section>
    <section class="content">
        <form action="<%= pi.getLien() %>?but=apresTarif.jsp" data-parsley-validate method="POST">
            <%= pi.getFormu().getHtmlInsert() %>
            <input name="acte" type="hidden" id="nature" value="insert">
            <input name="bute" type="hidden" id="bute" value="<%= afterPost %>">
            <input name="classe" type="hidden" id="classe" value="<%= mappingClass %>">
            <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
        </form>
    </section>
</div>