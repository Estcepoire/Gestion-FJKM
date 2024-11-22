<%-- 
    Document   : liste
    Created on : Oct 21, 2024, 11:30:25 PM
    Author     : sarobidy
--%>

<%@page import="affichage.PageRecherche"%>
<%@page import="user.UserEJB"%>
<%@page import="evenement.TypeEvenement"%>
<%
          
    TypeEvenement type = new TypeEvenement();
    
    String[] criteres = {"val", "desce"};
    String[] intervalles = {};
    String[] entetes = {"id", "val", "desce"};
    
    String lien = (String) session.getValue("lien");
    UserEJB u = (UserEJB) session.getValue("u");
    
    PageRecherche pr = new PageRecherche(type, request, criteres, intervalles, 3, entetes, entetes.length);
    pr.setUtilisateur(u);
    pr.setLien(lien);
    pr.setApres("administrateur/typeevenement/typeevenement-liste.jsp");
    
    pr.getFormu().getChamp("val").setLibelle("Type");
    pr.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
    
    String[] colsomme = null;
    
    pr.creerObjetPage(entetes, colsomme);
    String[] aff = {"Identifiant", "Type d&apos;evenement", "Description"};
    pr.getTableau().setLibelleAffiche(aff);
    
    String[] colonnes = {"id"};
    String[] liens = { pr.getLien() + "?but=administrateur/typeevenement/typeevenement-fiche.jsp" };
    
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
                out.println(pr.getFormu().getHtmlEnsembleVaovao());
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
