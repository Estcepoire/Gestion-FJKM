<%@page import="facture.*"%>
<%@page import="facture.details.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%@ page import="recette.*" %>

<% 
    try {
	    Recette t = new Recette();
        t.setNomTable("v_Recettelib");
	    String listeCrt[] = {"id", "designation","daty", "idCaisse",};
	    String listeInt[] = {"daty"};
	    String libEntete[] = {"id", "designation","daty", "montant","idCaisselib"};
	    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
	    pr.setTitre("Liste des Facture");
	    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
	    pr.setLien((String) session.getValue("lien"));
	    pr.setApres("recette/recette-liste.jsp");
	    pr.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
	    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
	    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());

        affichage.Champ[] liste = new affichage.Champ[1];      
        TypeObjet unite = new TypeObjet();
        unite.setNomTable("Caisse");
        liste[0] = new Liste("idCaisse", unite, "val", "id");    
        pr.getFormu().changerEnChamp(liste);

	    pr.getFormu().getChamp("idCaisse").setLibelle("Caisse");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        String lienTableau[] = {pr.getLien() + "?but=recette/recette-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        String libEnteteAffiche[] = {"ID", "D&eacute;signation", "Date", "Montant (Ar)", "Caise"};
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



