<%@page import="affichage.PageUpdateMultiple"%>
<%@page import="stock.details.*"%>
<%@page import="magasin.*"%>
<%@page import="stock.MvtStockFille"%>
<%@page import="stock.MvtStock"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.CGenUtil"%> 
<%@page import="utilitaire.Utilitaire"%>
<%@ page import="affichage.Champ" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = u = (UserEJB) session.getValue("u");
        String classeMere = "stock.MvtStock",
               classeFille = "stock.MvtStockFille",
               titre = "Modification mouvement de stock",
			   redirection = "stock/mvtstock-fiche.jsp";
        String colonneMere = "idMere";

        MvtStock mere = new MvtStock();
        mere.setNomTable("MVTSTOCK");
        MvtStockFille fille = new MvtStockFille();
        fille.setNomTable("MVTSTOCKFILLE");
        fille.setIdMvtStock(request.getParameter("id"));
        MvtStockFille[] details = (MvtStockFille[]) CGenUtil.rechercher(fille, null, null, "");
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, details, request, (user.UserEJB) session.getValue("u"), details.length);
        pi.setLien((String) session.getValue("lien")); 

        Liste[] liste = new Liste[2];
        TypeMvtStock typemvt = new TypeMvtStock();
        liste[0] = new Liste("idTypeMvStock",typemvt,"val","id");

        Magasin magasin = new Magasin();
        liste[0] = new Liste("idMagasin",magasin,"val","id");

        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("idMagasin").setLibelle("Magasin");
        pi.getFormu().getChamp("idTypeMvStock").setLibelle("Type mouvement de stock");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("etat").setVisible(false);
        
        affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idProduit"),"annexe.Produit","id","val","ïdUnite","prixUnitaire");
        
        pi.getFormufle().getChamp("idProduit_0").setLibelle("Entr&eacute;e");     
        pi.getFormufle().getChamp("designation_0").setLibelle("Designation");
        pi.getFormufle().getChamp("remarque_0").setLibelle("Remarque");
        pi.getFormufle().getChamp("prixUnitaire_0").setLibelle("Prix Unitaire");
        pi.getFormufle().getChamp("prixUnitaire_0").setAutre("readOnly");
        
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
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" >
        <%
            
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <div style="text-align: center;">
            <h2>Modification mouvement de stocks</h2>
        </div>
        <%
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="updateInsert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=details.length%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%=colonneMere%>">
        <input name="nomtable" type="hidden" id="classefille" value="mvtstockfille">
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
