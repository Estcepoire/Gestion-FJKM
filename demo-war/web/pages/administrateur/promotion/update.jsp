<%-- 
    Document   : update
    Created on : Oct 9, 2024, 9:02:52 PM
    Author     : sarobidy
--%>

<%-- 
    Document   : update
    Created on : Oct 5, 2024, 9:10:22 PM
    Author     : sarobidy
--%>

<%@page import="croyance.promotion.Promotion"%>
<%@page import="affichage.PageUpdate, affichage.Liste" %>
<%@page import="user.UserEJB" %>

<%
    try{
        String autreparsley = "data-parsley-range='[8, 40]' required";
        Promotion role = new Promotion();
        UserEJB user = (UserEJB) session.getValue("u");
        PageUpdate pi = new PageUpdate(role, request, user);
        pi.setLien((String) session.getValue("lien"));

        
        pi.getFormu().getChamp("idPromotion").setLibelle("Identifiant");
        pi.getFormu().getChamp("nomPromotion").setLibelle("Nom");
        pi.getFormu().getChamp("dateSortie").setLibelle("Date de Sortie");       
        pi.getFormu().getChamp("anneePromotion").setLibelle("Ann&eacute;e");       
        pi.getFormu().getChamp("etat").setVisible(false);
                
        pi.preparerDataFormu();
        role = (Promotion) pi.getBase();
        pi.setTitre("Modification Promotion : " + role.getNomPromotion());

        String classe = "croyance.promotion.Promotion";
        String bute = "administrateur/promotion/fiche.jsp";
        String nomTable = "Promotionmpandray";

%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1> 
                        <%= pi.getTitre() %>
                    </h1>
                    <form action="<%= pi.getLien() %>?but=apresTarif.jsp&idPromotion=<%= role.getTuppleID() %>" method="post">
                        <%
                            pi.getFormu().makeHtmlInsertTabIndex();
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="idPromotion-<%= role.getTuppleID()%>" >
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