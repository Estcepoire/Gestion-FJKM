<%-- 
    Document   : liste-evenements
    Created on : Oct 27, 2024, 8:37:21 AM
    Author     : sarobidy
--%>

<%@page import="evenement.EvenementLib"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="user.UserEJB"%>
<%@page import="evenement.Evenement"%>
<%
          EvenementLib ev = (EvenementLib) request.getAttribute("evenement");
          UserEJB u = (UserEJB) session.getValue("u");
          String lien = (String) session.getValue("lien");
          
          Evenement e = new Evenement();
          String[] crt = {};
          String[] ints = {};
          String[] entetes = {"idEvenement", "description", "dateDebutEvenement", "heureDebut", "dateFinEvenement", "heureFin"};
          PageRecherche pr = new PageRecherche( e, request, crt, ints, 3, entetes, entetes.length );
          pr.setUtilisateur(u);
          pr.setLien(lien);
          pr.setAWhere(" and idMere = '" + ev.getIdEvenement() + "'");
          pr.setNpp(10);
          pr.creerObjetPage(entetes, null);
          
    
%>

<div class="box-body">
    <%
        String[] lienTableau = {pr.getLien() + "?but=evenement/evenement-fiche.jsp"};
        String[] colonneLien = {"idEvenement"};
        pr.getTableau().setColonneLien(colonneLien);
        pr.getTableau().setLien(lienTableau);
        String[] libelles = {"ID", "D&eacute;scription", "Date d&eacute;but", "Heure D&eacute;but", "Date Fin", "Heure Fin"};
        pr.getTableau().setLibelleAffiche(libelles);
        Evenement[] liste=(Evenement[]) pr.getTableau().getData();
        if(pr.getTableau().getHtml() != null)
            out.println(pr.getTableau().getHtml());
        else
            {
               %><center><h4>Aucune donnée trouvé</h4></center><%
        }
    %>
            
</div>