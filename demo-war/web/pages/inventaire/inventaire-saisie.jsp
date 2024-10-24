<%@page import="annexe.*"%>
<%@page import="magasin.*"%>
<%@page import="stock.details.*"%>
<%@page import="stock.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="affichage.*"%>
<%@page import="bean.*"%> 
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.*"%>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = u = (UserEJB) session.getValue("u");
        String classeMere = "stock.MvtStock",
               classeFille = "stock.MvtStockFille",
               titre = "Saisie mouvement de stock",
			   redirection = "stock/mvtstock-fiche.jsp";
        String colonneMere = "idMere";
        int taille = 10;
        MvtStock mere = new MvtStock();
        mere.setNomTable("MVTSTOCK");

        MvtStockFille fille = new MvtStockFille();
        fille.setNomTable("MVTSTOCKFILLE");

        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, taille, u);
        pi.setLien((String) session.getValue("lien")); 

        Liste[] liste = new Liste[2];

        TypeMvtStock typemvt = new TypeMvtStock();
        liste[0] = new Liste("idTypeMvStock",typemvt,"val","id");
        
        Magasin magasin = new Magasin();
        liste[1] = new Liste("idMagasin",magasin,"val","id");

        pi.getFormu().changerEnChamp(liste);
    
        pi.getFormu().getChamp("idMagasin").setLibelle("Magasin");
        pi.getFormu().getChamp("idTypeMvStock").setLibelle("Type mouvement de stock");
        pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation*");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("daty").setDefaut(""+Utilitaire.dateDuJourSql());

        pi.getFormu().getChamp("etat").setVisible(false);
        
        affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idProduit"),"annexe.Produit","id","PRODUIT");
        
        pi.getFormufle().getChamp("quantites_0").setLibelle("Quantit&eacute;");
        pi.getFormufle().getChamp("remarque_0").setLibelle("Remarque");
        pi.getFormufle().getChamp("designation_0").setLibelle("Disignation");
        pi.getFormufle().getChamp("prixUnitaire_0").setLibelle("Prix Unitaire");
        pi.getFormufle().getChamp("prixUnitaire_0").setAutre("readOnly");
        pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");

        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("Sortie"),false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("entree"),false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idMere"),false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("etat"),false);


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
            <h2>D&eacute;tails mouvement de stocks</h2>
        </div>
        <%
            out.println(pi.getFormufle().getHtmlTableauInsert());

        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nomtable" type="hidden" id="classefille" value="mvtstockfille">
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
