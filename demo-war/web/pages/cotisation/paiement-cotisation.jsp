<%-- 
    Document   : paiement-cotisation
    Created on : Nov 3, 2024, 7:43:19 AM
    Author     : sarobidy
--%>

<%@page import="affichage.Champ"%>
<%@page import="affichage.Liste"%>
<%@page import="java.util.Vector"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="cotisation.DetailCotisation"%>
<%@page import="cotisation.Cotisation"%>
<%
//Ahoana no atao eto
// Manao page Insert multiple

    Cotisation cotisation = new Cotisation();
    DetailCotisation detail = new DetailCotisation();
    
    UserEJB user = (UserEJB) session.getValue("u");
    String lien = (String) session.getValue("lien");
    int nbLine = 10;
    int minYear = 2015;
    
    PageInsertMultiple pi = new PageInsertMultiple(cotisation, detail, request, nbLine, user);
    pi.setLien(lien);
    
    Vector<String> years = new Vector<>();
    
    for( int i = utilitaire.Utilitaire.getAneeEnCours(); i >= minYear ; i-- ){
        years.add( String.valueOf(i) );
    }
    
    String[] annee =  years.toArray( new String[0] );
    Liste[] list = new Liste[2];
    list[0] = new Liste("mois");
    list[0].makeListeMois();
    list[1] = new Liste("annee", annee, annee);
    
    pi.getFormu().changerEnChamp(list);
    
    pi.getFormu().getChamp("mois").setLibelle("Mois");
    pi.getFormu().getChamp("annee").setLibelle("Annee");
    pi.getFormu().getChamp("etat").setVisible(false);
    
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
    
    String bute = "",
    classe = "cotisation.Cotisation",
    classeFille = "cotisation.DetailCotisation",
    nomtable = "detailpaiementcotisation",
    mere = "idPaiementCotisation";
    

%>

<div class="content-wrapper">
    <h1> 
        <%= pi.getTitre() %>
    </h1>
                    
                    <form action="<%= pi.getLien() %>?but=apresMultiple.jsp" method="post">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                            out.println(pi.getFormufle().getHtmlTableauInsert());
                        %>
                        <input name="acte" type="hidden" id="acte" value="insert">
                        <input name="bute" type="hidden" id="bute" value="<%= bute %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
                        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= mere %>">
                        <input name="nomtable" type="hidden" id="colonneMere" value="<%= nomtable %>">
                        
                            <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nbLine %>">

                    </form>
</div>