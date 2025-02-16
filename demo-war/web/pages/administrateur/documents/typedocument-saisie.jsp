<%-- 
    Document   : typedocument-saisie
    Created on : Nov 18, 2024, 11:33:20 AM
    Author     : sarobidy
--%>

<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsert"%>
<%@page import="document.TypeDocument"%>

<%
          TypeDocument tp = new TypeDocument();
          UserEJB u = (UserEJB) session.getAttribute("u");
          PageInsert pi = new PageInsert( tp, request, u);
          pi.getFormu().getChamp("val").setLibelle("Type de Fichier");
          pi.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
          
          pi.getFormu().setTitre("Cr&eacute;ation type de document");
          pi.setLien( (String) session.getValue("lien") );
          
          pi.preparerDataFormu();
          pi.getFormu().makeHtmlInsertTabVaovao();
          
          String bute = "administrateur/documents/typedocument-fiche.jsp",
          classe = "document.TypeDocument",
          nomTable = "typedocument";

%>
<div class="content-wrapper">
                    
        <form action="<%= pi.getLien() %>?but=apresTarif.jsp" method="post">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <input name="acte" type="hidden" id="acte" value="insert">
                        <input name="bute" type="hidden" id="bute" value="<%= bute %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                        <input name="nomtable" type="hidden" id="colonneMere" value="<%= nomTable %>">
                        
                    </form>
</div>