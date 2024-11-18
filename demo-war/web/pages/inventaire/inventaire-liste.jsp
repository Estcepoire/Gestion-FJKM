<%@page import="inventaire.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<% 
    try {
	    Inventaire t = new Inventaire();
        t.setNomTable("inventairelib");
	    String listeCrt[] = {"id", "daty", "designation","remarque"};
	    String listeInt[] = {"daty"};
	    String libEntete[] = {"id", "daty", "designation","remarque"};
	    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
	    pr.setTitre("Liste des Inventaires");
	    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
	    pr.setLien((String) session.getValue("lien"));
	    pr.setApres("inventaire/inventaire-liste.jsp");
	    pr.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
	    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
	    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        String lienTableau[] = {pr.getLien() + "?but=inventaire/inventaire-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        String libEnteteAffiche[] = {"ID", "Date","D&eacute;signation", "Remarques"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <br>
        <br>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
        <br>
    </section>
</div>
<%	
    } catch (Exception e) {
        e.printStackTrace();
    }
%>



