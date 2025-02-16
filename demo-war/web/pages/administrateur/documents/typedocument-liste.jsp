<%-- 
    Document   : typedocument-liste
    Created on : Nov 18, 2024, 12:12:42 PM
    Author     : sarobidy
--%>

<%@page import="affichage.PageRecherche"%>
<%@page import="user.UserEJB"%>
<%@page import="document.TypeDocument"%>
<%

    TypeDocument tp = new TypeDocument();
    String[] crts = { "val", "desce" };
    String[] ints = {};
    String[] entetes = {"id", "val", "desce"};
    
    String lien = (String) session.getValue("lien");
    UserEJB u = (UserEJB) session.getAttribute("u");
    
    PageRecherche pr = new PageRecherche(tp, request, crts, ints, 3, entetes, entetes.length);
    pr.setUtilisateur(u);
    pr.setLien(lien);
    
    String[] colSomme = null;
    pr.creerObjetPage(entetes, colSomme);
    
    String[] affichages = {"ID", "Type de Fichier", "D&eacute;scription"};
    pr.getTableau().setLibelleAffiche(affichages);
    
    String[] colLien = {"id"};
    String[] liens = {pr.getLien()+"?but=administrateur/documents/typedocument-fiche.jsp"};
    pr.getTableau().setColonneLien(colLien);
    pr.getTableau().setLien(liens);
    
    pr.setTitre("Liste des Types de fichiers");


%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="<%= pr.getApres() %>" />
            <%out.println(pr.getFormu().getHtmlEnsembleVaovao());%>
        </form>
        <br/>
        <%= pr.getTableau().getHtmlVaovao()  %>
    </section>
</div>