<%@page import="bureaux.Bureaux, bureaux.TypeBureau"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.*" %>

<%
    try{
        // Session variables
        UserEJB user = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");

        Bureaux mapping = new Bureaux(); // Mapping

        PageInsert pageInsert = new PageInsert( mapping, request, user );

        pageInsert.setLien(lien);

        // Change formulary Label
        pageInsert.getFormu().getChamp("nomBureaux").setLibelle("Nom du Bureau");
        pageInsert.getFormu().getChamp("descriptionBureaux").setLibelle("Description");
        pageInsert.getFormu().getChamp("dateCreation").setLibelle("Date de cr&eacute;ation");
        pageInsert.getFormu().getChamp("dateCreation").setDefaut(utilitaire.Utilitaire.dateDuJour());
        
        
        Liste[] listes = new Liste[1];
        // Liste Mapping
        TypeBureau type = new TypeBureau();
        listes[0] = new Liste("idTypeBureau", type, "val", "id");
        
        pageInsert.getFormu().changerEnChamp(listes);
        
        pageInsert.getFormu().getChamp("idTypeBureau").setLibelle("Type de Bureau");
        
        pageInsert.getFormu().getChamp("etat").setVisible(false);

        // Apres tarif variables
        String mappingClass = "bureaux.Bureaux",
                afterPost = "administrateur/bureau/saisie.jsp",
                pageTitle = "Cr&eacute;ation de Bureau",
                nomTable = "bureaux";
        
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