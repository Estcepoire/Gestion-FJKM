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
<style>
        form {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        select {
            width: 20%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            background-color: #f9f9f9;
            font-size: 14px;
            transition: border-color 0.3s;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        select:focus {
            border-color: #007BFF;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
        }
        button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3;
        }

</style>

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
            %>
                <option value="tous" %>Tous</option>
            <%
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
    Suivie[] suivie = null;
    if(request.getParameter("idCaisse").compareToIgnoreCase("tous") == 0){
        s.setNomTable("vue_suivie_global_par_mois");
        suivie = (Suivie[]) CGenUtil.rechercher(s, null, null, " AND annee=" + anneeParam);
    }
    else{
        suivie = (Suivie[]) CGenUtil.rechercher(s, null, null, " AND id like '" + idCaisseParam + "' AND annee=" + anneeParam);
    }
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
