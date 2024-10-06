<%-- 
    Document   : fiche
    Created on : Oct 6, 2024, 12:34:30 PM
    Author     : sarobidy
--%>

<%@page import="annexe.Faritra"%>
<%@page import="affichage.*"%>
<%
          Faritra faritra = new Faritra();
          
          PageConsulte pc = new PageConsulte( faritra, request, (user.UserEJB) session.getValue("u") );
          faritra = (Faritra) pc.getBase();
          pc.setTitre("Fiche du Faritra : " + faritra.getNomFaritra());
          pc.setLien( (String) session.getValue("lien") );
          pc.getChampByName("nomFaritra").setLibelle("Nom du Faritra");
          pc.getChampByName("idFaritra").setLibelle("Identifiant du Faritra");
          
          
        String lien = pc.getLien();
        String pageModif = "administrateur/annexe/faritra/update.jsp";
        String classe = "annexe.Faritra";

        String id = faritra.getTuppleID();

          
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
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&idFaritra=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%= lien + "?but=apresTarif.jsp&idMpivavaka="+ id+"&acte=delete&bute=administrateur/annexe/faritra/liste.jsp&classe="+classe + "&nomtable=faritra" %>"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>