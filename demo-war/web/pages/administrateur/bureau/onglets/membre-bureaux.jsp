<%-- 
    Document   : membre-bureaux
    Created on : Oct 19, 2024, 11:23:30 AM
    Author     : sarobidy
--%>

<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="bureaux.membership.MembreBureauxLib"%>

<%
          
    MembreBureauxLib membre = new MembreBureauxLib();
    
    String[] criteres = {};
    String[] intervalles = {};
    String[] entete = { "nomMpivavaka", "descrole", "dateAdmission" };
    
    String id = request.getParameter("idBureaux");
    
    UserEJB user = (UserEJB) session.getValue("u");
    String lien = (String) session.getValue("lien");
    
    PageRecherche pr = new PageRecherche( membre, request, criteres, intervalles, 3, entete, entete.length );
    pr.setUtilisateur(user);
    pr.setLien(lien);
    
    
    pr.setApres("administrateur/bureau/bureau-fiche.jsp&idBureaux=" + id);
    
    pr.setAWhere(" and idBureaux ='" + id + "'");
    pr.setNpp(10);
    pr.creerObjetPage(entete, null );
    

%>

<div class="box-body">
    <%  
        String libEnteteAffiche[] =  {"Nom Croyant", "Role","A rejoint le"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        pr.getTableau().getData();
        if (pr.getTableau().getHtml() != null) {
            out.println(pr.getTableau().getHtml());
        } else {
    %><center><h4>Aucune donne trouvee</h4></center><%
        }


        %>
</div>
