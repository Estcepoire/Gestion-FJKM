<%-- 
    Document   : update
    Created on : Oct 6, 2024, 10:37:00 AM
    Author     : sarobidy
--%>

<%@page import="annexe.Faritra"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.*"%>
<%@page import="croyance.Mpivavaka"%>

<%

    Mpivavaka mpivavaka = new Mpivavaka();
    UserEJB user = (UserEJB) session.getValue("u");
    PageUpdate pi = new PageUpdate( mpivavaka , request, user);
    mpivavaka = (Mpivavaka) pi.getBase();
    pi.setTitre("Modification Croyant : " + mpivavaka.getPrenom());
    
    Liste[] list = new Liste[2];
    String[] sexes = {"Homme", "Femme"};
    String[] values = { "1", "0" };
    list[0] = new Liste("sexe", sexes,  values);
    list[1] = new Liste("idFaritra", new Faritra(), "nomFaritra", "idFaritra");

    
    pi.getFormu().changerEnChamp(list);
    
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idMpivavaka").setVisible(false);
    
    pi.getFormu().getChamp("nom").setLibelle("Nom");
    pi.getFormu().getChamp("prenom").setLibelle("Pr&eacute;nom");
    pi.getFormu().getChamp("datenaissance").setLibelle("N&eacute;e le");
    pi.getFormu().getChamp("sexe").setLibelle("Genre");
    pi.getFormu().getChamp("lieuDeNaissance").setLibelle("&agrave;");
    pi.getFormu().getChamp("contact").setLibelle("Contact");
    pi.getFormu().getChamp("addresse").setLibelle("Adresse");
    pi.getFormu().getChamp("idFaritra").setLibelle("Faritra");
    
    pi.preparerDataFormu();
    
    pi.setLien((String) session.getValue("lien") );
    
    
    
    String bute = "croyance/mpivavaka/fiche.jsp";
    String classe = "croyance.Mpivavaka";
    String nomTable = "mpivavaka";
    
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1> 
                        <%= pi.getTitre() %>
                    </h1>
                    <form action="<%= pi.getLien() %>?but=apresTarif.jsp&idMpivavaka=<%= mpivavaka.getTuppleID()%>" method="post">
                        <%
                            pi.getFormu().makeHtmlInsertTabIndex();
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="idMpivavaka-<%= mpivavaka.getTuppleID()%>" >
                        <input name="bute" type="hidden" id="bute" value="<%= bute %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>