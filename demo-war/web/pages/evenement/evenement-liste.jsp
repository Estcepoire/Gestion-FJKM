<%-- 
    Document   : evenement-liste
    Created on : Oct 24, 2024, 10:12:07 PM
    Author     : sarobidy
--%>

<%@page import="utils.CalendarUtils"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="evenement.Evenement"%>

<%
          
         Evenement event = new Evenement();
         UserEJB usr = (UserEJB) session.getValue("u");
         String lien = (String) session.getValue("lien");
         
         String[] criteres = {};
         String[] intervalles = {};
         String[] entetes = {"description"};
         
         PageRecherche pr = new PageRecherche( event, request, criteres, intervalles, 3, entetes, entetes.length);
         pr.setUtilisateur(usr);
         pr.setLien(lien);
         String[] colSomme = null;
         
         pr.creerObjetPage(entetes, colSomme);
         Evenement[] data = (Evenement[]) pr.getTableau().getData();
         String eventJSON = CalendarUtils.getEventsJSON(data);
         
%>


<div class="content-wrapper">
    <section class="content-header">
        Les
    </section>
    <section class="content">
            <div id="calendar"> </div>
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
      events: data
    });

    calendar.render();
    });
</script>