<%-- 
    Document   : update
    Created on : Oct 5, 2024, 9:10:22 PM
    Author     : sarobidy
--%>

<%@page import="bureaux.TypeBureau"%>
<%@page import="bureaux.Bureaux" %>
<%@page import="affichage.PageUpdate, affichage.Liste" %>
<%@page import="user.UserEJB" %>

<%
    try{
        String autreparsley = "data-parsley-range='[8, 40]' required";
        Bureaux role = new Bureaux();
        UserEJB user = (UserEJB) session.getValue("u");
        PageUpdate pi = new PageUpdate(role, request, user);
        pi.setLien((String) session.getValue("lien"));

        
        pi.getFormu().getChamp("idBureaux").setLibelle("Identifiant");
        pi.getFormu().getChamp("nomBureaux").setLibelle("Nom");
        pi.getFormu().getChamp("descriptionBureaux").setLibelle("Description");       
        pi.getFormu().getChamp("dateCreation").setLibelle("Cr&eacute;&eacute; le");       
        pi.getFormu().getChamp("etat").setVisible(false);
        
        Liste[] listes = new Liste[1];
        listes[0] = new Liste( "idTypeBureau", new TypeBureau(), "val", "id" );

        pi.getFormu().changerEnChamp(listes);
        pi.getFormu().getChamp("idTypeBureau").setLibelle("Type de Bureau");
        
        pi.preparerDataFormu();
        role = (Bureaux) pi.getBase();
        pi.setTitre("Modification Bureaux : " + role.getNomBureaux());

        String classe = "bureaux.Bureaux";
        String bute = "administrateur/bureau/fiche.jsp";
        String nomTable = "bureaux";

%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1> 
                        <%= pi.getTitre() %>
                    </h1>
                    <form action="<%= pi.getLien() %>?but=apresTarif.jsp&id=<%= role.getTuppleID() %>" method="post">
                        <%
                            pi.getFormu().makeHtmlInsertTabIndex();
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%= role.getTuppleID()%>" >
                        <input name="bute" type="hidden" id="bute" value="<%= bute %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%
    }catch(Exception e){
        e.printStackTrace();
%>
    <script language="JavaScript"> 
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<%

    }
%>