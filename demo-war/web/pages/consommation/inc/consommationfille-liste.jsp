<%@page import="consommation.ConsommationFille"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="user.*"%>
<%@page import="bean.*"%>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<%
    try {
        ConsommationFille t = new ConsommationFille();
        t.setNomTable("consommationfillelib");
        String[] listeCrt = {};
        String[] listeInt = {};
        String[] libEntete = {"id", "val", "quantite", "remarque"};

        PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        if (request.getParameter("id") != null) {
            pr.setAWhere(" AND idMere ='" + request.getParameter("id") + "'");
        }

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>

<div class="box-body">
    <%
        String[] libEnteteAffiche = {"ID", "Produit", "Quantité", "Remarque"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        
        if (pr.getTableau().getHtml() != null) {
            out.println(pr.getTableau().getHtml());
        } else {
    %>
            <div style="text-align: center;">
                <h4>Aucune donnée trouvée</h4>
            </div>
    <%
        }
    %>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
