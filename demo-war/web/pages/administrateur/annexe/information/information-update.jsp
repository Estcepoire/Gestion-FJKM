<%-- 
    Document   : update
    Created on : Oct 6, 2024, 1:07:55 PM
    Author     : sarobidy
--%>

<%@page import="annexe.InformationAnnexe"%>
<%@page import="annexe.Faritra" %>
<%@page import="affichage.PageUpdate" %>
<%@page import="user.UserEJB" %>

<%
    try{
        String autreparsley = "data-parsley-range='[8, 40]' required";
        InformationAnnexe role = new InformationAnnexe();
        UserEJB user = (UserEJB) session.getValue("u");
        PageUpdate pi = new PageUpdate(role, request, user);
        pi.setLien((String) session.getValue("lien"));
        
        pi.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
        pi.getFormu().getChamp("val").setLibelle("Lib&eacute;lle");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("id").setVisible(false);
        
        pi.preparerDataFormu();
        role = (InformationAnnexe) pi.getBase();
        pi.setTitre("Modification Information suppl&eacute;mentaire : " + role.getVal());

        String classe = "annexe.InformationAnnexe";
        String bute = "administrateur/annexe/information/information-fiche.jsp";
        String nomTable = "infoannexe";

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
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%= role.getTuppleID() %>" >
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