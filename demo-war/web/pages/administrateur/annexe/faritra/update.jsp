<%-- 
    Document   : update
    Created on : Oct 6, 2024, 1:07:55 PM
    Author     : sarobidy
--%>

<%@page import="annexe.Faritra" %>
<%@page import="affichage.PageUpdate" %>
<%@page import="user.UserEJB" %>

<%
    try{
        String autreparsley = "data-parsley-range='[8, 40]' required";
        Faritra role = new Faritra();
        UserEJB user = (UserEJB) session.getValue("u");
        PageUpdate pi = new PageUpdate(role, request, user);
        pi.setLien((String) session.getValue("lien"));
        
        pi.getFormu().getChamp("nomFaritra").setLibelle("Nom du Faritra");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idFaritra").setVisible(false);
        
        pi.preparerDataFormu();
        role = (Faritra) pi.getBase();
        pi.setTitre("Modification Faritra : " + role.getNomFaritra());

        String classe = "annexe.Faritra";
        String bute = "administrateur/annexe/faritra/fiche.jsp";
        String nomTable = "faritra";

%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1> 
                        <%= pi.getTitre() %>
                    </h1>
                    <form action="<%= pi.getLien() %>?but=apresTarif.jsp&idFaritra=<%= role.getTuppleID() %>" method="post">
                        <%
                            pi.getFormu().makeHtmlInsertTabIndex();
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="idFaritra-<%= role.getTuppleID() %>" >
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