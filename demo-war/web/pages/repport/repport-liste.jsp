<%@page import="repport.*"%>
<%@page import="annexe.details.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>

<% 
    try {
	    Repport t = new Repport();
        t.setNomTable("reportcaisselib");
	    String listeCrt[] = {"id", "idcaisse", "montant", "daty"};
	    String listeInt[] = {"montant","daty"};
	    String libEntete[] = {"id", "idcaisselib", "montanttheorique", "montant", "daty","remarque"};

	    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
	    pr.setTitre("Liste des Repport de caisse");

	    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
	    pr.setLien((String) session.getValue("lien"));
	    pr.setApres("repport/repport-liste.jsp");

        affichage.Champ[] liste = new affichage.Champ[1];
        TypeObjet caisse = new TypeObjet();
        caisse.setNomTable("caisse");
        liste[0] = new Liste("idCaisse", caisse, "val", "id");

        pr.getFormu().changerEnChamp(liste);

	    pr.getFormu().getChamp("montant1").setLibelle("Montant min");
	    pr.getFormu().getChamp("montant2").setLibelle("Montant max");

	    pr.getFormu().getChamp("daty1").setLibelle("Montant max");
	    pr.getFormu().getChamp("daty2").setLibelle("Montant max");

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        String lienTableau[] = {pr.getLien() + "?but=repport/repport-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        String libEnteteAffiche[] = {"id", "Caisse", "montant theorique", "montant", "date","remarque"};
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



