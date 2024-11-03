<%@ page import="recette.*" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        Recette recette = new Recette();
        PageInsert pi = new PageInsert(recette, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        pi.setTitre("Enregistrement Recette");
        affichage.Champ[] liste = new affichage.Champ[3];

        TypeObjet typeRecette = new TypeObjet();
        typeRecette.setNomTable("typerecette");
        liste[0] = new Liste("idtyperecette", typeRecette, "val", "id");

        TypeObjet ligneCredit = new TypeObjet();
        ligneCredit.setNomTable("v_lignecredit_recette");
        liste[1] = new Liste("idlignecredit", ligneCredit, "val", "id");

        TypeObjet caisse = new TypeObjet();
        caisse.setNomTable("CAISSE");
        liste[2] = new Liste("idCaisse", caisse, "val", "id");

        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("daty").setLibelle("Date de recette");
        pi.getFormu().getChamp("daty").setDefaut("" + Utilitaire.dateDuJourSql());
        pi.getFormu().getChamp("montant").setLibelle("Montant");
        pi.getFormu().getChamp("idtyperecette").setLibelle("Type de recette");
        pi.getFormu().getChamp("idlignecredit").setLibelle("Ligne de cr&eacute;dit");
        pi.getFormu().getChamp("idCaisse").setLibelle("Caisse");

        pi.getFormu().getChamp("etat").setVisible(false);

        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=pi.getTitre()%> </h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" data-parsley-validate>
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="recette/recette-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="recette.Recette">
    <input name="nomtable" type="hidden" id="nomtable" value="RECETTE">
    </form>
</div>
<% 
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
