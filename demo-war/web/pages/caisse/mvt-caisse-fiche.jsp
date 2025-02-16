<%@page import="annexe.*"%>
<%@page import="utilitaire.Utilitaire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="caisse.*" %>

<%
    try{
        MvtCaisse mvtCaisse = new MvtCaisse();
        mvtCaisse.setId(request.getParameter("id"));
        mvtCaisse.setNomTable("mvtcaisselib");
        PageConsulte pc = new PageConsulte(mvtCaisse, request, (user.UserEJB) session.getValue("u"));
        MvtCaisse m = (MvtCaisse) pc.getBase();
        String id=m.getTuppleID( );
        pc.setTitre("Fiche Mouvement de caisse");

        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("idFacturefournisseurlib").setLibelle("Origine");
        pc.getChampByName("idtierslib").setLibelle("Tiers");
        pc.getChampByName("idcaisselib").setLibelle("Caisse");

        String lien = (String) session.getValue("lien");
        String pageModif = "";
        String classe = "caisse.MvtCaisse";
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
                        <% if(m.getEtat() < 11) {%>
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a  class="btn btn-success" href="<%= lien + "?but=apresTarif.jsp&id=" + id + "&acte=valider&bute=caisse/mvt-caisse-fiche.jsp&classe="+ classe %>">Valider</a>
                        <%
                            }
                        %>
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


