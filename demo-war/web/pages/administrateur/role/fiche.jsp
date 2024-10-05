<%@page import="affichage.PageConsulte" %>
<%@page import="user.UserEJB" %>
<%@page import="utilisateur.Role" %>

<%

    Role role = new Role();
    UserEJB user = (UserEJB) session.getValue("u");

    PageConsulte pc = new PageConsulte( role, request, user );

    role = (Role) pc.getBase();
    pc.getChampByName("id").setLibelle("Identifiant");
    pc.getChampByName("idrole").setLibelle("Nom Abbr&eacute;g&eacute;");
    pc.getChampByName("descrole").setLibelle("D&eacute;scription");
    pc.getChampByName("rang").setLibelle("Rang");

    pc.setTitre("Fiche Role");
    String lien = (String) session.getValue("lien");
    String pageModif = "administrateur/role/update.jsp";
    String classe = "utilisateur.Role";

    String id = role.getTuppleID();

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
                            <a href="<%= lien + "?but=apresTarif.jsp&id="+ id+"&acte=delete&bute=#&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


