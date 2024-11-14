<%-- 
    Document   : evenement-liste
    Created on : Oct 24, 2024, 10:12:07 PM
    Author     : sarobidy
--%>

<%@page import="affichage.PageInsert"%>
<%@page import="affichage.Liste"%>
<%@page import="evenement.TypeEvenement"%>
<%@page import="utils.CalendarUtils"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="evenement.Evenement"%>

<%
          try{
          
          
         Evenement event = new Evenement();
         UserEJB usr = (UserEJB) session.getValue("u");
         String lien = (String) session.getValue("lien");
         
         String[] criteres = {"dateDebutEvenement", "idTypeEvenement"};
         String[] intervalles = {"dateDebutEvenement"};
         String[] entetes = {"description"};
         
         PageRecherche pr = new PageRecherche( event, request, criteres, intervalles, 3, entetes, entetes.length);
         pr.setUtilisateur(usr);
         pr.setLien(lien);
         
         Evenement e = new Evenement();
         e.setNomTable("v_event_calendar_vide");
         
         PageInsert pi = new PageInsert(e, request, usr );
         pi.setLien(lien);
         
         pi.getFormu().getChamp("description").setLibelle("Description");
         pi.getFormu().getChamp("dateDebutEvenement").setLibelle("Date début");
         pi.getFormu().getChamp("dateFinEvenement").setLibelle("Date Fin");
         
         Liste[] list = { new Liste("idTypeEvenement", new TypeEvenement(), "desce", "id") }; 
         pi.getFormu().changerEnChamp(list);
         pi.getFormu().getChamp("idTypeEvenement").setLibelle("Type d'evenement");
         
         pi.preparerDataFormu();
         pi.getFormu().makeHtmlInsertSimple();
         
         String[] colSomme = null;
         
         pr.creerObjetPage(entetes, colSomme);
         pr.getFormu().makeHtmlInsertTabIndex();
         Evenement[] data = (Evenement[]) pr.getTableau().getData();
         String redirection = pi.getLien() + "?but=evenement/evenement-fiche.jsp";
         String eventJSON = CalendarUtils.getEventsJSON(data, redirection);
         
%>


<div class="content-wrapper">
    <section class="content-header">
        Les Evenements
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-5">
                <div class="box box-primary">
                    <div class="box-body">
                        <div class="row">
                            <form method="POST">
                                <%= pi.getFormu().getHtmlInsert()%>
                            </form>
                        </div>
                    </div>
                    <div class="box-footer"></div>
                </div>
                
            </div>
            <div class="col-md-6 bg-white p-2">
                <div id="calendar"> </div>
            </div>
        </div>
    </section>
</div>

<script src="${pageContext.request.contextPath}/assets/js/fc-6/index.global.min.js"></script>
<script>
    $(document).ready( function() {
        var calendarEl = document.getElementById('calendar');
        var data = <%= eventJSON %>;
        // var events = JSON.parse(data);
        var calendar = new FullCalendar.Calendar(calendarEl, {
          headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,dayGridWeek,dayGridDay'
          },
          initialDate: "<%= utilitaire.Utilitaire.dateDuJourSql().toString() %>",
          navLinks: true, // can click day/week names to navigate views
          editable: true,
          dayMaxEvents: true, // allow "more" link when too many events
          events: data,
          
          datesSet: async function(dateInfo) {
              let start = dateInfo.start;
              start = start.toISOString();
              let end = dateInfo.end;
              end = end.toISOString();
              let url = "/fjkm/evenements?dateMin=" + start + "&dateMax=" + end + "&redirection-link=" + redirection;   
              await fetchEvents(url);
          }
    });
    
    async function fetchEvents( url ){
        fetch( url )
                .then( response => response.json() )
                .then( data => {
                        // calendar.getEvents().forEach( event => event.remove() );
                        calendar.removeAllEvents();
                        data.forEach( d => calendar.addEvent(d) );
                });
    }
    calendar.render();
    });
</script>

<%
          }catch(Exception ev){
ev.printStackTrace();
}
%>