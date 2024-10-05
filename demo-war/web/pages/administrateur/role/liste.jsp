<%@page import="utilisateur.Role" %>
<%@page import="affichage.PageRecherche" %>
<%@page import="user.UserEJB" %>

<%
    try{
        UserEJB user = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");

        String titre = "Liste des Roles";
        Role role = new Role(); // Classe de Mapping

        String[] criterials = {"idrole", "descrole"};
        String[] intervals = {};
        String[] whatToShow = {"idrole", "descrole", "rang"};

        PageRecherche pageRecherche = new PageRecherche( role, request, criterials, intervals, 3, whatToShow, whatToShow.length );
        pageRecherche.setTitre(titre);
        pageRecherche.setUtilisateur(user);
        pageRecherche.setLien(lien);
        pageRecherche.setApres("administrateur/role/liste.jsp");

        pageRecherche.getFormu().getChamp("idrole").setLibelle("Identifiant");
        pageRecherche.getFormu().getChamp("descrole").setLibelle("D&eacute;scription");

        String[] colSomme = null;
        pageRecherche.creerObjetPage(whatToShow, colSomme);

        String[] labels = {"Identifiant", "D&eacute;scription", "Rang" };
        pageRecherche.getTableau().setLibelleAffiche(labels);

        String[] links = { pageRecherche.getLien() + "?but=administrateur/role/fiche.jsp" };
        String[] linksColumn = { "idrole" }; // les colonnes pour mettre les liens
        String[] attribute = { "id" };
        String[] valeurLien = { "id" };

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