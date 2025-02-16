<%@page import="facture.*"%>
<%@page import="facture.details.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<% 
    try {
	    FactureFournisseur t = new FactureFournisseur();
        t.setNomTable("facturefournisseur_cpl");
	    String listeCrt[] = {"id", "val","daty", "idTiers",};
	    String listeInt[] = {"daty"};
	    String libEntete[] = {"id", "val","daty", "montant","idtierslib"};
	    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
	    pr.setTitre("Liste des Facture");
	    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
	    pr.setLien((String) session.getValue("lien"));
	    pr.setApres("facture/facture-fournisseur-liste.jsp");
	    pr.getFormu().getChamp("val").setLibelle("D&eacute;signation");
	    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
	    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());

        affichage.Champ[] liste = new affichage.Champ[1];      
        TypeObjet unite = new TypeObjet();
        unite.setNomTable("TIERS");
        liste[0] = new Liste("idTiers", unite, "val", "id");    
        pr.getFormu().changerEnChamp(liste);

	    pr.getFormu().getChamp("idTiers").setLibelle("Tiers");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        String libEnteteAffiche[] = {"ID", "D&eacute;signation", "Date", "Montant (Ar)", "Tiers"};
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



