<%@page import="annexe.*"%>
<%@page import="annexe.details.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>

<% 
    try {
	    Produit t = new Produit();
        t.setNomTable("Produitlib");
	    String listeCrt[] = {"id", "val", "desce", "prixUnitaire", "idUnite","idTypeProduit"};
	    String listeInt[] = {"prixUnitaire"};
	    String libEntete[] = {"id", "val", "desce", "prixUnitaire", "unitelib","typeProduitlib"};
	    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
	    pr.setTitre("Liste des Produits");
	    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
	    pr.setLien((String) session.getValue("lien"));
	    pr.setApres("annexe/produit-liste.jsp");
	    pr.getFormu().getChamp("val").setLibelle("D&eacute;signation");
	    pr.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
	    pr.getFormu().getChamp("prixUnitaire1").setLibelle("Prix Unitaire Min");
	    pr.getFormu().getChamp("prixUnitaire2").setLibelle("Prix Unitaire Max");

        affichage.Champ[] liste = new affichage.Champ[2];      
        TypeObjet unite = new TypeObjet();
        unite.setNomTable("UNITE");
        liste[0] = new Liste("idUnite", unite, "val", "id");        
        TypeObjet type = new TypeObjet();
        type.setNomTable("TYPEPRODUIT");
        liste[1] = new Liste("idTypeProduit", type, "val", "id");       
        pr.getFormu().changerEnChamp(liste);

	    pr.getFormu().getChamp("idUnite").setLibelle("Unite");
	    pr.getFormu().getChamp("idTypeProduit").setLibelle("Type");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        String lienTableau[] = {pr.getLien() + "?but=annexe/produit-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        String libEnteteAffiche[] = {"ID", "D&eacute;signation", "D&eacute;scription", "Prix Unitaire (Ar)", "Unite", "Type"};
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



