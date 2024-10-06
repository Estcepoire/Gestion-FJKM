<%-- 
    Document   : liste
    Created on : Oct 6, 2024, 12:24:16 PM
    Author     : sarobidy
--%>

<%@page import="affichage.PageRecherche"%>
<%@page import="annexe.Faritra"%>
<%
        Faritra faritra = new Faritra();
        
        String[] criteres = {"nomFaritra"};
        String[] intervalles= {};
        String[] whatToShow = {"idFaritra", "nomFaritra"};
        
        PageRecherche pr = new PageRecherche(faritra, request, criteres, intervalles, 3, whatToShow, whatToShow.length);
        pr.setUtilisateur( (user.UserEJB) session.getValue("u") );
        pr.setLien( (String) session.getValue("lien") );
         
        pr.setTitre(" Liste des Faritra ");
        
        pr.setApres("administrateur/annexe/faritra/liste.jsp");
        pr.getFormu().getChamp("nomFaritra").setLibelle("Nom Faritra");
        
        String[] colSomme = null;
        pr.creerObjetPage(whatToShow, colSomme);
        
        String[] labels = {"Identifiant", "Nom Faritra"};
        pr.getTableau().setLibelleAffiche(labels);
        
        String[] liens = { pr.getLien() + "?but=administrateur/annexe/faritra/fiche.jsp" };
        String[] colonnes = {"idFaritra"};
        
        pr.getTableau().setColonneLien(colonnes);
        pr.getTableau().setLien(liens);


%>


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
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>