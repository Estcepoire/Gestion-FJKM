<%-- 
    Document   : liste
    Created on : Oct 5, 2024, 8:27:14 PM
    Author     : sarobidy
--%>
<%@page import="bureaux.TypeBureau"%>
<%@page import="bureaux.Bureaux"%>
<%@page import="affichage.*" %>
<%@page import="user.UserEJB" %>

<%
          
        Bureaux mapping = new Bureaux();
        mapping.setNomTable("v_bureaux_lib");
        
        String[] criteres = {"nomBureaux", "descriptionBureaux", "dateCreation", "idTypeBureau"};
        String[] intervalles = {"dateCreation"};
        String[] whatToShow = {"nomBureaux", "descriptionBureaux", "dateCreation", "typeBureau"};
        
        PageRecherche pr = new PageRecherche(mapping, request, criteres, intervalles, 3, whatToShow, whatToShow.length);
        UserEJB user = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");
        pr.setApres("administrateur/bureau/liste.jsp");
        pr.setLien(lien);
        pr.setUtilisateur(user);
        pr.setTitre("Liste des Bureaux");
        String[] colSomme = null;
        
        pr.getFormu().getChamp("nomBureaux").setLibelle("Nom");
        pr.getFormu().getChamp("descriptionBureaux").setLibelle("Description");
        
        pr.getFormu().getChamp("dateCreation1").setLibelle("Date de Cr&eacute;ation min");
        pr.getFormu().getChamp("dateCreation2").setLibelle("Date de Cr&eacute;ation max");
        pr.getFormu().getChamp("dateCreation1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateCreation2").setDefaut(utilitaire.Utilitaire.dateDuJour());

        Liste[] listes = new Liste[1];
        listes[0] = new Liste("idTypeBureau", new TypeBureau(), "val", "id");
        
        pr.getFormu().changerEnChamp(listes);
        pr.getFormu().getChamp("idTypeBureau").setLibelle("Type de Bureau");
        
        pr.creerObjetPage(whatToShow, colSomme);
        
        String[] labels = {"Nom", "Description", "Cr&eacute;&eacute; le", "Type"};
        pr.getTableau().setLibelleAffiche(labels);
        
        String[] liens = {pr.getLien() + "?but=administrateur/bureau/fiche.jsp"};
        String[] colonnes = {"nomBureaux"};
        String[] attributsLien = {"idBureaux"};
        String[] valeurLien = {"idBureaux"};
        
        pr.getTableau().setLien(liens);
        pr.getTableau().setColonneLien(colonnes);
        pr.getTableau().setAttLien(attributsLien);
        pr.getTableau().setValeurLien(valeurLien);


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
