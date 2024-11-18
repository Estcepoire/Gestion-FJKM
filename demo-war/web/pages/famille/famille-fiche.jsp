<%@page import="java.util.*"%> 
<%@page import="user.*"%> 
<%@page import="vente.*"%> 
<%@page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%> 
<%@page import="stock.details.*"%>
<%@page import="famille.*"%>
<%@page import="caisse.*"%>
<%
    UserEJB u = (user.UserEJB)session.getValue("u");
%>
<%
    try {
    Famille f = new Famille();
    f.setNomTable("famillelib");
    PageConsulte pc = new PageConsulte(f, request, u);
    pc.setTitre("Fiche Famille");

    Famille blf = (Famille) pc.getBase();
    String id = blf.getTuppleID();

    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("val").setLibelle("Nom"); 
    pc.getChampByName("desce").setLibelle("Description");
    pc.getChampByName("IdFaritra").setVisible(false);
    pc.getChampByName("IdFaritralib").setLibelle("Faritra");

    String pageActuel = "famille-fiche.jsp";
    String lien = (String) session.getValue("lien");

    String classe = "famille.Famille";
    
    Map<String, String> map = new HashMap<String, String>();
    map.put("inc/famille-filles-details", ""); 

    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "inc/famille-filles-details";
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
                            if(blf.getEtat()<11){
                        %>
                            <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=famille/famille-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Valider</a>
                            <a class="btn btn-warning pull-right" href="<%= (String) session.getValue("lien") + "?but=#&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                        <%
                            }
                        %>
                        </div>
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
                    <li class="<%=map.get("inc/famille-filles-details")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=inc/famille-filles-details">D&eacute;tails</a></li>
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

