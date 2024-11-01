<%-- 
    Document   : saisie
    Created on : Oct 6, 2024, 8:07:27 AM
    Author     : sarobidy
--%>
<%@page import="annexe.InformationAnnexe"%>
<%@page import="croyance.information.InformationMpivavaka"%>
<%@page import="annexe.Faritra"%>
<%@page import="croyance.Mpivavaka" %>
<%@page import="affichage.*" %>
<%@page import="user.UserEJB" %>

<%
          
    UserEJB user = (UserEJB) session.getValue("u");
    String lien = (String) session.getValue("lien");
          
    Mpivavaka mapping = new Mpivavaka();
    InformationMpivavaka info = new InformationMpivavaka();
    
    int nbLine = 10;
    
    PageInsertMultiple pi = new PageInsertMultiple(mapping, info, request, nbLine, user);
    pi.setLien(lien);
    
    Liste[] list = new Liste[2];
    String[] sexes = {"Homme", "Femme"};
    String[] values = { "1", "0" };
    list[0] = new Liste("sexe", sexes,  values);
    list[1] = new Liste("idFaritra", new Faritra(), "nomFaritra", "idFaritra");
    
    pi.getFormu().changerEnChamp(list);
    
    pi.getFormu().getChamp("etat").setVisible(false);
    
    pi.getFormu().getChamp("nom").setLibelle("Nom");
    pi.getFormu().getChamp("prenom").setLibelle("Pr&eacute;nom");
    pi.getFormu().getChamp("datenaissance").setLibelle("N&eacute;e le");
    pi.getFormu().getChamp("sexe").setLibelle("Genre");
    pi.getFormu().getChamp("lieuDeNaissance").setLibelle("&agrave;");
    pi.getFormu().getChamp("contact").setLibelle("Contact");
    pi.getFormu().getChamp("addresse").setLibelle("Adresse");
    pi.getFormu().getChamp("idFaritra").setLibelle("Faritra");
    
    pi.setTitre("Ajouter un nouveau Croyant");
    
    Champ.setVisible(pi.getFormufle().getChampFille("idMpivavaka"), false);
    
    list = new Liste[1];
    list[0] = new Liste("idInfoAnnexe", new InformationAnnexe(), "val", "id");
    pi.getFormufle().changerEnChamp(list);
    pi.getFormufle().getChamp("idInfoAnnexe_0").setLibelle("Information sup.");
    pi.getFormufle().getChamp("valeur_0").setLibelle("Valeur");
    
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
    pi.getFormufle().makeHtmlInsertTableauIndex();
    
    String afterPost = "croyance/mpivavaka/fiche.jsp";
    String mappingClass = "croyance.Mpivavaka";
    String nomTable = "mpivavaka";
    String classeFille = "croyance.information.InformationMpivavaka";
    String colonneMere = "idMpivavaka";
    

%>

<div class="content-wrapper">
    <h1 class="text-align-center">
            <%= pi.getTitre() %>
    </h1>
    
    <form action="<%= pi.getLien() %>?but=apresMultiple.jsp" data-parsley-validate method="POST">
        <%= pi.getFormu().getHtmlInsert() %>
        <%= pi.getFormufle().getHtmlTableauInsert()%>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= afterPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= mappingClass %>">
        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nbLine %>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">
    </form>
    
</div>