<%-- 
    Document   : liste
    Created on : Oct 6, 2024, 12:24:16 PM
    Author     : sarobidy
--%>

<%@page import="annexe.InformationAnnexe"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="annexe.Faritra"%>
<%
        InformationAnnexe info = new InformationAnnexe();
        
        String[] criteres = {"val", "desce"};
        String[] intervalles= {};
        String[] whatToShow = {"id", "val", "desce"};
        
        PageRecherche pr = new PageRecherche(info, request, criteres, intervalles, 3, whatToShow, whatToShow.length);
        pr.setUtilisateur( (user.UserEJB) session.getValue("u") );
        pr.setLien( (String) session.getValue("lien") );
         
        pr.setTitre(" Liste des Information annexe ");
        
        pr.setApres("administrateur/annexe/information/information-liste.jsp");
        pr.getFormu().getChamp("val").setLibelle("Lib&eacute;lle");
        pr.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
        
        String[] colSomme = null;
        pr.creerObjetPage(whatToShow, colSomme);
        
        String[] labels = {"Identifiant", "Lib&eacute;lle", "D&eacute;scription"};
        pr.getTableau().setLibelleAffiche(labels);
        
        String[] liens = { pr.getLien() + "?but=administrateur/annexe/information/information-fiche.jsp" };
        String[] colonnes = {"id"};
        
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