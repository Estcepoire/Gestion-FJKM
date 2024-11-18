<%@page import="ligneCredit.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>

<% 
    try {
        EtatLigne t = new EtatLigne();
        t.setNomTable("v_typelignecredit");
        
        String listeCrt[] = {"id", "annee","idtypelignecredit"};
        String listeInt[] = {"annee"};
        String libEntete[] = {"id", "val", "annee", "idtypelignecreditlib", "totalcredit", "totalrecettes", "totaldepenses", "balance"};

        PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setTitre("Etat des Lignes de Cr&eacute;dit");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("ligne-credit/etatlignecredit.jsp");
        
        
        affichage.Champ[] liste = new affichage.Champ[2];
        
        TypeObjet ligneCredit = new TypeObjet();
        ligneCredit.setNomTable("lignecredit");
        liste[0] = new Liste("id", ligneCredit, "val", "id");

        TypeObjet typeLigneCredit = new TypeObjet();
        typeLigneCredit.setNomTable("TYPELC");
        liste[1] = new Liste("idtypelignecredit", typeLigneCredit, "val", "id");
        
        pr.getFormu().changerEnChamp(liste);
        pr.getFormu().getChamp("idtypelignecredit").setLibelle("Type Ligne de Cr&eacute;dit");
        
        pr.getFormu().getChamp("annee1").setLibelle("Ann&eacute;e min");
        pr.getFormu().getChamp("annee2").setLibelle("Ann&eacute;e  max");
        pr.getFormu().getChamp("annee1").setDefaut("2024");
        pr.getFormu().getChamp("annee2").setDefaut("2024");

        String[] colSomme = null;
        
        pr.creerObjetPage(libEntete, colSomme);

        String libEnteteAffiche[] = {"ID", "Nom", "Ann&eacute;e", "Type Ligne de Cr&eacute;dit", "Total Cr&eacute;dit", "Total Recettes", "Total D&eacute;penses", "Balance"};
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
