<%@page import="annexe.*"%>
<%@page import="famille.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="affichage.*"%>
<%@page import="bean.*"%> 
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.*"%>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = u = (UserEJB) session.getValue("u");
        String classeMere = "famille.Famille",
               classeFille = "famille.FamilleFille",
               titre = "Saisie Famille ",
			   redirection = "famille/famille-fiche.jsp";
        String colonneMere = "idMere";
        int taille = 10;

        Famille mere = new Famille();
        mere.setNomTable("famille");

        FamilleFille fille = new FamilleFille();
        fille.setNomTable("familleFille");
        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, taille, u);
        pi.setLien((String) session.getValue("lien")); 

        Liste[] liste = new Liste[1];
        
        TypeObjet faritra = new TypeObjet();
        faritra.setNomTable("faritra");
        liste[0] = new Liste("idFaritra",faritra,"val","id");

        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("val").setLibelle("D&eacute;signation *");
        pi.getFormu().getChamp("desce").setLibelle("Description");
        pi.getFormu().getChamp("idFaritra").setLibelle("Faritra");
        pi.getFormu().getChamp("etat").setVisible(false);

        affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idMpivavaka"),"famille.Mpivavaka","id","mpivavaka");

        pi.getFormufle().getChamp("remarque_0").setLibelle("Remarque");
        pi.getFormufle().getChamp("idMpivavaka_0").setLibelle("Membre");

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
        <input name="nomtable" type="hidden" id="classefille" value="familleFille">
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
