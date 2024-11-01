<%@page import="annexe.*"%>
<%@page import="ligneCredit.*"%>
<%@page import="facture.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="affichage.*"%>
<%@page import="bean.*"%> 
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.*"%>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = u = (UserEJB) session.getValue("u");
        String classeMere = "facture.FactureFournisseur",
               classeFille = "facture.FactureFournisseurFille",
               titre = "Saisie facture Fournisseur",
			   redirection = "facture/facture-fournisseur-fiche.jsp";
        String colonneMere = "idMere";
        int taille = 10;

        FactureFournisseur mere = new FactureFournisseur();

        FactureFournisseurFille fille = new FactureFournisseurFille();

        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, taille, u);
        pi.setLien((String) session.getValue("lien")); 

        pi.getFormu().getChamp("idTiers").setPageAppelComplete("tiers.Tiers","id","tiers");

        Liste[] liste = new Liste[1];
        
        LigneCredit ligneCredit = new LigneCredit();
        liste[0] = new Liste("idlignecredit",ligneCredit,"val","id");

        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("val").setLibelle("D&eacute;signation *");
        pi.getFormu().getChamp("idTiers").setLibelle("Tiers *");
        pi.getFormu().getChamp("idlignecredit").setLibelle("ligne credit *");
        pi.getFormu().getChamp("desce").setLibelle("Description");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("daty").setDefaut(""+Utilitaire.dateDuJourSql());

        pi.getFormu().getChamp("etat").setVisible(false);
        
        affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idproduit"),"annexe.Produit","id","PRODUIT","","");

        pi.getFormufle().getChamp("quantite_0").setLibelle("Quantit&eacute;");
        pi.getFormufle().getChamp("remarque_0").setLibelle("Remarque");
        pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("prixUnitaire_0").setLibelle("prix Unitaire");

        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idMere"),false);


        pi.preparerDataFormu();

        pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormufle().makeHtmlInsertTableauIndex();
%>
<div class="content-wrapper">
    <h1><%=titre%></h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" >
        <%
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <div style="text-align: center;">
            <h2>D&eacute;tails Facture </h2>
        </div>
        <%
            out.println(pi.getFormufle().getHtmlTableauInsert());

        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nomtable" type="hidden" id="classefille" value="factureFournisseurFille">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="10">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%=colonneMere%>">
    </form>
</div>

<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% } %>
