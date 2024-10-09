<%-- 
    Document   : fiche
    Created on : Oct 9, 2024, 8:21:36 PM
    Author     : sarobidy
--%>

<%-- 
    Document   : fiche
    Created on : Oct 5, 2024, 8:53:25 PM
    Author     : sarobidy
--%>
<%@page import="croyance.promotion.Promotion" %>
<%@page import="affichage.PageConsulte" %>
<%@page import="user.UserEJB" %>

<%
          
    Promotion promotion = new Promotion();
   
    UserEJB user = (UserEJB) session.getValue("u");
    PageConsulte pc = new PageConsulte( promotion, request, user );
    promotion = (Promotion) pc.getBase();
    
    pc.getChampByName("idPromotion").setLibelle("Identifiant");
    pc.getChampByName("nomPromotion").setLibelle("Nom de la Promotion");
    pc.getChampByName("anneePromotion").setLibelle("Annee de la Promotion");
    pc.getChampByName("dateSortie").setLibelle("Date de Sortie");
    

    pc.setTitre("Fiche Promotion : " + promotion.getNomPromotion());
    
    String lien = (String) session.getValue("lien");
    String pageModif = "administrateur/promotion/update.jsp";
    String classe = "croyance.promotion.Promotion";

    String id = promotion.getTuppleID();



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
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&idPromotion=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%= lien + "?but=apresTarif.jsp&idPromotion="+ id+"&acte=delete&bute=#&classe="+classe + "&nomtable=promotionmpandray" %>"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>