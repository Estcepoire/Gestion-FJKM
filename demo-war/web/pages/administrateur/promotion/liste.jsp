<%-- 
    Document   : liste
    Created on : Oct 9, 2024, 7:58:58 PM
    Author     : sarobidy
--%>

<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="croyance.promotion.Promotion"%>

<%
          
    Promotion promotion = new Promotion();
    
    String[] criteres = {"nomPromotion", "anneePromotion"};
    String[] intervalles = {"anneePromotion"};
    String[] entetes = {"nomPromotion", "anneePromotion", "dateSortie"};
    
    UserEJB user = (UserEJB) session.getValue("u");
    String lien = (String) session.getValue("lien");
    
    PageRecherche pr = new PageRecherche( promotion, request, criteres, intervalles, 3, entetes, entetes.length );
    pr.setUtilisateur(user);
    pr.setLien(lien);
    
    pr.setApres("administrateur/promotion/liste.jsp");
    String[] colSomme = null;
    
    pr.getFormu().getChamp("nomPromotion").setLibelle("Nom de la Promotion");
    pr.getFormu().getChamp("anneePromotion1").setLibelle("Annee Promotion Min");
    pr.getFormu().getChamp("anneePromotion2").setLibelle("Annee Promotion Max");
    pr.getFormu().getChamp("anneePromotion1").setDefaut( "2000" );
    pr.getFormu().getChamp("anneePromotion2").setDefaut( utilitaire.Utilitaire.getAnneeEnCours() );
    
    
    
    pr.setTitre("Liste des Promotions");
    
    pr.creerObjetPage(entetes, colSomme);
    
    String[] labels = {"Promotion", "Annee", "Date de Sortie"};
    pr.getTableau().setLibelleAffiche(labels);
    
    String[] liens = { pr.getLien() + "?but=administrateur/promotion/fiche.jsp" };
    String[] colonnes = {"nomPromotion"};
    String[] attributes = {"idPromotion"};
    String[] values = {"idPromotion"};
    
    pr.getTableau().setAttLien(attributes);
    pr.getTableau().setColonneLien(colonnes);
    pr.getTableau().setValeurLien(values);
    pr.getTableau().setLien(liens);

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%= pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
