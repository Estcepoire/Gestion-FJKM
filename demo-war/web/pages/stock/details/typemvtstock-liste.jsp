<%@page import="stock.*"%>
<%@page import="stock.details.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>

<% 
    try {
	    TypeMvtStock t = new TypeMvtStock();
	    String listeCrt[] = {"id", "val", "desce"};
	    String listeInt[] = {};
	    String libEntete[] = {"id", "val", "desce"};
	    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
	    pr.setTitre("Liste des Types de Mouvement de stock");
	    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
	    pr.setLien((String) session.getValue("lien"));
	    pr.setApres("stock/details/typemvtstock-liste.jsp");
	    pr.getFormu().getChamp("val").setLibelle("D&eacute;signation");
        pr.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        String libEnteteAffiche[] = {"ID", "D&eacute;signation", "D&eacute;scription"};
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
        %>
        <br>
    </section>


</div>


<%	
    } catch (Exception e) {
        e.printStackTrace();
    }
%>



