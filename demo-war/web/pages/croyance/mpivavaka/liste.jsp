<%-- 
    Document   : liste
    Created on : Oct 6, 2024, 8:36:07 AM
    Author     : sarobidy
--%>
<%@page import="annexe.Faritra"%>
<%@page import="croyance.MpivavakaLib"%>
<%@page import="croyance.Mpivavaka" %>
<%@page import="affichage.*" %>
<%@page import="user.UserEJB" %>

<%
        try{
            MpivavakaLib mapping = new MpivavakaLib();
            UserEJB user = (UserEJB) session.getValue("u");
            String lien = (String) session.getValue("lien");

            String[] criteres = {"nom", "prenom", "datenaissance", "genre", "addresse", "ageActuelle", "nomFaritra"};
            String[] intervalles = { "ageActuelle", "datenaissance"};
            String[] whatToShow = {"nom", "prenom", "datenaissance", "lieuDeNaissance" , "genre", "addresse", "ageActuelle", "nomFaritra"};

            PageRecherche pr = new PageRecherche( mapping, request, criteres, intervalles, 3, whatToShow, whatToShow.length );
            pr.setTitre("Liste des Croyants");
            pr.setUtilisateur(user);
            pr.setLien(lien);
            pr.setApres("croyance/mpivavaka/liste.jsp");
            
            String[] liens = { pr.getLien() +  "?but=croyance/mpivavaka/fiche.jsp", pr.getLien() +  "?but=croyance/mpivavaka/fiche.jsp"};
            String[] colonne = {"nom", "prenom"};
            String[] attributLien = {"idMpivavaka", "idMpivavaka"};            
            String[] valeursLien = {"idMpivavaka", "idMpivavaka"};
            

            String[] colSomme = null;
            
            // Inona no atao manaraka
            // mila ovaina ny libelle
            
            pr.getFormu().getChamp("nom").setLibelle("Nom");
            pr.getFormu().getChamp("prenom").setLibelle("Pr&eacute;nom");
            pr.getFormu().getChamp("datenaissance1").setLibelle("Date naissance min");            
            pr.getFormu().getChamp("datenaissance1").setDefaut( utilitaire.Utilitaire.datetostring( java.sql.Date.valueOf("2000-01-01") ) );
            pr.getFormu().getChamp("datenaissance2").setLibelle("Date naissance max");
            pr.getFormu().getChamp("datenaissance2").setDefaut(utilitaire.Utilitaire.dateDuJour());

            String[] sexes = {"Tous","Homme", "Femme"};            
            String[] sexesValeurs = {"","Homme", "Femme"};

            
            Liste[] list = { new Liste("genre", sexes, sexesValeurs), new Liste("nomFaritra", new Faritra(), "nomFaritra", "nomFaritra") };
            
            pr.getFormu().changerEnChamp(list);
            
            pr.getFormu().getChamp("genre").setLibelle("Genre");
            pr.getFormu().getChamp("nomFaritra").setLibelle("Faritra");
            pr.getFormu().getChamp("addresse").setLibelle("Adresse");            
            pr.getFormu().getChamp("ageActuelle1").setLibelle("Age min");            
            pr.getFormu().getChamp("ageActuelle2").setLibelle("Age max");
            
            pr.creerObjetPage(whatToShow, colSomme);
            
            pr.getTableau().setLien(liens);
            pr.getTableau().setColonneLien(colonne);            
            pr.getTableau().setAttLien(attributLien);            
            pr.getTableau().setValeurLien(valeursLien);
            

            String[] labels = {"Nom", "Pr&eacute;nom", "N&eacute;e le", "Lieu de Naissance", "Genre", "Adresse", "Age", "Faritra"};
            pr.getTableau().setLibelleAffiche(labels);
       
%>

<div class="content-wrapper">
    <div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%= pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtmlRecap());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
</div>

    <%
              }catch(Exception e){
                    e.printStackTrace();
                }
    %>