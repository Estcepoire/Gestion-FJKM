<%-- 
    Document   : ajouter
    Created on : Oct 19, 2024, 6:36:27 AM
    Author     : sarobidy
--%>

<%@page import="bureaux.Bureaux"%>
<%@page import="utilisateur.Role"%>
<%@page import="affichage.Liste"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsert"%>
<%@page import="bureaux.membership.MembreBureaux"%>
<%
//          Eto no asiana ajout simple fotsiny
//          Olona ray, bureaux ray, role 1

            MembreBureaux membre = new MembreBureaux();
            
            UserEJB utilisateur = (UserEJB) session.getValue("u");
            String lien = (String) session.getValue("lien");
            
            PageInsert pi = new PageInsert( membre, request, utilisateur);
            pi.setTitre("Ajout membre bureaux unique");
            pi.setLien(lien);
            
            
            Liste[] list = new Liste[2];
            list[0] = new Liste("idRole", new Role(), "descrole", "idrole");
            list[1] = new Liste("idBureaux", new Bureaux(), "nomBureaux", "idBureaux");
            
            pi.getFormu().changerEnChamp(list);
            
            // Type champs
            
            pi.getFormu().getChamp("idMpivavaka").setPageAppelComplete("croyance.MpivavakaLib", "idMpivavaka", "v_mpivavaka_lib");
           
            // Visibilté des champs
            pi.getFormu().getChamp("etat").setVisible(false);
            
            // Libelle
            pi.getFormu().getChamp("idRole").setLibelle("Role");
            pi.getFormu().getChamp("idMpivavaka").setLibelle("Mpivavaka");
            pi.getFormu().getChamp("idBureaux").setLibelle("Bureaux");
            pi.getFormu().getChamp("dateAdmission").setLibelle("Date d&apos;admission");
            // Valeur par defaut
            pi.getFormu().getChamp("idRole").setDefaut( utils.ConstanteFJKM.MEMBRE );
            pi.getFormu().getChamp("dateAdmission").setDefaut( utilitaire.Utilitaire.dateDuJour());
            
            
            pi.preparerDataFormu();
            pi.getFormu().makeHtmlInsertTabIndex();
            
            String afterPost = "administrateur/bureau/liste.jsp";
            String mappingClass = "bureaux.membership.MembreBureaux";
            String nomTable = "membrebureaux";


%>


<div class="content-wrapper">
    <section class="content-header">
        <%= pi.getTitre() %>
    </section>
    <section class="content">
        <form action="<%= pi.getLien() %>?but=apresTarif.jsp" data-parsley-validate method="post">
        <%= pi.getFormu().getHtmlInsert() %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= afterPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= mappingClass %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
    </section>
</div>