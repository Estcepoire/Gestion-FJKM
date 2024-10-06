<%-- 
    Document   : saisie
    Created on : Oct 6, 2024, 8:07:27 AM
    Author     : sarobidy
--%>
<%@page import="croyance.Mpivavaka" %>
<%@page import="affichage.*" %>
<%@page import="user.UserEJB" %>

<%
          
    UserEJB user = (UserEJB) session.getValue("u");
    String lien = (String) session.getValue("lien");
          
    Mpivavaka mapping = new Mpivavaka();
    
    PageInsert pi = new PageInsert( mapping, request, user );
    pi.setLien(lien);
    
    Liste[] list = new Liste[1];
    String[] sexes = {"Homme", "Femme"};
    String[] values = { "1", "0" };
    list[0] = new Liste("sexe", sexes,  values);
    
    pi.getFormu().changerEnChamp(list);
    
    pi.getFormu().getChamp("etat").setVisible(false);
    
    pi.getFormu().getChamp("nom").setLibelle("Nom");
    pi.getFormu().getChamp("prenom").setLibelle("Pr&eacute;nom");
    pi.getFormu().getChamp("datenaissance").setLibelle("N&eacute;e le");
    pi.getFormu().getChamp("sexe").setLibelle("Genre");
    pi.getFormu().getChamp("lieuDeNaissance").setLibelle("&agrave;");
    pi.getFormu().getChamp("contact").setLibelle("Contact");
    pi.getFormu().getChamp("addresse").setLibelle("Adresse");
    
    pi.setTitre("Ajouter un nouveau Croyant");
    
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
    
    String afterPost = "croyance/mpivavaka/fiche.jsp";
    String mappingClass = "croyance.Mpivavaka";
    String nomTable = "mpivavaka";
    

%>

<div class="content-wrapper">
    <h1 class="text-align-center">
            <%= pi.getTitre() %>
    </h1>
    
    <form action="<%= pi.getLien() %>?but=apresTarif.jsp" data-parsley-validate method="POST">
        <%= pi.getFormu().getHtmlInsert() %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= afterPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= mappingClass %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
    
</div>