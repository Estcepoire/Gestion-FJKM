
<%@page import="annexe.details.*"%>
<%@page import="bean.*, user.*, utilitaire.*, affichage.*"%>
<% 
    Unite modele = new Unite(); 
    String listeCrt[] = {"id", "val", "desce"};
    String listeInt[] = null;
    String libEntete[] = {"id", "val", "desce"};

    PageRecherche pr = new PageRecherche(modele, request, listeCrt, listeInt, 5, libEntete, 5);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    pr.getFormu().getChamp("val").setLibelle("Designation");
    pr.getFormu().getChamp("desce").setLibelle("Description");

    pr.setApres("annexe/details/unite-liste.jsp");
    pr.creerObjetPage(libEntete);
    
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Mod&egrave;le</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=annexe/details/unite-liste.jsp" method="post" name="modele" id="modele">
            <%
                pr.getFormu().makeHtml();
                out.println(pr.getFormu().getHtml());
            %>   
        </form>
            <%  
               out.println(pr.getTableauRecap().getHtmlRecap());
            %>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Designation", "Description"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getHtmlEnsemble());
        %>
    </section>
</div>

