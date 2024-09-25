<%@page import="annexe.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>


<%
    try {
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Produit t = new Produit();

    String classe = "annexe.Produit",
		nomTable = "Produit",
		butApresPost = "annexe/produit-fiche.jsp",
		titre = "Modification Produit";

    PageUpdate pu = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pu.setLien((String) session.getValue("lien"));
    pu.setTitre(titre);

    affichage.Champ[] liste = new affichage.Champ[2];      
    TypeObjet unite = new TypeObjet();
    unite.setNomTable("UNITE");
    liste[0] = new Liste("idUnite", unite, "val", "id");        
    TypeObjet type = new TypeObjet();
    type.setNomTable("TYPEPRODUIT");
    liste[1] = new Liste("idTypeProduit", type, "val", "id");       
    pu.getFormu().changerEnChamp(liste);
    pu.getFormu().getChamp("etat").setVisible(false);      
    pu.getFormu().getChamp("val").setLibelle("Designation");      
    pu.getFormu().getChamp("desce").setLibelle("Description");      
    pu.getFormu().getChamp("idTypeProduit").setLibelle("Type Produit");      
    pu.getFormu().getChamp("idUnite").setLibelle("Unite");  

    String id = pu.getBase().getTuppleID();
    pu.preparerDataFormu();
    pu.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1><%=titre%></h1>
    <form action="<%=pu.getLien()%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
        <%
            out.println(pu.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="acte" value="update">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
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