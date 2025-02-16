<%-- 
    Document   : saisie
    Created on : Oct 6, 2024, 8:07:27 AM
    Author     : sarobidy
--%>
<%@page import="annexe.InformationAnnexe"%>
<%@page import="croyance.information.InformationMpivavaka"%>
<%@page import="annexe.Faritra"%>
<%@page import="croyance.Mpivavaka" %>
<%@page import="affichage.*" %>
<%@page import="user.UserEJB" %>

<%
      try{    
    UserEJB user = (UserEJB) session.getValue("u");
    String lien = (String) session.getValue("lien");
          
    Mpivavaka mapping = new Mpivavaka();
    InformationMpivavaka info = new InformationMpivavaka();
    
    int nbLine = 10;
    
    PageInsertInformation pi = new PageInsertInformation(mapping, info, request, nbLine, user);
    pi.setLien(lien);
    
    Liste[] list = new Liste[2];
    String[] sexes = {"Homme", "Femme"};
    String[] values = { "1", "0" };
    list[0] = new Liste("sexe", sexes,  values);
    list[1] = new Liste("idFaritra", new Faritra(), "nomFaritra", "idFaritra");
    
    pi.getFormu().changerEnChamp(list);
    
    pi.getFormu().getChamp("etat").setVisible(false);
    
    pi.getFormu().getChamp("nom").setLibelle("Nom");
    pi.getFormu().getChamp("prenom").setLibelle("Pr&eacute;nom");
    pi.getFormu().getChamp("datenaissance").setLibelle("N&eacute;e le");
    pi.getFormu().getChamp("sexe").setLibelle("Genre");
    pi.getFormu().getChamp("lieuDeNaissance").setLibelle("&agrave;");
    pi.getFormu().getChamp("contact").setLibelle("Contact");
    pi.getFormu().getChamp("addresse").setLibelle("Adresse");
    pi.getFormu().getChamp("idFaritra").setLibelle("Faritra");
    
    pi.setTitre("Ajouter un nouveau Croyant");
    
//    Champ.setVisible(pi.getFormufle().getChampFille("idMpivavaka"), false);
    
    list = new Liste[1];
    list[0] = new Liste("idInfoAnnexe", new InformationAnnexe(), "val", "id");
    pi.getFormufle().changerEnChamp(list);
    pi.getFormufle().getChamp("idInfoAnnexe_0").setLibelle("Information sup.");
    pi.getFormufle().getChamp("valeur_0").setLibelle("Valeur");
    
    pi.preparerDataFormu();
    pi.getFormu().setTitre("Saisie nouveau fidèle");
    pi.getFormu().makeHtmlInsertTabVaovao();
    pi.getFormufle().makeHtmlInsertTableauIndex();
    
    pi.preparerData();
    pi.getFormulaire().setTitre("Informations supplémentaire");
    String afterPost = "croyance/mpivavaka/mpivavaka-fiche.jsp";
    String mappingClass = "croyance.Mpivavaka";
    String nomTable = "mpivavaka";
    String classeFille = "croyance.information.InformationMpivavaka";
    String colonneMere = "idMpivavaka";
    
//    pi.getFormu().setTitre( pi.getTitre() );

%>

<div class="content-wrapper">
    
    <form action="<%= pi.getLien() %>?but=apresMultiple.jsp" data-parsley-validate method="POST">
        <%= pi.getFormu().getHtmlInsert()%>
        <%= pi.getFormulaire().createHTML()%>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= afterPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= mappingClass %>">
        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nbLine %>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">
    </form>
    
</div>
    
<script>
    $(document).ready(function(){
        const rowsToDisplay = 10;
        var currentPage = 1;
        var tableBody = document.querySelectorAll('.informations tr');

        function updateTable(){
            const totalRows = tableBody.length;
            const totalPages = Math.ceil(totalRows / rowsToDisplay);

            // Hide all rows initially
            tableBody.forEach((row, index) => {
              if (index >= (currentPage - 1) * rowsToDisplay && index < currentPage * rowsToDisplay) {
                row.style.display = ""; // Show row
              } else {
                row.style.display = "none"; // Hide row
              }
            });

            // Disable/Enable buttons based on page number
            document.getElementById("prevButton").disabled = currentPage === 1;
            document.getElementById("nextButton").disabled = currentPage === totalPages;
        }
        
        updateTable();

        document.getElementById("nextButton").addEventListener("click", () => {
          const totalPages = Math.ceil(tableBody.length / rowsToDisplay);
          if (currentPage < totalPages) {
            currentPage++;
            updateTable();
          }
        });

        // Handle "Prev" button
        document.getElementById("prevButton").addEventListener("click", () => {
          if (currentPage > 1) {
            currentPage--;
            updateTable();
          }
        });

    });
    
</script>
    
    
    <%
              }catch(Exception e){
e.printStackTrace();
}
    %>