<%-- 
    Document   : saisie
    Created on : Oct 12, 2024, 6:31:31 AM
    Author     : sarobidy
--%>

<%@page import="bean.CGenUtil"%>
<%@page import="croyance.promotion.Promotion"%>
<%@page import="affichage.Liste"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsert"%>
<%@page import="croyance.fandraisana.Mpandray"%>
<%
          
         Mpandray mpandray = new Mpandray();
         String idMpivavaka = (String) request.getParameter("idMpivavaka");
         
         UserEJB user = (UserEJB) session.getValue("u");
         String lien = (String) session.getValue("lien");
         PageInsert pi = new PageInsert( mpandray , request, user);
         pi.setLien(lien);
         
         pi.getFormu().getChamp("etat").setVisible(false);
         pi.getFormu().getChamp("numeroMpandray").setLibelle("Numero Mpandray");
         pi.getFormu().getChamp("numeroMpandray").setAutre("readonly");
         pi.getFormu().getChamp("dateNandraisana").setLibelle("Date Nandraisana");
         pi.getFormu().getChamp("idMpivavaka").setLibelle("Mpivavaka");
         pi.getFormu().getChamp("idMpivavaka").setPageAppelComplete("croyance.MpivavakaLib", "idMpivavaka", "v_mpivavaka_lib");
         
         if( idMpivavaka != null && !idMpivavaka.isEmpty() ){
            mpandray.setIdMpivavaka(idMpivavaka);
            mpandray.setNomTable("v_mpivavaka_lib");
            mpandray =( (Mpandray[]) CGenUtil.rechercher(mpandray, null, null, "") )[0];
            pi.getFormu().getChamp("idMpivavaka").setDefaut(idMpivavaka);
            pi.getFormu().getChamp("idMpivavaka").setAutoCompleteLibelle( mpandray.getNomComplet() );
          }
         
         
         
         Liste[] listes = { new Liste("idPromotion", new Promotion(), "nomPromotion", "idPromotion") };
         
         pi.getFormu().changerEnChamp(listes);
         
         pi.getFormu().getChamp("idPromotion").setLibelle("Promotion");
         
         
         pi.preparerDataFormu();
         pi.getFormu().makeHtmlInsertTabIndex();
         
         pi.setTitre("Raisina ho mpandray");
         
        String afterPost = "croyance/fandraisana/fiche.jsp";
        String mappingClass = "croyance.fandraisana.Mpandray";
        String nomTable = "mpandray";

%>
<!--
---- Inona no andeha atao
---- Mila mifidy anle mpivavaka aloha
---- avy eo mifidy promotion
---- Reo no dépendante
---- Ny date fandraisana feno rehefa mifidy promotion ilay olona-->

<div class="content-wrapper">
    <h1 class="text-align-center">
            <%= pi.getTitre() %>
    </h1>
    
    <form action="<%= pi.getLien() %>?but=apresTarif.jsp" data-parsley-validate method="POST">
        <%= pi.getFormu().getHtmlInsert() %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= afterPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= mappingClass %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
    
</div>