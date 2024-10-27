<%-- 
    Document   : liste-participant
    Created on : Oct 27, 2024, 8:05:26 AM
    Author     : sarobidy
--%>

<%@page import="evenement.EvenementLib"%>
<%@page import="croyance.MpivavakaLib"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="evenement.participation.Participation"%>
<%@page import="evenement.Evenement"%>
<%
          // Alaina ilay evenement aloha
          EvenementLib evenement = (EvenementLib) request.getAttribute("evenement");
          // Rehefa azo de alaina ny participant rehetra
         MpivavakaLib p = new MpivavakaLib();
         p.setNomTable("v_participation_croyant");
          UserEJB u = (UserEJB) session.getValue("u");
          String lien = (String) session.getValue("lien");
          String[] crt = {};
          String[] ints = {};
          String[] entetes = { "nomComplet", "ageActuelle", "genre"};
          
          PageRecherche pr = new PageRecherche(p, request, crt, ints, 3, entetes, entetes.length);
          pr.setUtilisateur(u);
          pr.setLien(lien);
          pr.setAWhere(" and idEvenement = '" + evenement.getTuppleID() + "'");
          
          pr.setNpp(10);
          pr.creerObjetPage(entetes, null);
          int nombreLigne = pr.getTableau().getData().length;
          
%>


<div class="box-body">
    <%
        String lienTableau[] = {pr.getLien() + "?but=#"};
        MpivavakaLib[] liste=(MpivavakaLib[]) pr.getTableau().getData();
        if(pr.getTableau().getHtml() != null)
            out.println(pr.getTableau().getHtml());
        else
            {
               %><center><h4>Aucune donnée trouvé</h4></center><%
        }
    %>
            

   

</div>