<%@page import="ligneCredit.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>

<% 
    try {
	    LigneCredit t = new LigneCredit();
        t.setNomTable("lignecreditlib");
	    String listeCrt[] = {"id", "val", "desce", "credit", "idtypelc","annnee"};
	    String listeInt[] = {"credit","annnee"};
	    String libEntete[] = {"id", "val", "desce", "annnee","credit", "idTypelclib"};
	    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
	    pr.setTitre("Liste des Ligne Credit");
	    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
	    pr.setLien((String) session.getValue("lien"));
	    pr.setApres("ligne-credit/ligne-credit-liste.jsp");

        affichage.Champ[] liste = new affichage.Champ[1];      
        TypeObjet typelc = new TypeObjet();
        typelc.setNomTable("typelc");
        liste[0] = new Liste("idTypelc", typelc, "val", "id"); 
    
        pr.getFormu().changerEnChamp(liste);


	    pr.getFormu().getChamp("val").setLibelle("D&eacute;signation");
	    pr.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
	    pr.getFormu().getChamp("credit1").setLibelle("credit Min");
	    pr.getFormu().getChamp("annnee1").setLibelle("Annee Min");
	    pr.getFormu().getChamp("annnee2").setLibelle("Annee Max");

	    pr.getFormu().getChamp("idtypelc").setLibelle("Type");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        
        String libEnteteAffiche[] = {"id", "designation", "description", "annn&eacute;e","credit", "Type"};
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



