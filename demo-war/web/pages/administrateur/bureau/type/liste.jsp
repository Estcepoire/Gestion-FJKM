<%@page import="bureaux.TypeBureau" %>
<%@page import="affichage.PageRecherche" %>
<%@page import="user.UserEJB" %>

<%
    try{
        UserEJB user = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");

        String titre = "Liste des Type de bureaux";
        TypeBureau role = new TypeBureau(); // Classe de Mapping

        String[] criterials = {"val", "desce"};
        String[] intervals = {};
        String[] whatToShow = {"id", "val", "desce"};

        PageRecherche pageRecherche = new PageRecherche( role, request, criterials, intervals, 3, whatToShow, whatToShow.length );
        pageRecherche.setTitre(titre);
        pageRecherche.setUtilisateur(user);
        pageRecherche.setLien(lien);
        pageRecherche.setApres("administrateur/bureau/type/liste.jsp");

        pageRecherche.getFormu().getChamp("val").setLibelle("Type");
        pageRecherche.getFormu().getChamp("desce").setLibelle("D&eacute;scription");

        String[] colSomme = null;
        pageRecherche.creerObjetPage(whatToShow, colSomme);

        String[] labels = {"Identifiant", "Type de Bureaux", "D&eacute;scription" };
        pageRecherche.getTableau().setLibelleAffiche(labels);

        String[] links = { pageRecherche.getLien() + "?but=administrateur/bureau/type/fiche.jsp" };
        String[] linksColumn = { "id" }; // les colonnes pour mettre les liens

        pageRecherche.getTableau().setLien(links);
        pageRecherche.getTableau().setColonneLien(linksColumn);
        
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