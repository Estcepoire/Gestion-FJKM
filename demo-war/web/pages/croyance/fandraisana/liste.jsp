<%-- 
    Document   : liste
    Created on : Oct 12, 2024, 6:05:34 AM
    Author     : sarobidy
--%>

<%@page import="croyance.fandraisana.MpandrayLib"%>
<%@page import="annexe.Faritra"%>
<%@page import="croyance.fandraisana.Mpandray" %>
<%@page import="affichage.*" %>
<%@page import="user.UserEJB" %>

<%
        try{
            MpandrayLib mapping = new MpandrayLib();
            UserEJB user = (UserEJB) session.getValue("u");
            String lien = (String) session.getValue("lien");

            String[] criteres = {"nomComplet", "numeroMpandray", "dateNandraisana", "genre", "nomPromotion"};
            String[] intervalles = { "dateNandraisana"};
            String[] whatToShow = {"nomComplet", "numeroMpandray", "dateNandraisana", "genre" , "nomPromotion"};

            PageRecherche pr = new PageRecherche( mapping, request, criteres, intervalles, 3, whatToShow, whatToShow.length );
            pr.setTitre("Liste des Mpandray");
            pr.setUtilisateur(user);
            pr.setLien(lien);
            pr.setApres("croyance/fandraisana/liste.jsp");
            
            String[] liens = { pr.getLien() +  "?but=croyance/fandraisana/fiche.jsp", pr.getLien() +  "?but=croyance/fandraisana/fiche.jsp"};
            String[] colonne = {"nomComplet", "numeroMpandray"};
            String[] attributLien = {"idMpivavaka", "idMpivavaka"};            
            String[] valeursLien = {"idMpivavaka", "idMpivavaka"};
            

            String[] colSomme = null;
            
            // Inona no atao manaraka
            // mila ovaina ny libelle
            
            pr.getFormu().getChamp("nomComplet").setLibelle("Nom Complet");
            pr.getFormu().getChamp("numeroMpandray").setLibelle("Num&eacute;ro mpandray");
            pr.getFormu().getChamp("nomPromotion").setLibelle("Nom Promotion");
            pr.getFormu().getChamp("dateNandraisana1").setLibelle("Date Fandraisana min");            
            pr.getFormu().getChamp("dateNandraisana1").setDefaut( utilitaire.Utilitaire.datetostring( java.sql.Date.valueOf("2000-01-01") ) );
            pr.getFormu().getChamp("dateNandraisana2").setLibelle("Date Fandraisana max");
            pr.getFormu().getChamp("dateNandraisana2").setDefaut(utilitaire.Utilitaire.dateDuJour());

            String[] sexes = {"Tous","Homme", "Femme"};            
            String[] sexesValeurs = {"","Homme", "Femme"};

            
            Liste[] list = { new Liste("genre", sexes, sexesValeurs), new Liste("nomFaritra", new Faritra(), "nomFaritra", "nomFaritra") };
            
            pr.getFormu().changerEnChamp(list);
            
            pr.getFormu().getChamp("genre").setLibelle("Genre");
            
            
            pr.creerObjetPage(whatToShow, colSomme);
            
            pr.getTableau().setLien(liens);
            pr.getTableau().setColonneLien(colonne);            
            pr.getTableau().setAttLien(attributLien);            
            pr.getTableau().setValeurLien(valeursLien);
            

            String[] labels = {"Nom", "Num&eacute;ro", "Date Fandraisana", "Genre", "Promotion"};
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