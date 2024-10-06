<%@page import="bureaux.TypeBureau" %>
<%@page import="affichage.PageUpdate" %>
<%@page import="user.UserEJB" %>

<%
    try{
        String autreparsley = "data-parsley-range='[8, 40]' required";
        TypeBureau role = new TypeBureau();
        UserEJB user = (UserEJB) session.getValue("u");
        PageUpdate pi = new PageUpdate(role, request, user);
        pi.setLien((String) session.getValue("lien"));
        
        pi.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
        pi.getFormu().getChamp("val").setLibelle("Type de Bureaux");
        
        pi.preparerDataFormu();
        role = (TypeBureau) pi.getBase();
        pi.setTitre("Modification Role : " + role.getVal());

        String classe = "bureaux.TypeBureau";
        String bute = "administrateur/bureau/type/fiche.jsp";
        String nomTable = "typebureaux";

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