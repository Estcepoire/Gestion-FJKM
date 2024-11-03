<%@page import="java.util.*"%> 
<%@page import="user.*"%> 
<%@page import="vente.*"%> 
<%@page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%> 
<%@page import="stock.details.*"%>
<%@page import="facture.*"%>
<%@page import="caisse.*"%>
<style>
.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
    background-color: #fff;
    margin: 15% auto;
    padding: 20px;
    border-radius: 5px;
    width: 80%;
    max-width: 400px;
}

.close {
    color: #aaa;
    float: left;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
}

select {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #f9f9f9;
    appearance: none;
    cursor: pointer;
}

select:focus {
    outline: none;
    border-color: #4CAF50;
    box-shadow: 0 0 5px rgba(76, 175, 80, 0.5);
}

option {
    padding: 10px;
}


</style>
 
<%
    UserEJB u = (user.UserEJB)session.getValue("u");
%>
<%
    try {
    FactureFournisseur f = new FactureFournisseur();
    f.setNomTable("facturefournisseur_cpl");
    PageConsulte pc = new PageConsulte(f, request, u);
    pc.setTitre("Fiche Facture Fournisseur");

    FactureFournisseur blf = (FactureFournisseur) pc.getBase();
    String id = blf.getTuppleID();

    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("val").setLibelle("Designation");
    pc.getChampByName("idtierslib").setLibelle("Tiers");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("idlignecreditlib").setLibelle("Ligne Credit");
    pc.getChampByName("montant").setLibelle("montant Total");
    pc.getChampByName("idtiers").setVisible(false);
    pc.getChampByName("idlignecredit").setVisible(false);

    String pageActuel = "facture-fournisseur-fiche.jsp";
    String lien = (String) session.getValue("lien");

    String classe = "facture.FactureFournisseur";
    
    Map<String, String> map = new HashMap<String, String>();
    map.put("inc/facture-fournisseur-details", ""); 

    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "inc/facture-fournisseur-details";
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
                            if(blf.getEtat()>1){
                                %>
                                    <button class="btn btn-primary pull-right" id="openModalBtn">D&eacute;caisser</button>
                                    <a class="btn btn-secondary pull-right" href="<%= (String) session.getValue("lien") + "?but=apresGenererStock.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px" >Faire une entrer en stock</a>
                                <%
                            }else{
                        %>
                            <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=facture/facture-fournisseur-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Valider</a>
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
                    <li class="<%=map.get("inc/facture-fournisseur-details")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=inc/facture-fournisseur-details">D&eacute;tails</a></li>
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

<div id="modal" class="modal">
    <div class="modal-content">
        <span id="closeModalBtn" class="close">&times;</span>
        <h2>Choisir une Caisse</h2>
        <form id="caisseForm" class='container' action="<%=lien%>?but=apresDecaisser.jsp" method="post">
            <label for="caisseSelect">Caisse:</label>
            <select id="caisseSelect" name="idCaisse">
                <%
                    Caisse[] caisses = (Caisse[]) CGenUtil.rechercher(new Caisse(),null,null,"");
                    for (Caisse caisse : caisses) {
                %>
                    <option value="<%= caisse.getId() %>"><%= caisse.getVal() %></option>
                <%
                    }
                %>
            </select>
            <input type="hidden" value="<%=id%>" name="id" >
            <br>
            <br>
            <button class="btn btn-success pull-right" type="submit">Valider</button>
        </form>
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


<script>
const modal = document.getElementById("modal");
const openModalBtn = document.getElementById("openModalBtn");
const closeModalBtn = document.getElementById("closeModalBtn");

openModalBtn.onclick = function() {
    modal.style.display = "block";
};

closeModalBtn.onclick = function() {
    modal.style.display = "none";
};

window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
};
</script>