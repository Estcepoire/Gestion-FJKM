<%-- 
    Document   : apresOuverture
    Created on : Nov 4, 2024, 5:03:34 AM
    Author     : sarobidy
--%>

<%@page import="user.UserEJB"%>
<%@page import="cotisation.Cotisation"%>
<%
          // inona no atao ato
          // Rehefa ouverture de mila fantatra ilay mois sy année
          String mois = request.getParameter("mois");
          String annee = request.getParameter("annee");
          
          try{
            Cotisation cotisation = new Cotisation( mois, annee );

            UserEJB u = (UserEJB) session.getValue("u");
            String lien = (String) session.getValue("lien");

            cotisation.ouvrirPayement(String.valueOf(u.getUser().getRefuser()));
            
%>

<script>
    window.location.href = "<%= lien %>?but=cotisation/cotisation-fiche.jsp&idPaiementCotisation=<%= cotisation.getTuppleID() %>&mois=<%= mois %>&annee=<%= annee %>";
</script>


<%
          }catch(Exception e){
%>

<script>
    alert( "<%= e.getMessage() %>" );
    history.back();
    
</script>

<%
          
          }
          
          
%>