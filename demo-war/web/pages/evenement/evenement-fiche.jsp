<%-- 
    Document   : evenement-fiche
    Created on : Oct 27, 2024, 7:34:25 AM
    Author     : sarobidy
--%>

<%@page import="affichage.PageConsulte"%>
<%@page import="user.UserEJB"%>
<%@page import="evenement.Evenement"%>
<%
          
    Evenement evenement = new Evenement();
    String lien = (String) session.getValue("lien");
    UserEJB u = (UserEJB) session.getValue("u");
    
    PageConsulte pc = new PageConsulte(evenement, request, u);
    pc.setTitre("D&eacute;tails de l&apos;evenement");
    
    pc.setLien(lien);
    
    String pageModif = "evenement/evenement-update.jsp";
    String id = evenement.getTuppleID();
    String classe = "evenement.Evenement";
    String nomTable = "evenement";

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
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&" + evenement.getAttributIDName() + "=" + id%>" style="margin-right: 10px">
                                    Modifier
                            </a>
                            <a href="<%= lien + "?but=apresTarif.jsp&" + evenement.getAttributIDName() + "="+ id+"&acte=delete&bute=#&classe="+classe %>">
                                <button class="btn btn-danger">Supprimer</button>
                            </a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>