<%-- 
    Document   : document-fiche
    Created on : Nov 19, 2024, 3:30:51 PM
    Author     : sarobidy
--%>

<%@page import="user.UserEJB"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="document.Document"%>
<%
          Document document = new Document();
          document.setNomTable("v_document_lib");
          UserEJB u = (UserEJB) session.getAttribute("u");
          PageConsulte pc = new PageConsulte( document, request, u );
          document = (Document) pc.getBase();
          pc.getChampByName("id").setLibelle("IDENTIFIANT");
          pc.getChampByName("chemin").setLibelle("Chemin");
          pc.getChampByName("mere").setVisible(false);
          pc.getChampByName("libelle").setLibelle("Description du fichier");
          pc.getChampByName("dateAjout").setLibelle("Date d'ajout du fichier");
          pc.getChampByName("idMpivavaka").setVisible(false);
          pc.getChampByName("mimeType").setVisible(false);
          pc.getChampByName("idTypeDocument").setVisible(false);
          pc.getChampByName("typeDocument").setLibelle("Type de fichier");
          pc.getChampByName("extension").setLibelle("Extension");
          pc.getChampByName("numeroDocument").setLibelle("Numéro");
          pc.setTitre("Fiche du document : " + document.getLibelle());
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-6">
            <div class="box box-success bg-white p-3">
                <div class="box-title">
                    <h3 class="text-center my-2">
                         <%= pc.getTitre() %>
                    </h3>
                </div>
                <div class="box-body">
                    <%= pc.getHtml() %>
                </div>
                
                <div class="box-footer">
                    <div class="col-md-12">
                        <a href="/fjkm/upload?id=<%= document.getTuppleID() %>" class="btn btn-success">
                            Télécharger
                        </a>
                        <a href="" class="btn btn-danger">
                            Supprimer
                        </a>
                    </div>
                </div>
                
            </div>
        </div>
        <div class="col-md-5">
            <div class="row">
                <div class="nav-tabs-custom">
                    <ul class="nav-tabs">
                        <li class="active">
                            Préview
                        </li>
                    </ul>
                    <jsp:include page="./inc/document-preview.jsp" >
                        <jsp:param name="filePath" value="<%= document.getChemin() %>" />
                    </jsp:include>
                </div>
            </div>
            
        </div>
    </div>
                
    <!-- 
            Ato asiana an'ilay preview an'ilay document
            Atao cote à cote ilay izy
            Izay angamba no andeha ataoko
    -->
    
    
</div>