<%-- 
    Document   : update
    Created on : Oct 12, 2024, 7:02:42 AM
    Author     : sarobidy
--%>

<%@page import="croyance.promotion.Promotion"%>
<%@page import="affichage.Liste"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="croyance.fandraisana.Mpandray"%>
<%
          
         Mpandray mpandray = new Mpandray();
         mpandray.setNomTable("v_mpandray_lib");
         UserEJB user = (UserEJB) session.getValue("u");
         String lien = (String) session.getValue("lien");
         PageUpdate pi = new PageUpdate( mpandray , request, user);
         pi.setLien(lien);
         
         pi.getFormu().getChamp("etat").setVisible(false);
         pi.getFormu().getChamp("idMpivavaka").setVisible(false);
         pi.getFormu().getChamp("nomComplet").setAutre("readonly");
         pi.getFormu().getChamp("nomComplet").setLibelle("Nom Complet");
         pi.getFormu().getChamp("genre").setVisible(false);
         pi.getFormu().getChamp("idPromotion").setLibelle("Promotion");
         pi.getFormu().getChamp("idMpandray").setVisible(false);
         pi.getFormu().getChamp("numeroMpandray").setLibelle("Numero Mpandray");
         pi.getFormu().getChamp("dateNandraisana").setLibelle("Date Nandraisana");
         
         
         Liste[] listes = { new Liste("idPromotion", new Promotion(), "nomPromotion", "idPromotion") };
         
         pi.getFormu().changerEnChamp(listes);
         
         pi.getFormu().getChamp("idPromotion").setLibelle("Promotion");
         
         
         pi.preparerDataFormu();
         pi.getFormu().makeHtmlInsertTabIndex();
         
         pi.setTitre("Modification Mpandray");
         
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
        <input name="acte" type="hidden" id="nature" value="update">
        <input name="bute" type="hidden" id="bute" value="<%= afterPost %>">
        <input name="rajoutLien" type="hidden" id="rajoutLien" value="idMpandray-<%= mpandray.getTuppleID()%>" >
        <input name="classe" type="hidden" id="classe" value="<%= mappingClass %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
    
</div>