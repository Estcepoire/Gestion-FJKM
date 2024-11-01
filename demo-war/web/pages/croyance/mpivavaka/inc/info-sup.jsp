<%-- 
    Document   : info-sup
    Created on : Nov 1, 2024, 1:52:54 PM
    Author     : sarobidy
--%>

<%@page import="user.UserEJB"%>
<%@page import="croyance.information.InformationMpivavaka"%>
<%@page import="affichage.PageRecherche"%>
<%
          InformationMpivavaka inf = new InformationMpivavaka();
          String[] crt = {};
          String[] ints = {};
          String[] entetes = {"information", "valeur"};
          
          UserEJB user = (UserEJB) session.getValue("u");
          String lien = (String) session.getValue("lien");
          
          inf.setNomTable("v_mpivavaka_info_lib");
          
          PageRecherche pr = new PageRecherche( inf, request,  crt, ints, 3, entetes, entetes.length);
          pr.setUtilisateur(user);
          pr.setLien(lien);
          pr.setAWhere(" and idMpivavaka = '" + request.getParameter("idMpivavaka") + "'");
          String[] colSomme = null;
          pr.setNpp(10);
          pr.creerObjetPage(entetes, colSomme);
%>


<div class="box-body">
    <%
        
        String[] libelles = {"Information", "valeur"};
        pr.getTableau().setLibelleAffiche(libelles);
        if(pr.getTableau().getHtml() != null)
            out.println(pr.getTableau().getHtml());
        else
            {
               %><center><h4>Aucune donnée trouvé</h4></center><%
        }
    %>
            
</div>