<%-- 
    Document   : update
    Created on : Oct 6, 2024, 10:37:00 AM
    Author     : sarobidy
--%>

<%@page import="annexe.InformationAnnexe"%>
<%@page import="bean.CGenUtil"%>
<%@page import="croyance.information.InformationMpivavaka"%>
<%@page import="annexe.Faritra"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.*"%>
<%@page import="croyance.Mpivavaka"%>

<%
try{


    Mpivavaka mpivavaka = new Mpivavaka();
    UserEJB user = (UserEJB) session.getValue("u");
    InformationMpivavaka info = new InformationMpivavaka();
    int nbLine = 10;
    InformationMpivavaka[] filles = (InformationMpivavaka[]) CGenUtil.rechercher(info, null, null, null, " and idMpivavaka = '" + request.getParameter("idMpivavaka") + "'");
         
    PageUpdateMultiple pi = new PageUpdateMultiple(mpivavaka, info, filles, request, user, nbLine);
    mpivavaka = (Mpivavaka) pi.getBase();
    pi.setTitre("Modification Croyant : " + mpivavaka.getPrenom());
    
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
    
    Champ.setVisible(pi.getFormufle().getChampFille("idMpivavaka"), false);
    Champ.setVisible(pi.getFormufle().getChampFille("idInfoMpivavaka"), false);
    
    list = new Liste[1];
    list[0] = new Liste("idInfoAnnexe", new InformationAnnexe(), "val", "id");
    pi.getFormufle().changerEnChamp(list);
    pi.getFormufle().getChamp("idInfoAnnexe_0").setLibelle("Information sup.");
    pi.getFormufle().getChamp("valeur_0").setLibelle("Valeur");
    
    pi.preparerDataFormu();
    
    pi.setLien((String) session.getValue("lien") );
    
    
    
    String bute = "croyance/mpivavaka/mpivavaka-fiche.jsp";
    String classe = "croyance.Mpivavaka";
    String classeFille = "croyance.information.InformationMpivavaka";
    String mere = "idMpivavaka";
    
%>

<div class="content-wrapper">
                    
                    <form action="<%= pi.getLien() %>?but=apresMultiple.jsp&idMpivavaka=<%= mpivavaka.getTuppleID()%>" method="post">
                        <%
                            pi.getFormu().setTitre( pi.getTitre() );
                            pi.getFormu().makeHtmlInsertTabVaovao();
                            pi.getFormufle().setTitre("Informations supplémentaires");
                            pi.getFormufle().makeHtmlInsertTableauVaovao();
                            out.println(pi.getFormu().getHtmlInsert());
                            out.println(pi.getFormufle().getHtmlTableauInsert());
                        %>
                        <input name="acte" type="hidden" id="acte" value="updateInsert">
                        <input name="id" type="hidden" id="acte" value="test">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="idMpivavaka-<%= mpivavaka.getTuppleID()%>" >
                        <input name="bute" type="hidden" id="bute" value="<%= bute %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
                        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= mere %>">
                        
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nbLine %>">

                    </form>
</div>
                        
<%
          }catch(Exception e){
          e.printStackTrace();
}
%>