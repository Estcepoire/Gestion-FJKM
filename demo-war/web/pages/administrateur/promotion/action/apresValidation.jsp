<%-- 
    Document   : apresValidation
    Created on : Oct 16, 2024, 9:33:26 PM
    Author     : sarobidy
--%>

<%@page import="user.UserEJB"%>
<%@page import="croyance.promotion.Promotion"%>

<%
          
//    Inona no atao ato

/**
 * Ato no anaovana an'ilay hoe alaina ilay promotion
 * Recuperena ny details anle promotion
 * Validena daholo zareo avy eo
 */

    String idPromotion = request.getParameter("idPromotion");
    Promotion promotion = new Promotion();
    UserEJB user = (UserEJB) session.getValue("u");
    String lien = (String) session.getValue("lien");
    String apres = "administrateur/promotion/fiche.jsp&idPromotion="+idPromotion;
    
    try{
        promotion.setIdPromotion(idPromotion);
        promotion.validatePupils( user.getUser().getTuppleID() );
        // Eto mila mredirect
                
        %>
        <script>
            document.location.replace("<%=lien%>?but=<%= apres %>");
            
        </script>
        
<%        
    }catch(Exception e){ %>
        <script>
            alert("<%= e.getMessage() %>");
            history.back();
        </script>
<%
          }
%>