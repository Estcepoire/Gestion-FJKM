<%-- 
    Document   : apresEvenement
    Created on : Oct 27, 2024, 4:31:56 PM
    Author     : sarobidy
--%>

<%@page import="evenement.Evenement"%>
<%
          String lien = (String) session.getValue("lien");
          String bute = request.getParameter("bute");
          String id = request.getParameter("idEvenement");
          try {
                Evenement evenement = new Evenement();
                // Okey azoko le id
                String acte = request.getParameter("acte");
                if( acte != null && acte.equalsIgnoreCase("terminer") ){
                      evenement.setIdEvenement(id);
                      evenement.terminer();
                }
%>

<script language="JavaScript"> document.location.replace("<%= lien %>?but=<%=bute %>&idEvenement=<%=id %>");</script>

<%
                
          }catch(Exception e){
%>
        <script language="JavaScript">
            alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
            history.back();
        </script>
<%
        return;
    }
%>
