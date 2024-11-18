<%@ page import="famille.*" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        Valopy recette = new Valopy();
        PageInsert pi = new PageInsert(recette, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        pi.setTitre("Enregistrement");

        pi.getFormu().getChamp("idfamille").setPageAppelComplete("famille.Famille","id","famille");
        pi.getFormu().getChamp("idMpivavaka").setPageAppelComplete("famille.Mpivavaka","id","mpivavaka");

        pi.getFormu().getChamp("val").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("desce").setLibelle("Description");
        pi.getFormu().getChamp("idfamille").setLibelle("Famille");
        pi.getFormu().getChamp("idMpivavaka").setLibelle("Payeur");

        pi.getFormu().getChamp("daty").setLibelle("Date de recette");
        pi.getFormu().getChamp("daty").setDefaut("" + Utilitaire.dateDuJourSql());
        pi.getFormu().getChamp("montant").setLibelle("Montant");

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
    <input name="bute" type="hidden" id="bute" value="famille/valopy-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="famille.Valopy">
    <input name="nomtable" type="hidden" id="nomtable" value="valopy">
    </form>
</div>
<% 
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
