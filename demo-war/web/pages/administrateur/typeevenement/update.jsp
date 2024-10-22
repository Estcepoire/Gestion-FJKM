<%-- 
    Document   : update
    Created on : Oct 21, 2024, 11:26:42 PM
    Author     : sarobidy
--%>


<%@page import="affichage.PageUpdate"%>
<%@page import="user.UserEJB"%>
<%@page import="evenement.TypeEvenement"%>
<%
    try{
        String autreparsley = "data-parsley-range='[8, 40]' required";
        TypeEvenement role = new TypeEvenement();
        UserEJB user = (UserEJB) session.getValue("u");
        PageUpdate pi = new PageUpdate(role, request, user);
        pi.setLien((String) session.getValue("lien"));

        
        pi.getFormu().getChamp("id").setLibelle("Identifiant");
        pi.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
        pi.getFormu().getChamp("val").setLibelle("Type d&apos;evenement");
        
        pi.preparerDataFormu();
        role = (TypeEvenement) pi.getBase();
        pi.setTitre("Modification Type d&apos;evenement : " + role.getDesce());

        String classe = "evenement.TypeEvenement";
        String bute = "administrateur/typeevenement/fiche.jsp";
        String nomTable = "typeEvenement";

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
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%= role.getId() %>" >
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