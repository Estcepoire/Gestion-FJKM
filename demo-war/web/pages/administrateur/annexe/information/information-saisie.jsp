<%-- 
    Document   : saisie
    Created on : Oct 6, 2024, 12:03:50 PM
    Author     : sarobidy
--%>

<%@page import="affichage.Liste"%>
<%@page import="affichage.TypeChamp"%>
<%@page import="annexe.InformationAnnexe"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsert"%>
<%@page import="annexe.Faritra"%>
<%
          try{
            InformationAnnexe mapping = new InformationAnnexe();
            UserEJB user = (UserEJB) session.getValue("u");
            String lien = (String) session.getValue("lien");

            PageInsert pi = new PageInsert( mapping, request, user );
            pi.setTitre("Cr&eacute;ation d'un Information Supplémentaire");
            pi.setLien(lien);

            pi.getFormu().getChamp("val").setLibelle("Lib&eacute;lle"); 
            pi.getFormu().getChamp("desce").setLibelle("D&eacute;scription");          
            pi.getFormu().getChamp("etat").setVisible(false);
            
            TypeChamp type = new TypeChamp();
            Liste[] list = { new Liste("idTypeChamp", type, "val", "id") };

            pi.getFormu().changerEnChamp(list);
            pi.getFormu().getChamp("valeurPossible").setLibelle("Les valeurs possibles(optionnelle)");
            pi.getFormu().getChamp("idTypeChamp").setLibelle("Type de champ");
            pi.preparerDataFormu();

            String afterPost = "administrateur/annexe/information/information-fiche.jsp";
            String mappingClass = "annexe.InformationAnnexe";
            String nomTable = "infoannexe";
            pi.getFormu().setTitre(pi.getTitre());
          pi.getFormu().makeHtmlInsertTabVaovao();
  
%>
<div class="content-wrapper">
    
    <form action="<%= pi.getLien() %>?but=apresTarif.jsp" data-parsley-validate method="post">
        <%= pi.getFormu().getHtmlInsert() %>
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