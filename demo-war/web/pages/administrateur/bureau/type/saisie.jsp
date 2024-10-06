<%@page import="bureaux.TypeBureau"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.*" %>

<%
    try{
        // Session variables
        UserEJB user = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");

        TypeBureau mapping = new TypeBureau(); // Mapping

        PageInsert pageInsert = new PageInsert( mapping, request, user );

        pageInsert.setLien(lien);

        // Change formulary Label
        pageInsert.getFormu().getChamp("val").setLibelle("Type de bureau");
        pageInsert.getFormu().getChamp("desce").setLibelle("Description");

        // Apres tarif variables
        String mappingClass = "bureaux.TypeBureau",
                afterPost = "administrateur/bureau/type/fiche.jsp",
                pageTitle = "Cr&eacute;ation type de bureau",
                nomTable = "typebureaux";
        
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