<%@page import="utilisateur.Role"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.*" %>

<%
    try{
        // Session variables
        UserEJB user = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");

        Role mapping = new Role(); // Mapping

        PageInsert pageInsert = new PageInsert( mapping, request, user );

        pageInsert.setLien(lien);

        // Change formulary Label
        pageInsert.getFormu().getChamp("idrole").setLibelle("Identifiant Role");
        pageInsert.getFormu().getChamp("descrole").setLibelle("Description");
        pageInsert.getFormu().getChamp("rang").setLibelle("Rang");

        // Apres tarif variables
        String mappingClass = "utilisateur.Role",
                afterPost = "administrateur/role/creation.jsp",
                pageTitle = "Cr&eacute;ation role",
                nomTable = "roles";
        
        pageInsert.preparerDataFormu();
        pageInsert.getFormu().makeHtmlInsertTabIndex();
            
    

%>
<div class="content-wrapper">
    <h1 class="text-align-center">
        <%= pageTitle %>
    </h1>
    

    <form action="<%= pageInsert.getLien() %>?but=apresTarif.jsp" data-parsley-validate method="post">
        <%= pageInsert.getFormu().getHtmlInsert() %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= afterPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= mappingClass %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>

</div>

<%
}catch(Exception e){
        e.printStackTrace();
    }
%>