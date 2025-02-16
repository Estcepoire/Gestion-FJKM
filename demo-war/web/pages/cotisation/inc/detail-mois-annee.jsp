<%-- 
    Document   : detail-cotisation
    Created on : Nov 3, 2024, 3:32:58 PM
    Author     : sarobidy
--%>

<%@page import="affichage.PageRecherche"%>
<%@page import="user.UserEJB"%>
<%@page import="cotisation.DetailCotisation"%>
<%
      try{    
          String mois = request.getParameter("mois");
          String annee = request.getParameter("annee");
          
          DetailCotisation details = new DetailCotisation();
          details.setNomTable("v_detail_paiement_somme");
          
          UserEJB u = (UserEJB) session.getValue("u");
          String lien = (String) session.getValue("lien");
          String[] entetes = {"nomComplet", "montant"};
          
          PageRecherche pr = new PageRecherche( details, request, new String[0], new String[0], 3, entetes, entetes.length );
          pr.setUtilisateur(u);
          
          pr.setAWhere(" and mois = " + mois + " and annee = "  + annee);
          
          pr.creerObjetPage(entetes, null);
          
%>

<div class="box-body">
    <%
         String[] libelles = {"Nom Complet", "Montant"};
        pr.getTableau().setLibelleAffiche(libelles);
        if(pr.getTableau().getHtmlVaovao() != null)
            out.println(pr.getTableau().getHtmlVaovao());
        else
            {
               %><center><h4>Aucune donnée trouvé</h4></center><%
        }
    %>
   

</div>
    
    <%
              }catch(Exception e){
e.printStackTrace();
}
    %>