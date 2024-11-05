<%-- 
    Document   : cotisation-analyse-ans
    Created on : Nov 4, 2024, 8:58:43 AM
    Author     : sarobidy
--%>

<%@page import="affichage.PageRechercheGroupe"%>
<%@page import="cotisation.Cotisation"%>
<%
          
    Cotisation cotisation = new Cotisation();
    cotisation.setNomTable("v_paiement_cotisation_lib_montant");
    
    String[] crt = {};
    String[] ints = {};
    String[] colDefaut = {"annee"};
    String[] colSomme = {"montant"};
    
    PageRechercheGroupe pr = new PageRechercheGroupe(cotisation,  request , crt, ints, 3, colDefaut, colSomme, colDefaut.length, 2);
    pr.setTitre("Analyse des cotisations");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.setOrdre(" order by annee desc");
        pr.setApres("cotisation/cotisation-analyse-ans.jsp");

    
    pr.creerObjetPage();
    pr.getTableau().setGroupe(false);
    
    String[] libelles = {"Ann&eacute;e", "Montant"};
    pr.getTableau().setLibelleAffiche(libelles);
    
    String[] liens = { pr.getLien() + "?but=cotisation/cotisation-analyse-mois.jsp" };
    String[] colLien = {"annee"};
    
    pr.getTableau().setLien(liens);
    pr.getTableau().setColonneLien(colLien);

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="<%= pr.getApres() %>" />
<%--            <%out.println(pr.getFormu().getHtmlEnsemble());%>--%>
        </form>
        <%

//            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
//            out.println(pr.getBasPage());
        %>
    </section>
</div>