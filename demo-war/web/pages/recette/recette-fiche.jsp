<%@ page import="recette.*" %>
<%@ page import="utilitaire.Utilitaire" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.util.*" %>

<%
    try {
        Recette recette = new Recette();
        recette.setId(request.getParameter("id"));
        recette.setNomTable("v_Recettelib");
        PageConsulte pc = new PageConsulte(recette, request, (user.UserEJB) session.getValue("u"));
        
        recette = (Recette) pc.getBase();
        String id = recette.getTuppleID();
        pc.setTitre("Fiche Recette");

        pc.getChampByName("idtyperecettelib").setLibelle("Type de recette");
        pc.getChampByName("idlignecreditlib").setLibelle("Ligne de cr&eacute;dit");
        pc.getChampByName("daty").setLibelle("Date de recette");
        pc.getChampByName("montant").setLibelle("Montant");
        pc.getChampByName("idCaisselib").setLibelle("Caisse");

        pc.getChampByName("idtyperecette").setVisible(false);
        pc.getChampByName("idlignecredit").setVisible(false);
        pc.getChampByName("idCaisse").setVisible(false);

        String lien = (String) session.getValue("lien");
        String pageActuel = "recette/recette-fiche.jsp";
        String pageModif = "recette/recette-modif.jsp";
        String classe = "recette.Recette";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="#"><i class="fa fa-arrow-circle-left"></i></a><%= pc.getTitre() %></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                        <% if(recette.getEtat() < 11) { %>
                            <a class="btn btn-warning pull-left" href="<%= lien + "?but=" + pageModif + "&id=" + id %>" style="margin-right: 10px">Modifier</a>
                            <a href="<%= lien + "?but=apresTarif.jsp&id=" + id + "&acte=valider&bute="+pageActuel+"&classe=" + classe %>" class="btn btn-success">Valider</a>
                        <% } else { %>
                            <a href="<%= lien + "?but=apresRecette.jsp&id=" + id + "&acte=valider&bute="+pageActuel+"&classe=" + classe %>" class="btn btn-primary">Entr&eacute;e de caisse</a>
                        <% } %>
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
    }
%>
