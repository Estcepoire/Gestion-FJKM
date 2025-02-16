<%@page import="consommation.*"%>
<%@page import="annexe.details.*"%>
<%@page import="user.*"%>
<%@page import="bean.*"%>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<% 
    try {
        Consommation consommation = new Consommation();
        consommation.setNomTable("consommationlib");
        String[] listeCrt = {"id", "val", "description", "daty", "itypeconsommation"};
        String[] listeInt = {"daty"};
        String[] libEntete = {"id", "val", "description", "daty", "itypeconsommationlib"};

        PageRecherche pr = new PageRecherche(consommation, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setTitre("Liste des Consommations");

        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("consommation/consommation-liste.jsp");

        affichage.Champ[] liste = new affichage.Champ[1];
        TypeObjet typeConsommation = new TypeObjet();
        typeConsommation.setNomTable("typeconsommation");
        liste[0] = new Liste("itypeconsommation", typeConsommation, "val", "id");

        pr.getFormu().changerEnChamp(liste);

        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());

        // Configure the table columns and links
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        String[] lienTableau = {pr.getLien() + "?but=consommation/consommation-fiche.jsp"};
        String[] colonneLien = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        
        String[] libEnteteAffiche = {"ID", "Designation", "Description", "Date", "Type de Consommation"};
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
