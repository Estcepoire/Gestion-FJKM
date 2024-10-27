<%-- 
    Document   : evenement-fiche
    Created on : Oct 27, 2024, 7:34:25 AM
    Author     : sarobidy
--%>

<%@page import="evenement.EvenementLib"%>
<%@page import="affichage.Onglet"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="user.UserEJB"%>
<%@page import="evenement.Evenement"%>
<%
          
    EvenementLib evenement = new EvenementLib();
    String lien = (String) session.getValue("lien");
    UserEJB u = (UserEJB) session.getValue("u");
    
    PageConsulte pc = new PageConsulte(evenement, request, u);
    pc.setTitre("D&eacute;tails de l&apos;evenement");
    
    evenement = (EvenementLib) pc.getBase();
    
    pc.setLien(lien);
    
    String pageModif = ( evenement.getOuvert() ) ?  "evenement/evenement-update.jsp" : "evenement/participation/participation-update.jsp";
    String id = evenement.getTuppleID();
    String classe = "evenement.Evenement";
    String nomTable = "evenement";
    String pageActuel = "evenement/evenement-fiche.jsp";
    
    // Libellés
    pc.getChampByName("idEvenement").setLibelle("ID");
    pc.getChampByName("description").setLibelle("D&eacute;scription");
    pc.getChampByName("dateDebutEvenement").setLibelle("Date d&eacute;but");
    pc.getChampByName("dateFinEvenement").setLibelle("Date Fin");
    pc.getChampByName("heureDebut").setLibelle("Heure D&eacute;but");
    pc.getChampByName("heureFin").setLibelle("Heure Fin");
    pc.getChampByName("typeEvenement").setLibelle("Type d&apos;evenement");
    pc.getChampByName("ouvert").setLibelle("Ouvert &agrave; tous");
    pc.getChampByName("latLong").setLibelle("Coordonn&eacute;&eacute;s (Lat, Long)");
    
    // Visibilité
    pc.getChampByName("etat").setVisible(false);
    pc.getChampByName("idMpivavaka").setVisible(false);
    pc.getChampByName("idMere").setVisible(false);
    pc.getChampByName("longitude").setVisible(false);
    pc.getChampByName("latitude").setVisible(false);
    pc.getChampByName("idTypeEvenement").setVisible(false);
    
    Onglet onglet = new Onglet("liste-participant");
    onglet.addPage("liste-participant", "participant");
    onglet.addPage("liste-evenements", "evenements");
    String tab = request.getParameter("tab");
    String currentTab = onglet.getCurrentPage(tab);
    
    request.setAttribute("evenement", evenement);
    
    String redirectionFille = ( evenement.getOuvert() ) ? "evenement/evenement-saisie.jsp" : "evenement/participation/participation-saisie.jsp";
    redirectionFille = redirectionFille + "&idMere=" + id;

%>

<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/leaflet-map/leaflet.css"  type="text/css"/>
    <style>
        
        #map{
                height: 400px;
        }
    </style>
</head>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-1"></div>
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
                             <% if( evenement.getOuvert() == false ) { %>
                                <a href="<%= lien + "?but=evenement/participation/participation-saisie.jsp&idEvenement=" + id %> ">
                                   <button class="btn btn-primary">Ajouter participants</button>
                               </a>
                              <% } %>
                              <a href="<%= lien + "?but=" + redirectionFille %>">
                                <button class="btn btn-primary">Lier Evenement </button>
                            </a>
                            <a href="<%= lien + "?but=evenement/apresEvenement.jsp&bute=evenement/evenement-fiche.jsp&acte=terminer&idEvenement=" + id %>">
                                <button class="btn btn-primary">Terminer l'evenement </button>
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
        <div class="col-md-4">
            <div id="map"></div>
        </div>
    </div>
    <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <!-- a modifier -->
                        <li class="<%= onglet.isActive("liste-participant") %>">
                            <a href="<%= lien %>?but=<%= pageActuel %>&idEvenement=<%= id %>&tab=participant">Participants</a>
                        </li>
                        <li class="<%= onglet.isActive("liste-evenements") %>">
                            <a href="<%= lien %>?but=<%= pageActuel %>&idEvenement=<%= id %>&tab=evenements">Sous Evenements</a>
                        </li>
                    </ul>
                    <div class="tab-content">       
                        <jsp:include page="<%= currentTab %>" />
                    </div>
                </div>

            </div>
        </div>
</div>
                    
                    
<script src="${pageContext.request.contextPath}/assets/leaflet-map/leaflet.js"></script>
<script>
        var map = L.map('map').setView([ <%= evenement.getLatitude() %> , <%= evenement.getLongitude() %> ], 13);
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 20,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);
        
        
         const point = [ <%= evenement.getLatitude() %> , <%= evenement.getLongitude() %> ]; 
        const marker = L.marker(point).addTo(map);

       
</script>
