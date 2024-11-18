<%@page import="consommation.*"%>
<%@page import="annexe.*"%>
<%@page import="bean.*"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.*"%>
<%@page import="affichage.*"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%
    try {
        UserEJB u = (UserEJB) session.getValue("u");
        String classeMere = "consommation.Consommation",
               classeFille = "consommation.ConsommationFille",
               titre = "Saisie Consommation",
               redirection = "consommation/consommation-fiche.jsp";
        String colonneMere = "idMere";
        int taille = 10;

        Consommation mere = new Consommation();
        mere.setNomTable("Consommation");

        ConsommationFille fille = new ConsommationFille();
        fille.setNomTable("Consommationfille");

        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, taille, u);
        pi.setLien((String) session.getValue("lien"));

        Liste[] liste = new Liste[1];
        TypeObjet typeConsommation = new TypeObjet();
        typeConsommation.setNomTable("typeconsommation");
        liste[0] = new Liste("itypeconsommation", typeConsommation, "val", "id");

        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("itypeconsommation").setLibelle("Type de Consommation");
        pi.getFormu().getChamp("val").setLibelle("D&eacute;signation*");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("daty").setDefaut("" + Utilitaire.dateDuJourSql());
        pi.getFormu().getChamp("description").setLibelle("Description");
        pi.getFormu().getChamp("etat").setVisible(false);

        affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idProduit"), "annexe.Produit", "id", "PRODUIT");

        pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("quantite_0").setLibelle("Quantit&eacute;");
        pi.getFormufle().getChamp("remarque_0").setLibelle("Remarque");

        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idMere"), false);

        pi.preparerDataFormu();

        pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormufle().makeHtmlInsertTableauIndex();
%>
<div class="content-wrapper">
    <h1><%=titre%></h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post">
        <%
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <div style="text-align: center;">
            <h2>D&eacute;tails Consommation</h2>
        </div>
        <%
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nomtable" type="hidden" id="nomtable" value="Consommationfille">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="10">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%=colonneMere%>">
        <button type="submit" class="btn btn-success">Enregistrer</button>
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
