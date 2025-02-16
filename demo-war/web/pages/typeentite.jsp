<%-- 
    Document   : liste-entiteissement
    Created on : 8 juil. 2016, 16:09:57
    Author     : Paul M.
--%>

<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%@page import="affichage.Liste"%>
<%@page import="affichage.PageRecherche"%>

<%
    TypeObjet entite = new TypeObjet();
    entite.setNomTable("TYPEENTITE");
    String listeCrt[] = {"id", "val", "desce"};
    String listeInt[] = {};
    String libEntete[] = {"id", "val", "desce"};
    
    PageRecherche pr = new PageRecherche(entite, request, listeCrt, listeInt, 3 , libEntete, 3);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("val").setLibelle("Valeur");
    pr.getFormu().getChamp("desce").setLibelle("Description");

    pr.setApres("typeentite.jsp");
    

    pr.creerObjetPage(libEntete);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Type entite</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=typeentite.jsp" method="post" name="listeme" id="listeme">
            <%
            out.println(pr.getFormu().getHtmlEnsembleNew());
            %>
        </form>
        <%  
            out.println(pr.getTableauRecap().getHtmlRecap());
        %>
        <br>
        <%
            String libEnteteAffiche[] = {"ID", "Valeur", "Description"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtmlAvecOrdre());
            out.println(pr.getPagination());
            
        %>
    </section>
</div>
