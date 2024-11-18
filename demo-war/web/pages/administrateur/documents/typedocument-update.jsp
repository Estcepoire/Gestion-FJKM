<%-- 
    Document   : typedocument-saisie
    Created on : Nov 18, 2024, 11:33:20 AM
    Author     : sarobidy
--%>

<%@page import="user.UserEJB"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="document.TypeDocument"%>

<%
          TypeDocument tp = new TypeDocument();
          UserEJB u = (UserEJB) session.getAttribute("u");
          PageUpdate pi = new PageUpdate( tp, request, u);
          pi.getFormu().getChamp("val").setLibelle("Type de Fichier");
          pi.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
          tp = (TypeDocument) pi.getBase();
          pi.getFormu().setTitre("Update type de document : " + tp.getVal());
          
          pi.preparerDataFormu();
          pi.getFormu().makeHtmlInsertTabVaovao();
          pi.setLien( (String) session.getValue("lien") );
          
          String bute = "document/typedocument-fiche.jsp",
          classe = "document.TypeDocument",
          nomTable = "typedocument";

%>
<div class="content-wrapper">
                    
        <form action="<%= pi.getLien() %>?but=apresTarif.jsp&id=<%= request.getParameter(tp.getAttributIDName()) %>" method="post">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="<%= bute %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                        <input name="nomtable" type="hidden" id="colonneMere" value="<%= nomTable %>">
                        
                    </form>
</div>