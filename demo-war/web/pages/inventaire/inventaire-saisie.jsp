<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="bean.*"%> 
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.UserEJB"%>
<%@ page import="affichage.*" %>
<%@ page import="inventaire.*" %>
<%@page import="annexe.*"%>
<%@page import="magasin.*"%>
<%
    try {
        UserEJB u = u = (UserEJB) session.getValue("u");
        String classeMere = "inventaire.Inventaire",
               classeFille = "inventaire.InventaireFille",
               titre = "Saisie Invetaire de stock",
			   redirection = "inventaire/inventaire-fiche.jsp";
        String colonneMere = "idMere";
        int taille = 10;

        Inventaire mere = new Inventaire();
        InventaireFille fille = new InventaireFille();

        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, taille, u);
        pi.setLien((String) session.getValue("lien")); 

        Liste[] liste = new Liste[1];
        
        Magasin magasin = new Magasin();
        liste[0] = new Liste("idMagasin",magasin,"val","id");

        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("designation").setLibelle("Designation");
        pi.getFormu().getChamp("remarque").setLibelle("Remarque");
        pi.getFormu().getChamp("idMagasin").setLibelle("Magasin");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("daty").setDefaut(""+Utilitaire.dateDuJour());
        pi.getFormu().getChamp("etat").setVisible(false);

        pi.getFormufle().getChamp("idproduit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
        pi.getFormufle().getChamp("explication_0").setLibelle("Explication");

        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false); 
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idMere"),false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("quantitetheorique"),false);

        affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idproduit"),"annexe.Produit","id","PRODUIT","","");
 
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
            <h2>Détails Inventaire stock</h2>
        </div>
        <%
            out.println(pi.getFormufle().getHtmlTableauInsert());

        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nomtable" type="hidden" id="classefille" value="InventaireFille">
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
<% }%>
