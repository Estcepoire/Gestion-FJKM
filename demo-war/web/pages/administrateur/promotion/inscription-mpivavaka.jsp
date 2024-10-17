<%-- 
    Document   : inscription-mpivavaka
    Created on : Oct 13, 2024, 6:42:42 PM
    Author     : sarobidy
--%>

<%@page import="bean.CGenUtil"%>
<%@page import="affichage.Champ"%>
<%@page import="croyance.fandraisana.Mpandray"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="croyance.MpivavakaLib"%>
<%@page import="croyance.promotion.Promotion"%>
<%
          
//    Formulaire Mère fille
//    Mère = Promotion
//    Fille = Liste ana mpivavaka
//    Action = mampiditra mpandray vaovao ho lasa mpianatra
//    Andao Ary eh

        Promotion p = new Promotion();
        Mpandray mpivavaka = new Mpandray();
        int nbLine = 10;
        
        String idPromotion = request.getParameter("idPromotion");
        
        
        UserEJB user = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");
        
        PageInsertMultiple pi = new PageInsertMultiple(p, mpivavaka, request, nbLine, user);
        pi.setTitre("Inscrire des croyants vers Mpandray");
        pi.setUtilisateur(user);
        
        
        Champ.setVisible( pi.getFormufle().getChampFille("idMpandray") , false);
        Champ.setVisible( pi.getFormufle().getChampFille("etat") , false);
        Champ.setVisible( pi.getFormufle().getChampFille("idPromotion") , false);
        Champ.setAutre(pi.getFormufle().getChampFille("numeroMpandray"), "readonly");
        Champ.setAutre(pi.getFormufle().getChampFille("dateNandraisana"), "readonly");
        
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("anneePromotion").setLibelle("Annee Promotion");
        pi.getFormu().getChamp("anneePromotion").setDefaut( utilitaire.Utilitaire.getAnneeEnCours() );
        pi.getFormu().getChamp("nomPromotion").setLibelle("Nom de la Promotion");
        pi.getFormu().getChamp("dateSortie").setLibelle("Date de Sortie");
        
        pi.getFormufle().getChamp("dateNandraisana_0").setLibelle("Date Nandraisana");
        pi.getFormufle().getChamp("numeroMpandray_0").setLibelle("Num&eacute;ro mpandray");
        pi.getFormufle().getChamp("idMpivavaka_0").setLibelle("Mpivavaka");
        
        if( idPromotion != null && !idPromotion.isEmpty() ){
            p.setIdPromotion(idPromotion);
            p = ((Promotion[]) CGenUtil.rechercher( p , null, null, ""))[0]; // maka anaty base
            pi.getFormu().getChamp("anneePromotion").setDefaut( String.valueOf( p.getAnneePromotion() ) );
            pi.getFormu().getChamp("etat").setDefaut( String.valueOf( p.getEtat()) );
            pi.getFormu().getChamp("nomPromotion").setDefaut( p.getNomPromotion() );
            pi.getFormu().getChamp("dateSortie").setDefaut( p.getDateSortie().toString() );
        }
        
        
        String[] ordres = {"idMpivavaka", "numeroMpandray", "dateNandraisana"};
        
        pi.getFormufle().setColOrdre(ordres);
        
        Champ.setPageAppelComplete( pi.getFormufle().getChampFille("idMpivavaka") , "croyance.MpivavakaLib", "idMpivavaka", "v_mpivavaka_lib");
        
        
        pi.preparerDataFormu();
//        pi.preparerDataFormuFille();
        
        pi.setLien(lien);

        pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormufle().makeHtmlInsertTableauIndex();
        
        String butApresPost = "",
                   classeMere = "croyance.promotion.Promotion",
                   classeFille = "croyance.fandraisana.Mpandray",
                   colonneMere = "idPromotion";
%>

<div class="content-wrapper">
    <!-- A modifier -->
    <h1>
        <%= pi.getTitre() %>
    </h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" >
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