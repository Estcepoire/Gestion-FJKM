
<%@page import="ligneCredit.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <style>
        body { font-family: Arial, sans-serif; }
        .container { width: 60%; margin: auto; }
        h1, h2 { text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        table, th, td { border: 1px solid #dddddd; }
        th, td { padding: 12px; text-align: right; }
        th { background-color: #f2f2f2; }
    </style>

    <%
        Prediction p = new Prediction();
        Prediction[] ps = p.donnees();
        double alpha=  0.7;
        double[] predict = p.algo( 0.7 , ps);
    %>
<div class="content-wrapper">
    <h1>Statisitique des moyennes</h1>
     <div class="box-body">
        <div class="col-md-9">
            <form  method="get">
                <div class="col-md-4">
                    <label for="idLigneCredit">S&eacute;lectionnez la Ligne credit :</label>
                    <select id="idLigneCredit" name="idLigneCredit" class="form-control">
                        <% 
                            LigneCredit[] ligneCredits = (LigneCredit[]) CGenUtil.rechercher(new LigneCredit(), null, null, "");
                            %>
                                <option value="tous" %>Tous</option>
                            <%
                            for (LigneCredit ligneCredit : ligneCredits) { 
                        %>
                            <option value="<%= ligneCredit.getId() %>" <%= request.getParameter("idLigneCredit") != null && request.getParameter("idLigneCredit").equals(ligneCredit.getId()) ? "selected" : "" %>><%= ligneCredit.getVal() %></option>
                        <% } %>
                    </select>
                </div>
                <br>
                <div class="col-md-4">
                    <button class="btn btn-primary" type="submit">Filtrer</button>
                </div>
            </form>
            </div>
            <br>
            <div class="col-md-12">
                <table>
                    <tr>
                        <th>Estimation</th>
                        <th>Valeur (MGA)</th>
                    </tr>
                    <tr>
                        <td>Moyenne estim&eacute;e</td>
                        <td><%= String.format("%,.2f", (Double) predict[4]) %></td>
                    </tr>
                    <tr>
                        <td>Intervalle de confiance avec alpha = <%=alpha%> pour la moyenne</td>
                        <td>[<%= String.format("%,.2f", (Double) predict[2]) %> ; <%= String.format("%,.2f", (Double) predict[3]) %>]</td>
                    </tr>
                    <tr>
                        <td>Intervalle de pr&eacute;diction pour une nouvelle observation</td>
                        <td>[<%= String.format("%,.2f", (Double) predict[0]) %> ; <%= String.format("%,.2f", (Double) predict[1]) %>]</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
