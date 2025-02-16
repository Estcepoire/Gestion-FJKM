<%-- 
    Document   : fiche
    Created on : Oct 5, 2024, 8:53:25 PM
    Author     : sarobidy
--%>
<%@page import="bureaux.Bureaux" %>
<%@page import="affichage.PageConsulte" %>
<%@page import="user.UserEJB" %>

<%
          
    Bureaux bureaux = new Bureaux();
    bureaux.setNomTable("v_bureaux_lib");
    UserEJB user = (UserEJB) session.getValue("u");
    PageConsulte pc = new PageConsulte( bureaux, request, user );
    bureaux = (Bureaux) pc.getBase();
    
    pc.getChampByName("idBureaux").setLibelle("Identifiant");
    pc.getChampByName("nomBureaux").setLibelle("Nom");
    pc.getChampByName("descriptionBureaux").setLibelle("Description");
    pc.getChampByName("dateCreation").setLibelle("Cr&eacute;&eacute; le");
    pc.getChampByName("idTypeBureau").setVisible(false);
    pc.getChampByName("typeBureau").setLibelle("Type de Bureau");

    pc.setTitre("Fiche Bureau : " + bureaux.getNomBureaux());
    
    
    String lien = (String) session.getValue("lien");
    String pageModif = "administrateur/bureau/bureau-update.jsp";
    String classe = "bureaux.Bureaux";
    String pageAjoutMembre = "administrateur/bureau/membership/ajouter-membre.jsp";

    String id = bureaux.getTuppleID();



%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box bg-white rounded p-3">
                    <div class="box-title with-border">
                        <h2 class="text-center">
                            <a href="#">
                                <i class="fa fa-arrow-circle-left"></i>
                            </a>
                                <%= pc.getTitre() %>
                        </h2>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer d-flex justify-content-end">
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&idBureaux=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageAjoutMembre +"&idBureaux=" + id%>" style="margin-right: 10px">Ajouter des Membres</a>
                            <a href="<%= lien + "?but=apresTarif.jsp&idBureaux="+ id+"&acte=delete&bute=#&classe="+classe + "&nomtable=bureaux" %>"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        <br/>
                    </div>
                </div>
            </div>
        </div>
    </div>
                        
    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                
            </div>
        </div>
        <jsp:include page="onglets/membre-bureaux.jsp" >
            <jsp:param name="idBureaux" value="<%= id %>" />
        </jsp:include>
    </div>
</div>