<%@page import="bean.*"%>
<%@page import="caisse.*"%>

<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <title>Suivie de Caisse par Mois</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<h2>Etat de Caisse par Mois</h2>

<form  method="get">
    <label for="annee">S&eacute;lectionnez l'ann&eacute;e :</label>
    <input type="hidden" name="but" value="caisse/rapprochement.jsp">
    <select id="annee" name="annee">
        <% for (int y = 2020; y <= 2025; y++) { %>
            <option value="<%= y %>" <%= request.getParameter("annee") != null && request.getParameter("annee").equals(String.valueOf(y)) ? "selected" : "" %>><%= y %></option>
        <% } %>
    </select>

    <label for="idCaisse">S&eacute;lectionnez la caisse :</label>
    <select id="idCaisse" name="idCaisse">
        <% 
            Caisse[] caisses = (Caisse[]) CGenUtil.rechercher(new Caisse(), null, null, "");
            for (Caisse caisse : caisses) { 
        %>
            <option value="<%= caisse.getId() %>" <%= request.getParameter("idCaisse") != null && request.getParameter("idCaisse").equals(caisse.getId()) ? "selected" : "" %>><%= caisse.getVal() %></option>
        <% } %>
    </select>
    
    <button type="submit">Filtrer</button>
</form>

<canvas id="caisseChart"width="700" height="300"  ></canvas>
<%
    String anneeParam = request.getParameter("annee");
    String idCaisseParam = request.getParameter("idCaisse");
    Suivie s = new Suivie();
    s.setNomTable("vue_suivie_caisse_par_mois");
    Suivie[] suivie = (Suivie[]) CGenUtil.rechercher(s, null, null, " AND id like '" + idCaisseParam + "' AND annee=" + anneeParam);
%>

<script>
    const data = {
        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        datasets: [
            {
                label: "Entree de caisse par mois",
                data: [
                    <% for (int i = 0; i < suivie.length; i++) { %>
                        <% if (i > 0) { %>, <% } %> 
                        <%= suivie[i].getTotalentrees() %>
                    <% } %>
                ],
                type: 'line',
                borderColor: "rgba(75, 192, 192, 1)",
                fill: false,
                pointBackgroundColor: "rgba(75, 192, 192, 1)"
            },
            {
                label: "Sotie de caisse par mois",
                data: [
                    <% for (int i = 0; i < suivie.length; i++) { %>
                        <% if (i > 0) { %>, <% } %> 
                        <%= suivie[i].getTotalsorties() %>
                    <% } %>
                ],
                type: 'line',
                borderColor: "rgba(99, 99, 99,23)",
                fill: false,
                pointBackgroundColor: "rgba(99, 99, 99,23)"
            }
        ]
    };

    const config = {
        type: 'bar',
        data: data,
        options: {
            responsive: false,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Montant',
                        font: { size: 10 }
                    },
                    ticks: {
                        font: { size: 8 }
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: 'Mois',
                        font: { size: 10 }
                    },
                    ticks: {
                        font: { size: 8 }
                    }
                }
            }
        }
    };

    const caisseChart = new Chart(
        document.getElementById('caisseChart'),
        config
    );
</script>

</body>
</html>
