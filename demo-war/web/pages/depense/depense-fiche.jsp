<%@ page import="depense.*" %>
<%@ page import="utilitaire.Utilitaire" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="java.util.*"%> 

<%
    try {
        Depense depense = new Depense();
        depense.setId(request.getParameter("id"));
        depense.setNomTable("v_Depenselib");
        PageConsulte pc = new PageConsulte(depense, request, (user.UserEJB) session.getValue("u"));
        
        depense = (Depense) pc.getBase();
        String id = depense.getTuppleID();
        pc.setTitre("Fiche D&eacute;pense");

        pc.getChampByName("idtypedepenselib").setLibelle("Type de d&eacute;pense");
        pc.getChampByName("idlignecreditlib").setLibelle("Ligne de cr&eacute;dit");
        pc.getChampByName("idOriginelib").setLibelle("Facture Numero");
        pc.getChampByName("daty").setLibelle("Date de d&eacute;pense");
        pc.getChampByName("montant").setLibelle("Montant");
        pc.getChampByName("idCaisselib").setLibelle("Caisse");

        pc.getChampByName("idtypedepense").setVisible(false);
        pc.getChampByName("idlignecredit").setVisible(false);
        pc.getChampByName("idOrigine").setVisible(false);
        pc.getChampByName("idCaisse").setVisible(false);

        String lien = (String) session.getValue("lien");
        String pageActuel = "depense/depense-fiche.jsp";
        String pageModif = "depense/depense-modif.jsp";
        String classe = "depense.Depense";
        
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
                        <% if(depense.getEtat() < 11) { %>
                            <a class="btn btn-warning pull-left" href="<%= lien + "?but=" + pageModif + "&id=" + id %>" style="margin-right: 10px">Modifier</a>
                            <a href="<%= lien + "?but=apresTarif.jsp&id=" + id + "&acte=valider&bute="+pageActuel+"&classe=" + classe %>" class="btn btn-success">Valider</a>
                        <%
                            }else{
                                %>
                                <a href="<%= lien + "?but=apresDepense.jsp&id=" + id + "&acte=valider&bute="+pageActuel+"&classe=" + classe %>" class="btn btn-primary">Sortie de caisse</a>
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
    }
%>
