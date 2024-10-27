<%-- 
    Document   : participation-update
    Created on : Oct 27, 2024, 3:08:28 PM
    Author     : sarobidy
--%>

<%@page import="evenement.participation.ParticipationLib"%>
<%@page import="affichage.PageUpdateMultiple"%>
<%@page import="utils.ConstanteFJKM"%>
<%@page import="bean.CGenUtil"%>
<%@page import="evenement.TypeEvenement"%>
<%@page import="affichage.Liste"%>
<%@page import="affichage.Champ"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="evenement.participation.Participation"%>
<%@page import="evenement.Evenement"%>

<%
          
          Evenement event = new Evenement();
          Participation participant = new Participation();
          int nbLine = 10;
          UserEJB u = (UserEJB) session.getValue("u");
          String lien = (String) session.getValue("lien");
          
          ParticipationLib lib = new ParticipationLib();
          lib.setIdEvenement(request.getParameter(event.getAttributIDName()));
          
          ParticipationLib[] ts = (ParticipationLib[]) CGenUtil.rechercher(lib, null, null, "");
          PageUpdateMultiple pi = new PageUpdateMultiple( event, participant, ts, request, u, nbLine);
          
          Liste[] list = new Liste[2];
          list[0] = new Liste("ouvert");
          list[0].makeListeOuiNon();
          
          list[1] = new Liste( "idTypeEvenement", new TypeEvenement(), "val", "id" );
          
          pi.getFormu().changerEnChamp(list);
          
          pi.getFormu().getChamp("etat").setVisible(false);
         pi.getFormu().getChamp("idMpivavaka").setVisible(false);
         pi.getFormu().getChamp("idMere").setVisible(false);
         
         pi.getFormu().getChamp("heureDebut").setType("time");
         pi.getFormu().getChamp("heureDebut").setAutre("step=\"1\"");
         
         pi.getFormu().getChamp("heureFin").setType("time");
         pi.getFormu().getChamp("heureFin").setAutre("step=\"1\"");
         
         pi.getFormu().getChamp("lieu").setDefaut( ConstanteFJKM.getName() );
         String[] coords = ConstanteFJKM.getDefaultCoordinates();
         pi.getFormu().getChamp("longitude").setDefaut( coords[1] );
         pi.getFormu().getChamp("latitude").setDefaut( coords[0] );
         
         pi.getFormu().getChamp("longitude").setVisible(false);
         pi.getFormu().getChamp("latitude").setVisible(false);
          
          
          Champ.setVisible( pi.getFormufle().getChampFille("idParticipation") , false);
          Champ.setVisible( pi.getFormufle().getChampFille("idEvenement") , false);
          // Comportement des champs
                Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idMpivavaka"), "croyance.MpivavakaLib", "idMpivavaka", "v_mpivavaka_lib");
          
        for( int i = 0; i < ts.length; i++ ){
            pi.getFormufle().getChamp("idMpivavaka_"+i).setAutoCompleteLibelle( ts[i].getNomComplet() );
        }

          pi.preparerDataFormu();
                pi.setTitre("Ajout de participants pour l&apos;evenement");

                pi.setLien(lien);

              pi.getFormu().makeHtmlInsertTabIndex();
              pi.getFormufle().makeHtmlInsertTableauIndex();

              String butApresPost = "evenement/evenement-fiche.jsp",
                      classeMere = "evenement.Evenement",
                      classeFille = "evenement.participation.Participation",
                      colonneMere = "idEvenement";
              
              String pageAppelMultiple = "croyance/choix/choix-mpandray-multiple.jsp";
              String champReturn = "idMpivavaka_0libelle;idMpivavaka_0";
              String champURL = "nomComplet;idMpivavaka";
%>


<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/leaflet-map/leaflet.css"  type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/leaflet-map/Control.Geocoder.css" type="text/css" />
    <style>
        
        #map{
                height: 400px;
        }
    </style>
</head>

<div class="content-wrapper">
    <!-- A modifier -->
    <h1>
        <%= pi.getTitre() %>
    </h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp&idEvenement=<%= lib.getIdEvenement()  %>" method="post" >
        <div class="row">
            <div class="col-md-6">
                    <%= pi.getFormu().getHtmlInsert() %>
            </div>
            <div class="col-md-6">
                    <div id="map"></div>
                </div>
        </div>
        
        <div class="row">
            <h3> 
                Modification des Participants
                <button class="btn btn-success" type="button" onclick="pagePopUp('modulePopup.jsp?but=<%= pageAppelMultiple %>&champReturn=<%=champReturn%>&champUrl=<%= champURL %>')">
                    Selectionnez des Croyants
                </button>
            </h3>
                <%= pi.getFormufle().getHtmlTableauInsert() %>
        </div>
        
        
        <input name="acte" type="hidden" id="nature" value="updateInsert">
        <input name="id" type="hidden" id="id" value="<%= lib.getIdEvenement() %>">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nbLine %>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">
    </form>
        
</div>

    
<script src="${pageContext.request.contextPath}/assets/leaflet-map/leaflet.js"></script>
<script src="${pageContext.request.contextPath}/assets/leaflet-map/Control.Geocoder.js"></script>
<script>
        var map = L.map('map').setView([ <%= coords[0] %> , <%= coords[1] %> ], 13);
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 20,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);
        var p = L.popup();
        function onMapClick(e){
            p.setLatLng(e.latlng)
                .openOn(map);
                            updateLongLatAndName(e.latlng);      
        }
        
         const point = [ <%= coords[0] %> , <%= coords[1] %> ]; // Coordinates for the marker
        const marker = L.marker(point).addTo(map);

        const geocoder = L.Control.geocoder({
            defaultMarkGeocode: true
         }).on('markgeocode', function(e) {
            const bbox = e.geocode.bbox;
            const poly = L.polygon([
              bbox.getSouthEast(),
              bbox.getNorthEast(),
              bbox.getNorthWest(),
              bbox.getSouthWest()
            ]).addTo(map);
            map.fitBounds(poly.getBounds());
          })
         .addTo(map);

        map.on('click' , onMapClick);
       
</script>


<script>
    
    // Eto manao script manao update anle champ coordinate reny fotsiny
    function updateLongLatAndName( coordinate ) {
        const { lat, lng } = coordinate;
        // Okey azoko eto le Coordonnées anle olona
        // Mila ampidiriko anaty champ fotsiny
        // Manao reverse api kely
        const url = `https://nominatim.openstreetmap.org/reverse?lat=\${lat}&lon=\${lng}&format=json`;
        
        fetch(url)
        .then(response => response.json())
        .then(data => {
          const address = data.display_name || "Lieu inconnu";
          document.all.lieu.value = address;
        })
        .catch(error => console.error("Error fetching location:", error));
        
        document.all.longitude.value = lng;
        document.all.latitude.value = lat;
    }
    
</script>