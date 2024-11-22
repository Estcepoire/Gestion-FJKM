<%-- 
    Document   : evenement-saisie
    Created on : Oct 23, 2024, 9:20:01 PM
    Author     : sarobidy
--%>

<%@page import="utils.ConstanteFJKM"%>
<%@page import="evenement.TypeEvenement"%>
<%@page import="affichage.Liste"%>
<%@page import="affichage.PageInsert"%>
<%@page import="user.UserEJB"%>
<%@page import="evenement.Evenement"%>

<%
         Evenement event = new Evenement();
         
         String lien = (String) session.getValue("lien");
         UserEJB user = (UserEJB) session.getValue("u");
         
         PageInsert pi = new PageInsert( event, request, user );
         pi.setTitre("Ajout d'un evenement");
         pi.setLien(lien);
         
         Liste[] list = new Liste[2];
          list[0] = new Liste("ouvert");
          list[0].makeListeOuiNon();
          
          list[1] = new Liste( "idTypeEvenement", new TypeEvenement(), "val", "id" );
          
          pi.getFormu().changerEnChamp(list);
         
         pi.getFormu().getChamp("etat").setVisible(false);
         pi.getFormu().getChamp("idMpivavaka").setVisible(false);
         pi.getFormu().getChamp("idMere").setVisible(false);
         pi.getFormu().getChamp("longitude").setVisible(false);
         pi.getFormu().getChamp("latitude").setVisible(false);
         
         pi.getFormu().getChamp("description").setType("textarea");
         pi.getFormu().getChamp("heureDebut").setType("time");
         pi.getFormu().getChamp("heureDebut").setAutre("step=\"1\"");
         
         pi.getFormu().getChamp("heureFin").setType("time");
         pi.getFormu().getChamp("heureFin").setAutre("step=\"1\"");
         
         pi.getFormu().getChamp("lieu").setDefaut( ConstanteFJKM.getName() );
         String[] coords = ConstanteFJKM.getDefaultCoordinates();
         pi.getFormu().getChamp("longitude").setDefaut( coords[1] );
         pi.getFormu().getChamp("latitude").setDefaut( coords[0] );
         
         
         // Libellé
         pi.getFormu().getChamp("description").setLibelle("D&eacute;scription");
         pi.getFormu().getChamp("dateDebutEvenement").setLibelle("Date d&eacute;but");
         pi.getFormu().getChamp("dateFinEvenement").setLibelle("Date Fin");
         pi.getFormu().getChamp("heureDebut").setLibelle("Heure D&eacute;but");
         pi.getFormu().getChamp("heureFin").setLibelle("Heure Fin");
         pi.getFormu().getChamp("idTypeEvenement").setLibelle("Type d&apos;evenement");
         pi.getFormu().getChamp("ouvert").setLibelle("Ouvert &agrave; tous");
         pi.getFormu().getChamp("lieu").setLibelle("Lieu");


         
         String idMere = request.getParameter("idMere");
        pi.getFormu().getChamp("idMere").setDefaut( ( idMere != null ) ? idMere : null );
         
         pi.preparerDataFormu();
         pi.getFormu().setTitre(pi.getTitre());
         pi.getFormu().makeHtmlInsertTabVaovao();
         
         String afterPost = "evenement/evenement-fiche.jsp",
            mappingClass = "evenement.Evenement",
            nomTable = "evenement";
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
    
    <section class="content">
        <form action="<%= pi.getLien() %>?but=apresTarif.jsp" data-parsley-validate method="POST">
            <div class="row">
                <div class="col-md-6">
                        <%= pi.getFormu().getHtmlInsert() %>
                </div>
                <div class="col-md-6">
                    <div id="map"></div>
                </div>
            </div>
            <input name="acte" type="hidden" id="nature" value="insert">
            <input name="bute" type="hidden" id="bute" value="<%= afterPost %>">
            <input name="classe" type="hidden" id="classe" value="<%= mappingClass %>">
            <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
        </form>
    </section>
</div>

<script src="${pageContext.request.contextPath}/assets/leaflet-map/leaflet.js"></script>
<script src="${pageContext.request.contextPath}/assets/leaflet-map/Control.Geocoder.js"></script>
<script>
        var map = L.map('map').setView([ <%= pi.getFormu().getChamp("latitude").getValeur() %> , <%= pi.getFormu().getChamp("longitude").getValeur() %> ], 13);
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
        
         const point = [ <%= pi.getFormu().getChamp("latitude").getValeur() %> , <%= pi.getFormu().getChamp("longitude").getValeur() %> ]; // Coordinates for the marker
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