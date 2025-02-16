<%-- 
    Document   : cotisation-analyse-mois
    Created on : Nov 4, 2024, 12:24:08 PM
    Author     : sarobidy
--%>
<%@page import="affichage.PageRecherche"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%@page import="cotisation.Cotisation"%>
<%
          
    Cotisation cotisation = new Cotisation();
    cotisation.setNomTable("v_paiement_cotisation_lib_montant");
    
    String[] crt = {"annee"};
    String[] ints = {"annee"};
    
    String annee = ( request.getParameter("annee") != null ) ? request.getParameter("annee") : utilitaire.Utilitaire.getAnneeEnCours();
   
    String[] entetes = {"annee", "moisLib", "designation", "montant"};
    PageRecherche pr = new PageRecherche(cotisation, request, crt, ints, 3, entetes, entetes.length);
    pr.setTitre("Analyse des cotisations de l'an " + annee);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.getFormu().getChamp("annee1").setDefaut(  annee  );
    pr.getFormu().getChamp("annee2").setDefaut(  annee  );
    pr.getFormu().getChamp("annee1").setLibelle( "Annee Min"  );
    pr.getFormu().getChamp("annee2").setLibelle(  "Annee Max"  );
    
    String[] colSomme = null;
    
    pr.creerObjetPage(  entetes, colSomme );
    

    String[] rajoutLien = {"annee"};
    String[] lien = { pr.getLien() + "?but=cotisation/cotisation-fiche.jsp" };
    String[] colLien = {"moisLib"};
    String[] attLien = {"mois"};
    String[] attLienValue = {"mois"};
    
    pr.getTableau().setColonneLien(colLien);
    pr.getTableau().setLien(lien);
    pr.getTableau().setAttLien(attLien);
    pr.getTableau().setValeurLien(attLienValue);
    pr.getTableau().setUrlLien(rajoutLien);
    pr.getTableau().setUrlLienAffiche(rajoutLien);
    
        pr.setApres("cotisation/cotisation-analyse-mois.jsp");
    
    String[] libelles = {"Annee", "Mois", "D&eacute;signation", "Montant Totale"};
    pr.getTableau().setLibelleAffiche(libelles);

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="<%= pr.getApres() %>" />
<%--            <%out.println(pr.getFormu().getHtmlEnsemble());%>--%>       <%= pr.getFormu().getHtmlEnsembleVaovao()%>
        </form>
        <%

//            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
            out.println(pr.getTableau().getHtmlVaovao());
//            out.println(pr.getBasPage());
        %>
    </section>
</div>
