<%@ page import="famille.*" %>
<%@ page import="utilitaire.Utilitaire" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.util.*" %>

<%
    try {
        Valopy recette = new Valopy();
        recette.setId(request.getParameter("id"));
        recette.setNomTable("Valopylib");
        PageConsulte pc = new PageConsulte(recette, request, (user.UserEJB) session.getValue("u"));
        
        recette = (Valopy) pc.getBase();
        String id = recette.getTuppleID();
        pc.setTitre("Fiche ");

        pc.getChampByName("val").setLibelle("D&eacute;signation");
        pc.getChampByName("desce").setLibelle("Description");
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("montant").setLibelle("Montant");
        pc.getChampByName("Idfamillelib").setLibelle("Famille");
        pc.getChampByName("IdMpivavakalib").setLibelle("Nom Payeur");
        pc.getChampByName("IdMpivavakalib2").setLibelle("Prenom payeur");
        pc.getChampByName("Idfamille").setVisible(false);
        pc.getChampByName("IdMpivavaka").setVisible(false);
        

        String lien = (String) session.getValue("lien");
        String pageActuel = "famille/valopy-fiche.jsp";
        String pageModif = "famille/valopy-modif.jsp";
        String classe = "famille.Valopy";
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
                            <a href="<%= lien + "?but=recette/recette-saisie.jsp&id=" + id %>" class="btn btn-primary">Entr&eacute;e de caisse</a>
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
