<%-- 
    Document   : fiche
    Created on : Oct 12, 2024, 7:16:39 AM
    Author     : sarobidy
--%>

<%@page import="user.UserEJB"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="croyance.fandraisana.MpandrayLib"%>
<%
          
    MpandrayLib mpandray = new MpandrayLib();
    mpandray.setNomTable("v_mpandray_lib_cpl");
    
    UserEJB user = (UserEJB) session.getValue("u");
    String lien = (String)  session.getValue("lien");
    
    PageConsulte pc = new PageConsulte( mpandray, request, user );
    
        mpandray = (MpandrayLib) pc.getBase();

    // Andramana aloha
    
    request.setAttribute("mpivavaka", mpandray);
    
    
    pc.setTitre("Fiche Mpandray Num&eacute;ro : " + mpandray.getNumeroMpandray());
    
    pc.getChampByName("etatMpandray").setLibelle("Etat Mpandray");
    pc.getChampByName("etat").setVisible(false);
    
             pc.getChampByName("idMpivavaka").setLibelle("Identifiant");
          pc.getChampByName("prenom").setLibelle("Pr&eacute;nom");
          pc.getChampByName("datenaissance").setLibelle("N&eacute;e le");
          pc.getChampByName("sexe").setVisible(false);
          pc.getChampByName("ageActuelle").setLibelle("Age");
          pc.getChampByName("ageActuelle").setValeur( mpandray.getAgeActuelle() +  " an(s)");
          pc.getChampByName("lieuDeNaissance").setLibelle("Lieu de Naissance");
          pc.getChampByName("addresse").setLibelle("Adresse");
          pc.getChampByName("nomFaritra").setLibelle("Faritra");
          pc.getChampByName("idFaritra").setVisible(false);
          pc.getChampByName("idMpandray").setVisible(false);
          pc.getChampByName("numeroMpandray").setLibelle("Num&eacute;ro Mpandray");
          pc.getChampByName("dateNandraisana").setLibelle("Date Nandraisana");
          pc.getChampByName("nomPromotion").setLibelle("Promotion");
    
    pc.setLien(lien);
    
    String pageModif = "croyance/fandraisana/update.jsp";
    String id = mpandray.getTuppleID();
    String classe = "croyance.fandraisana.Mpandray";
    String nomTable = "mpandray";
    

%>

<!--

    ahoana ny pozina fiche
        - alaina aloha ny idan'ilay mpandray
        - rehefa hita iny de manao affichage cote à cote
        - cote 1 : Mpivavaka
        - cote 2 : Ny momba an'ilay mpandray mihitsy
        - apj fuck donc mila manao include page
        - settena ao ilay izy anamboarana fiche fotsiny
        - let's go
-->

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
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&idMpandray=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%= lien + "?but=apresTarif.jsp&idMpandray="+ id+"&acte=delete&bute=#&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>