<%@page import="famille.*"%>
<%@page import="facture.details.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<% 
    try {
	    Famille t = new Famille();
        t.setNomTable("famillelib");
	    String listeCrt[] = {"id", "val","idFaritra",};
	    String listeInt[] = {};
	    String libEntete[] = {"id", "val","desce", "idFaritralib"};
	    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
	    pr.setTitre("Liste des Famille");
	    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
	    pr.setLien((String) session.getValue("lien"));

	    pr.setApres("famille/famille-liste.jsp");
	    pr.getFormu().getChamp("val").setLibelle("D&eacute;signation");

        affichage.Champ[] liste = new affichage.Champ[1]; 

        TypeObjet faritra = new TypeObjet();
        faritra.setNomTable("faritra");
        liste[0] = new Liste("idFaritra", faritra, "val", "id");  

        pr.getFormu().changerEnChamp(liste);

	    pr.getFormu().getChamp("idFaritra").setLibelle("Faritra");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        String lienTableau[] = {pr.getLien() + "?but=famille/famille-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        String libEnteteAffiche[] = {"ID", "D&eacute;signation", "Description", "Faritra"};
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



