<%-- 
    Document   : fiche
    Created on : Oct 6, 2024, 8:57:23 AM
    Author     : sarobidy
--%>
<%@page import="croyance.MpivavakaLib"%>
<%@page import="croyance.Mpivavaka" %>
<%@page import="affichage.*" %>
<%@page import="user.UserEJB" %>

<%
          MpivavakaLib mapping = new MpivavakaLib();
          UserEJB user = (UserEJB) session.getValue("u");
          String lien = (String) session.getValue("lien");
          
          PageConsulte pc = new PageConsulte( mapping, request, user );
          mapping = (MpivavakaLib) pc.getBase();
          
          pc.setTitre( "Fiche du croyant : "  + mapping.getPrenom());
          
          pc.getChampByName("idMpivavaka").setLibelle("Identifiant");
          pc.getChampByName("prenom").setLibelle("Pr&eacute;nom");
          pc.getChampByName("datenaissance").setLibelle("N&eacute;e le");
          pc.getChampByName("sexe").setVisible(false);
          pc.getChampByName("ageActuelle").setLibelle("Age");
          pc.getChampByName("ageActuelle").setValeur( mapping.getAgeActuelle() +  " an(s)");
          pc.getChampByName("lieuDeNaissance").setLibelle("Lieu de Naissance");
          pc.getChampByName("addresse").setLibelle("Adresse");
          pc.getChampByName("nomFaritra").setLibelle("Faritra");
          pc.getChampByName("idFaritra").setVisible(false);
          
          pc.setLien(lien);
          
       String pageModif = "croyance/mpivavaka/update.jsp";
        String classe = "croyance.Mpivavaka";

        String id = mapping.getTuppleID();

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
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&idMpivavaka=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%= lien + "?but=apresTarif.jsp&id="+ id+"&acte=delete&bute=#&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>