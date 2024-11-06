<%-- 
    Document   : recensement-fiche
    Created on : Nov 6, 2024, 7:50:00 PM
    Author     : sarobidy
--%>

<%@page import="affichage.PageConsulte"%>
<%@page import="user.UserEJB"%>
<%@page import="recensement.Recensement"%>

<%
          Recensement r = new Recensement();
          UserEJB u = (UserEJB) session.getAttribute("u");
          String lien = (String) session.getAttribute("lien");
          
          PageConsulte pc = new PageConsulte( r, request, u );
          pc.setLien(lien);
          
          r = (Recensement) pc.getBase();
          
          pc.setTitre("Recensement du " + r.getAnnee());
          
          pc.getChampByName("idReportCroyant").setLibelle("Identifiant");
          pc.getChampByName("designation").setLibelle("D&eacute;signation");
          pc.getChampByName("nombre").setLibelle("Croyant Recens&eacute;");
          pc.getChampByName("annee").setLibelle("Ann&eacute;e");
          
          String pageModif = "administrateur/recensement/recensement-update.jsp";
        String classe = "recensement.Recensement";

        String id = r.getTuppleID();

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
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&idReportCroyant=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%= lien + "?but=apresTarif.jsp&idReportCroyant="+ id+"&acte=delete&bute=#&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
