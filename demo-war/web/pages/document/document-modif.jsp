<%-- 
    Document   : document-saisie
    Created on : Nov 19, 2024, 5:59:34 AM
    Author     : sarobidy
--%>

<%@page import="affichage.Liste"%>
<%@page import="document.TypeDocument"%>
<%@page import="affichage.PageUpload"%>
<%@page import="affichage.PageInsert"%>
<%@page import="user.UserEJB"%>
<%@page import="document.Document"%>
<%
          Document document = new Document();
          String lien = (String) session.getAttribute("lien");
          UserEJB u = (UserEJB) session.getAttribute("u");
          PageUpload pi = new PageUpload( document, request, u );
          
          pi.getFormu().getChamp("mere").setVisible(false);
          pi.getFormu().getChamp("idMpivavaka").setVisible(false);
          pi.getFormu().getChamp("dateAjout").setVisible(false);
          pi.getFormu().getChamp("libelle").setLibelle("D&eacute;scription");
          pi.getFormu().getChamp("numeroDocument").setLibelle("Num&eacute;ro Document");
          pi.getFormu().getChamp("numeroDocument").setAutre("readonly");
          
          Liste[] listes = { new Liste( "idTypeDocument", new TypeDocument(), "val", "id" ) };
          
          pi.getFormu().changerEnChamp(listes);
          pi.getFormu().getChamp("idTypeDocument").setLibelle("Type de  Document");
          pi.getFormu().getChamp("chemin").setLibelle("Fichiers");
          pi.getFormu().getChamp("chemin").setPhoto(true);
          
          pi.getFormu().setTitre("Upload d'un nouveau document");
          
          pi.preparerDataFormu();
          pi.getFormu().makeHtmlInsertTabVaovao();
%>

<div class="content-wrapper">
    <form class="form" enctype="multipart/form-data" method="POST" action="/fjkm/upload">
        <%= pi.getFormu().getHtmlInsert() %>
        <input type="hidden" value="document.Document" name="classe" />
        <input type="hidden" value="document/document-fiche.jsp" name="bute" />
        <input type="hidden" value="nomtable" name="document" />
    </form>
</div>