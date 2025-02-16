<%@page import="recette.*"%>
<%@page import="user.*"%>
<%@page import="bean.*"%>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<%
    try {
        Recette recette = new Recette();
        recette.setNomTable("v_recette_date");
        String listeCrt[] = {"daty","idtyperecette"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"daty", "idtyperecettelib", "montant"};
        
        PageRecherche pr = new PageRecherche(recette, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        
        pr.setTitre("Liste des Recettes par Date");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("recette/recette-date.jsp");
        
        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());

        affichage.Champ[] liste = new affichage.Champ[1];
        TypeObjet typeRecette = new TypeObjet();
        typeRecette.setNomTable("TYPERECETTE");
        liste[0] = new Liste("idtyperecette", typeRecette, "val", "id");
        pr.getFormu().changerEnChamp(liste);
        
        pr.getFormu().getChamp("idtyperecette").setLibelle("Type de Recette");
        
        String[] colSomme = {"montant"};
        pr.creerObjetPage(libEntete, colSomme);

        String libEnteteAffiche[] = {"Date", "Type de Recette", "Montant (Ar)"};
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
        <%
            out.println(pr.getTableauRecap().getHtml()); %>
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
