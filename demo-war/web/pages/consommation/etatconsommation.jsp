<%@page import="consommation.*"%>
<%@page import="annexe.*"%>
<%@page import="user.*"%>
<%@page import="bean.*"%>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<% 
    try {
        ConsommationDate consommation = new ConsommationDate();
        String[] listeCrt = {"id", "mois", "idProduitlib", "montant","annee"};
        String[] listeInt = {"mois","montant","annee"};
        String[] libEntete = {"id","idProduitlib", "montant"};

        PageRecherche pr = new PageRecherche(consommation, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setTitre("Liste des montant Consommations");

        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("consommation/etatconsommation.jsp");

        affichage.Liste[] liste = new affichage.Liste[2];

        liste[0] = new Liste("mois1");
        liste[0].makeListeMois();

        liste[1] = new Liste("mois2");
        liste[1].makeListeMois();

        pr.getFormu().changerEnChamp(liste);

        pr.getFormu().getChamp("mois1").setLibelle("Mois min");
        pr.getFormu().getChamp("mois2").setLibelle("Mois max");

        pr.getFormu().getChamp("annee1").setLibelle("Ann&eacute;e min");
        pr.getFormu().getChamp("annee2").setLibelle("Ann&eacute;e max");

        pr.getFormu().getChamp("annee1").setDefaut("2024");
        pr.getFormu().getChamp("annee2").setDefaut("2024");

        pr.getFormu().getChamp("idProduitlib").setLibelle("Produit");

        pr.getFormu().getChamp("montant1").setLibelle("Montant min");
        pr.getFormu().getChamp("montant2").setLibelle("Montant max");

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        String[] lienTableau = {};
        String[] colonneLien = {};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        
        String[] libEnteteAffiche = {"ID", "Produit", "Montant"};
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
        <br><br>
        <%
            out.println(pr.getTableauRecap().getHtml());
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



