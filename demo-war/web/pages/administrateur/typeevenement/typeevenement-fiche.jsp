<%-- 
    Document   : fiche
    Created on : Oct 21, 2024, 9:43:15 PM
    Author     : sarobidy
--%>

<%@page import="user.UserEJB"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="evenement.TypeEvenement"%>
<%
          
        TypeEvenement type = new TypeEvenement();
        UserEJB u = (UserEJB) session.getValue("u");
        
        PageConsulte pc = new PageConsulte(type, request, u );
        
        type = (TypeEvenement) pc.getBase();
        pc.getChampByName("val").setLibelle("Type d&apos;evenement");
        pc.getChampByName("desce").setLibelle("D&eacute;scription");
        pc.getChampByName("id").setLibelle("Identifiant");
        
        pc.setTitre("Fiche Type d&apos;evenement");
        String lien = (String) session.getValue("lien");
        String pageModif = "administrateur/typeevenement/typeevenement-update.jsp";
        String classe = "evenement.TypeEvenement";

        String id = type.getTuppleID();

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
