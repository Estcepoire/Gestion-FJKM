<%@page import="java.util.*"%>
<%@page import="user.*"%>
<%@page import="consommation.*"%>
<%@page import="bean.*"%>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<%
    UserEJB u = (user.UserEJB) session.getValue("u");
%>
<%
    try {
        Consommation consommation = new Consommation();
        consommation.setNomTable("consommationlib");
        PageConsulte pc = new PageConsulte(consommation, request, u);
        pc.setTitre("Fiche Consommation");

        Consommation cons = (Consommation) pc.getBase();
        String id = cons.getTuppleID();

        pc.getChampByName("id").setLibelle("ID");
        pc.getChampByName("val").setLibelle("Désignation");
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("description").setLibelle("Description");
        pc.getChampByName("itypeconsommationlib").setLibelle("Type de Consommation");

        String pageActuel = "consommation/consommation-fiche.jsp";
        String lien = (String) session.getValue("lien");

        String classe = "consommation.Consommation";

        Map<String, String> map = new HashMap<String, String>();
        map.put("inc/consommationfille-liste", "");

        String tab = request.getParameter("tab");
        if (tab == null) {
            tab = "inc/consommationfille-liste";
        }
        map.put(tab, "active");
        tab = tab + ".jsp";
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                        <%
                            if(cons.getEtat() < 11){
                        %>
                            <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=consommation/consommation-fiche.jsp&classe=" + classe %>" style="margin-right: 10px">Valider</a>
                            <a class="btn btn-warning pull-right" href="<%= (String) session.getValue("lien") + "?but=#&id=" + request.getParameter("id")%>" style="margin-right: 5px">Modifier</a>
                        </div>
                        <%
                            }
                        %>
                        <br/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="<%=map.get("inc/consommationfille-liste")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=inc/consommationfille-liste">Détails</a></li>
                </ul>
                <div class="tab-content">
                    <jsp:include page="<%= tab %>" >
                        <jsp:param name="numbl" value="<%= id %>" />
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>                    
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% } %>
