<%-- 
    Document   : ajouter-membre
    Created on : Oct 20, 2024, 5:42:55 AM
    Author     : sarobidy
--%>

<%@page import="bean.CGenUtil"%>
<%@page import="bureaux.TypeBureau"%>
<%@page import="utilisateur.Role"%>
<%@page import="affichage.Liste"%>
<%@page import="affichage.Champ"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="bureaux.membership.MembreBureaux"%>
<%@page import="bureaux.Bureaux"%>
<%
          try{
                Bureaux bureaux = new Bureaux();
                MembreBureaux membre = new MembreBureaux();

                int nbLine = 10;
                String lien = (String) session.getValue("lien");
                UserEJB user = (UserEJB) session.getValue("u");

                PageInsertMultiple pi = new PageInsertMultiple(bureaux, membre, request, nbLine, user);
                
                Liste[] champMere = new Liste[1];
                champMere[0] = new Liste("idTypeBureau", new TypeBureau(), "val", "id");
                
                pi.getFormu().changerEnChamp(champMere);
                
                // Visibilité des champs
                pi.getFormu().getChamp("etat").setVisible(false);
                Champ.setVisible( pi.getFormufle().getChampFille("etat") , false);
                Champ.setVisible(pi.getFormufle().getChampFille("idBureaux") , false);
                Champ.setVisible(pi.getFormufle().getChampFille("idMembreBureaux") , false);
                
                // Valeur par défaut
                Champ.setDefaut( pi.getFormufle().getChampFille("dateAdmission") , utilitaire.Utilitaire.dateDuJour());
                
                // Comportement des champs
                Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idMpivavaka"), "croyance.MpivavakaLib", "idMpivavaka", "v_mpivavaka_lib");
                Liste[] roles = new Liste[1];
                roles[0] = new Liste("idRole", new Role(), "descrole", "idrole");
                Champ.setDefaut(pi.getFormufle().getChampFille("idRole"), utils.ConstanteFJKM.MEMBRE);
                
                String[] ordres = {"idMpivavaka", "idRole", "dateAdmission"};
                
                pi.getFormufle().setColOrdre(ordres);
                
                pi.getFormufle().changerEnChamp(roles);
                
                // Okey eto isika izao i-passer id avy eny ambony
                
                // Libellé des champs
                
                pi.getFormu().getChamp("nomBureaux").setLibelle("Nom du Bureau");
                pi.getFormu().getChamp("descriptionBureaux").setLibelle("Description");
                pi.getFormu().getChamp("dateCreation").setLibelle("Date de cr&eacute;ation");
                pi.getFormu().getChamp("dateCreation").setDefaut(utilitaire.Utilitaire.dateDuJour());
                pi.getFormu().getChamp("idTypeBureau").setLibelle( "Type de Bureaux" );
                pi.getFormufle().getChamp("idMpivavaka_0").setLibelle("Mpivavaka");
                pi.getFormufle().getChamp("idRole_0").setLibelle("Role");
                pi.getFormufle().getChamp("dateAdmission_0").setLibelle("Date d&apos;admission");
                
                // Si l'objet existe déja
                String idBureaux = request.getParameter("idBureaux");
                if( idBureaux != null && !idBureaux.isEmpty() ){
                    bureaux.setTuppleId(idBureaux);
                    bureaux = ((Bureaux[]) CGenUtil.rechercher( bureaux , null, null, ""))[0];
                    pi.getFormu().getChamp("nomBureaux").setDefaut( bureaux.getNomBureaux() );
                    pi.getFormu().getChamp("descriptionBureaux").setDefaut( bureaux.getDescriptionBureaux() );
                    pi.getFormu().getChamp("dateCreation").setDefaut(bureaux.getDateCreation().toString());
                    pi.getFormu().getChamp("idTypeBureau").setDefaut(bureaux.getTypeBureau());
                    pi.getFormu().getChamp("etat").setDefaut(String.valueOf(bureaux.getEtat()));
                }
                
                pi.preparerDataFormu();
                pi.setTitre("Ajout des membres pour le bureau");

                pi.setLien(lien);

              pi.getFormu().makeHtmlInsertTabIndex();
              pi.getFormufle().makeHtmlInsertTableauIndex();

              String butApresPost = "",
                      classeMere = "bureaux.Bureaux",
                      classeFille = "bureaux.membership.MembreBureaux",
                      colonneMere = "idBureaux";
          
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
    
    
    <%
              }catch(Exception e){
e.printStackTrace();
}
    %>