<%-- 
    Document   : participation-saisie
    Created on : Oct 26, 2024, 12:18:44 AM
    Author     : sarobidy
--%>

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
          
          PageInsertMultiple pi = new PageInsertMultiple(event, participant, request, nbLine, u);
          
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
          
          
          Champ.setVisible( pi.getFormufle().getChampFille("idParticipation") , false);
          Champ.setVisible( pi.getFormufle().getChampFille("idEvenement") , false);
          // Comportement des champs
                Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idMpivavaka"), "croyance.MpivavakaLib", "idMpivavaka", "v_mpivavaka_lib");
                
                
         String idEvenement = request.getParameter("idEvenement");
                if( idEvenement != null && !idEvenement.isEmpty() ){
                    event.setTuppleId(idEvenement);
                    event = ((Evenement[]) CGenUtil.rechercher( event , null, null, ""))[0];
                    pi.getFormu().getChamp("description").setDefaut( event.getDescription() );
                    pi.getFormu().getChamp("dateDebutEvenement").setDefaut( event.getDateDebutEvenement().toString() );
                    pi.getFormu().getChamp("dateFinEvenement").setDefaut( event.getDateFinEvenement().toString()  );
                    pi.getFormu().getChamp("heureDebut").setDefaut( event.getHeureDebut().toString() );
                    pi.getFormu().getChamp("heureFin").setDefaut( event.getHeureFin().toString() );
                    pi.getFormu().getChamp("idTypeEvenement").setDefaut( event.getIdTypeEvenement() );
                    pi.getFormu().getChamp("ouvert").setDefaut(  event.getOuvertString() );
                    pi.getFormu().getChamp("idMere").setDefaut( event.getIdMere() );
                    pi.getFormu().getChamp("idMpivavaka").setDefaut( event.getIdMpivavaka() );
                    pi.getFormu().getChamp("etat").setDefaut(String.valueOf(event.getEtat()));
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
%>


<div class="content-wrapper">
    <!-- A modifier -->
    <h1>
        <%= pi.getTitre() %>
    </h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp&idEvenement=<%= idEvenement %>" method="post" >
        <%
            
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nbLine %>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">
    </form>
        
</div>
