<%-- 
    Document   : cotisation-ajout-paiement
    Created on : Nov 4, 2024, 6:21:11 AM
    Author     : sarobidy
--%>


<%@page import="affichage.PageUpdateMultiple"%>
<%@page import="bean.CGenUtil"%>
<%@page import="affichage.Champ"%>
<%@page import="affichage.Liste"%>
<%@page import="java.util.Vector"%>
<%@page import="user.UserEJB"%>
<%@page import="cotisation.DetailCotisation"%>
<%@page import="cotisation.Cotisation"%>
<%
//Ahoana no atao eto
// Manao page Insert multiple

    Cotisation cotisation = new Cotisation();
    cotisation.setNomTable("v_paiement_cotisation_lib");
    DetailCotisation detail = new DetailCotisation();
    
    
    UserEJB user = (UserEJB) session.getValue("u");
    String lien = (String) session.getValue("lien");
    int nbLine = 10;
    int minYear = 2015;
    
    detail.setIdPaiementCotisation(request.getParameter(cotisation.getAttributIDName()));
    DetailCotisation[] details = (DetailCotisation[]) CGenUtil.rechercher(detail, null, null, null, "");
        
    PageUpdateMultiple pi = new PageUpdateMultiple(cotisation, detail, details ,request, user, nbLine);
    pi.setLien(lien);
    pi.setTitre("Ajouter paiement pour la cotisation");
    Vector<String> years = new Vector<>();
    
    for( int i = utilitaire.Utilitaire.getAneeEnCours(); i >= minYear ; i-- ){
        years.add( String.valueOf(i) );
    }
    
    String[] annee =  years.toArray( new String[0] );
    Liste[] list = new Liste[2];
    list[0] = new Liste("mois");
    list[0].makeListeMois();
    list[1] = new Liste("annee", annee, annee);
    
    
    pi.getFormu().getChamp("moisLib").setLibelle("Mois");
    pi.getFormu().getChamp("moisLib").setAutre("readonly");
    pi.getFormu().getChamp("annee").setAutre("readonly");
    pi.getFormu().getChamp("annee").setLibelle("Annee");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("mois").setVisible(false);
    
    Champ.setVisible(pi.getFormufle().getChampFille("idPaiementCotisation"), false);
    Champ.setVisible(pi.getFormufle().getChampFille("idDetailPaiement"), false);
    
    Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idMpivavaka"), "croyance.MpivavakaLib", "idMpivavaka", "v_mpivavaka_lib");
    
    pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    pi.getFormufle().getChamp("idMpivavaka_0").setLibelle("Croyant");
    pi.getFormufle().getChamp("datePaiement_0").setLibelle("Date de Paiement");
    pi.getFormufle().getChamp("referencePaiement_0").setLibelle("R&eacute;ference");
    pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
    
    Champ.setDefaut(pi.getFormufle().getChampFille("datePaiement"), utilitaire.Utilitaire.dateDuJour());
    
    
    
    String[] ordres = {"idMpivavaka", "datePaiement", "referencePaiement","montant"};
    pi.getFormufle().setColOrdre(ordres);
    
    pi.preparerDataFormu();
    
    pi.getFormu().makeHtmlInsertTabIndex();
    pi.getFormufle().makeHtmlInsertTableauIndex();
    
    String bute = "cotisation/cotisation-fiche.jsp",
    classe = "cotisation.Cotisation",
    classeFille = "cotisation.DetailCotisation",
    nomtable = "detailpaiementcotisation",
    mere = "idPaiementCotisation";
    

%>

<div class="content-wrapper">
    <h1> 
        <%= pi.getTitre() %>
    </h1>
                    
        <form action="<%= pi.getLien() %>?but=apresMultiple.jsp&idPaiementCotisation=<%= request.getParameter(cotisation.getAttributIDName()) %>" method="post">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                            out.println(pi.getFormufle().getHtmlTableauInsert());
                        %>
                        <input name="acte" type="hidden" id="acte" value="updateInsert">
                        <input name="bute" type="hidden" id="bute" value="<%= bute %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
                        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= mere %>">
                        <input name="nomtable" type="hidden" id="colonneMere" value="<%= nomtable %>">
                        
                            <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nbLine %>">

                    </form>
</div>