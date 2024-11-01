<%-- 
    Document   : fiche
    Created on : Oct 6, 2024, 12:34:30 PM
    Author     : sarobidy
--%>

<%@page import="annexe.InformationAnnexe"%>
<%@page import="affichage.*"%>
<%
          InformationAnnexe info = new InformationAnnexe();
          
          PageConsulte pc = new PageConsulte( info, request, (user.UserEJB) session.getValue("u") );
          info = (InformationAnnexe) pc.getBase();
          pc.setTitre("Fiche de l'information : " + info.getVal());
          pc.setLien( (String) session.getValue("lien") );
          pc.getChampByName("id").setVisible(false);
          pc.getChampByName("val").setLibelle("Libell&eacute de l'information");
          pc.getChampByName("desce").setLibelle("Description de l'information");
          
          
        String lien = pc.getLien();
        String pageModif = "administrateur/annexe/information/information-update.jsp";
        String classe = "annexe.InformationAnnexe";

        String id = info.getTuppleID();

          
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
                            <a href="<%= lien + "?but=apresTarif.jsp&id="+ id+"&acte=delete&bute=administrateur/annexe/information/information-liste.jsp&classe="+classe + "&nomtable=infoannexe" %>"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>