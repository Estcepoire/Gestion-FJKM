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
    String pageModif = "administrateur/bureau/update.jsp";
    String classe = "bureaux.Bureaux";

    String id = bureaux.getTuppleID();



%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">
                            <a href="#">
                                <i class="fa fa-arrow-circle-left"></i>
                            </a>
                            <%= pc.getTitre() %>
                        </h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%= lien + "?but=apresTarif.jsp&id="+ id+"&acte=delete&bute=#&classe="+classe + "&nomtable=bureaux" %>"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>