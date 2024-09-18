<%@page import="annexe.*"%>
<%@page import="utilitaire.Utilitaire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
        Produit produit = new Produit();
        produit.setId(request.getParameter("id"));
        produit.setNomTable("v_Produitlib");
        PageConsulte pc = new PageConsulte(produit, request, (user.UserEJB) session.getValue("u"));
        String id=pc.getBase().getTuppleID( );
        pc.setTitre("Fiche Produit");

        pc.getChampByName("unitelib").setLibelle("Unite");
        pc.getChampByName("typeProduitlib").setLibelle("Type");
        pc.getChampByName("idUnite").setVisible(false);
        pc.getChampByName("idTypeProduit").setVisible(false);

        String lien = (String) session.getValue("lien");
        String pageModif = "update/update-simple.jsp";
        String classe = "boutique.article.Article";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="#"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&bute=#&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        <br/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<%
} catch (Exception e) {
    e.printStackTrace();
} %>


