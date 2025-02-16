<%-- 
    Document   : choix-mpandray-multiple
    Created on : Oct 26, 2024, 9:40:04 AM
    Author     : sarobidy
--%>

<%@page import="affichage.PageRechercheChoix"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="croyance.MpivavakaLib"%>
<%
         
        MpivavakaLib mpivavaka = new MpivavakaLib();
        String champReturn = request.getParameter("champReturn");
        
        String[] criteres = {};
        String[] intervalles = {};
        String[] entetes = {"idMpivavaka","nomComplet", "genre", "etat"};
        
        
        String lien = (String) session.getValue("lien");
        UserEJB u = (UserEJB) session.getValue("u");
        
        PageRechercheChoix pr = new PageRechercheChoix( mpivavaka, request, criteres, intervalles, 3, entetes, entetes.length );
        pr.setTitre("Selectionnez les mpivavaka");
        pr.setUtilisateur(u);
        pr.setLien(lien);
        pr.setApres("croyance/choix/choix-mpandray-multiple.jsp");
        
        String[] colSomme = null;
        pr.creerObjetPage(entetes, colSomme);
        
        MpivavakaLib[] mps = (MpivavakaLib[]) pr.getTableau().getData();
        for( MpivavakaLib m : mps ){
            m.setValColLibelle(m.getNomComplet());
        }
        
        pr.getTableau().setData(mps);
        
        String[] libelleAffiches = {"ID","Nom et Pr&eacute;nom(s)", "Genre", "etat"};
        pr.getTableau().setLibeEntete(libelleAffiches);
        

%>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= pr.getTitre() %></title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1><%= pr.getTitre() %></h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=champReturn%>" method="post" name="fcdetailsliste" id="fcdetailsliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <form action="croyance/choix/apresChoixMpandray.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% 
                        
                        out.println(pr.getTableau().getHtmlWithMultipleCheckbox()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../../elements/js.jsp'/>
    </body>
</html>


