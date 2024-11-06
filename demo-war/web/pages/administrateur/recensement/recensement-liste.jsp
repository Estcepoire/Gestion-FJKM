<%-- 
    Document   : recensement-liste
    Created on : Nov 6, 2024, 7:58:44 PM
    Author     : sarobidy
--%>
<%@page import="affichage.PageRecherche"%>
<%@page import="recensement.Recensement"%>
<%@page import="user.UserEJB"%>
<%
    try{
        UserEJB user = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");

        String titre = "Liste des Recensements";
        Recensement role = new Recensement(); // Classe de Mapping

        String[] criterials = {"designation", "annee", "nombre"};
        String[] intervals = {"annee", "nombre"};
        String[] whatToShow = {"annee", "designation", "nombre"};

        PageRecherche pageRecherche = new PageRecherche( role, request, criterials, intervals, 3, whatToShow, whatToShow.length );
        pageRecherche.setTitre(titre);
        pageRecherche.setUtilisateur(user);
        pageRecherche.setLien(lien);
        pageRecherche.setApres("administrateur/recensement/recensement-liste.jsp");

        pageRecherche.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pageRecherche.getFormu().getChamp("annee1").setLibelle("Ann&eacute;e min");
        pageRecherche.getFormu().getChamp("annee1").setDefaut(utilitaire.Utilitaire.getAnneeEnCours());
        pageRecherche.getFormu().getChamp("annee2").setDefaut(utilitaire.Utilitaire.getAnneeEnCours());
        
        pageRecherche.getFormu().getChamp("annee2").setLibelle("Ann&eacute;e max");
         pageRecherche.getFormu().getChamp("nombre1").setLibelle("Total min");
        pageRecherche.getFormu().getChamp("nombre2").setLibelle("Total max");

        String[] colSomme = null;
        pageRecherche.creerObjetPage(whatToShow, colSomme);

        String[] labels = {"Ann&eacute;e", "D&eacute;signation", "Totale" };
        pageRecherche.getTableau().setLibelleAffiche(labels);

        String[] links = { pageRecherche.getLien() + "?but=administrateur/recensement/recensement-fiche.jsp" };
        String[] linksColumn = { "annee" }; // les colonnes pour mettre les liens
        String[] attribute = { "idReportCroyant" };
        String[] valeurLien = { "idReportCroyant" };

        pageRecherche.getTableau().setLien(links);
        pageRecherche.getTableau().setColonneLien(linksColumn);
        pageRecherche.getTableau().setAttLien(attribute);
        pageRecherche.getTableau().setValeurLien(attribute);
        
%>


<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pageRecherche.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%= pageRecherche.getLien()%>?but=<%= pageRecherche.getApres() %>" method="post">
            <%
                out.println(pageRecherche.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            out.println(pageRecherche.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pageRecherche.getTableau().getHtml());
            out.println(pageRecherche.getBasPage());
        %>
    </section>
</div>



<%
    }catch(Exception e){
        e.printStackTrace();
    }

%>
