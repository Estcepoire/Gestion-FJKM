<%@ page import="depense.*" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        Depense depense = new Depense();
        PageInsert pi = new PageInsert(depense, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        pi.setTitre("Enregistrement D&eacute;pense");
        affichage.Champ[] liste = new affichage.Champ[2];

        TypeObjet typeDepense = new TypeObjet();
        typeDepense.setNomTable("typedepense");
        liste[0] = new Liste("idtypedepense", typeDepense, "val", "id");

        TypeObjet ligneCredit = new TypeObjet();
        ligneCredit.setNomTable("v_lignecredit_depense");
        liste[1] = new Liste("idlignecredit", ligneCredit, "val", "id");


        TypeObjet caisse = new TypeObjet();
        caisse.setNomTable("CAISSE");
        liste[1] = new Liste("idCaisse", caisse, "val", "id");

        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("daty").setLibelle("Date de d&eacute;pense");
        pi.getFormu().getChamp("daty").setDefaut(""+Utilitaire.dateDuJourSql());
        pi.getFormu().getChamp("montant").setLibelle("Montant");
        pi.getFormu().getChamp("idtypedepense").setLibelle("Type de d&eacute;pense");
        pi.getFormu().getChamp("idlignecredit").setLibelle("Ligne de cr&eacute;dit");
        pi.getFormu().getChamp("idCaisse").setLibelle("Caisse");

        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idOrigine").setVisible(false);

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
    <input name="bute" type="hidden" id="bute" value="depense/depense-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="depense.Depense">
    <input name="nomtable" type="hidden" id="nomtable" value="DEPENSE">
    </form>
</div>
<% 
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
