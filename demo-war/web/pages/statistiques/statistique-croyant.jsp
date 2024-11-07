<%-- 
    Document   : statistique-croyant
    Created on : Nov 6, 2024, 9:54:53 PM
    Author     : sarobidy
--%>

<%@page import="statistique.StastitiqueWrapper"%>
<%

    statistique.StastitiqueWrapper sts = new StastitiqueWrapper();
    sts.init();
    
    String[] evolutionMpandray = sts.getStatistiquesEvolutionMpandray();
    String[] evolutionCroyants = sts.getStatistiquesEvolutionCroyant();
    String[] repartitionFaritra = sts.getRepartitionData();

%>


<div class="content-wrapper">
    <!--- Banière contenant beaucoup d'informations -->
    <!-- 
        
        Mpivavaka Au Total
        Nombre d'admis cette année
        Nombre de Quitté cette année
        Izay aloha no takatro atreto
        Misy classe ray zany any manao anzay fotsiny ny asany hoe maka données ana statistique
        
    -->
    <div class="row">
        <div class="col-md-4">
            <div class='card'>
                <div class="card-body">
                     Nombres de Croyants Total : <%= sts.getEtatActuelle().getNombre() %> Personne(s)
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                                Nouveaux Croyants cette année: <%= sts.getEtatActuelle().getNombreNouveaux() %> personnes
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                                Membres Quitté ou décédes cette année : <%= sts.getEtatActuelle().getNombreMoins() %> personnes
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="row">
                <form id="evolution-form">
                    <div class="my-md-3">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="col-md-3">
                                    <label class="form-label"> Année minimum </label>
                                </div>
                                <div class="col-md-9">
                                    <input type="number" class="form-control" min="2000" max="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" step="1" value="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" name="dateMin" />
                                </div>
                            </div>
                             <div class="col-md-6">
                                <div class="col-md-3">
                                    <label class="form-label"> Année maximum </label>
                                </div>
                                <div class="col-md-9">
                                    <input type="number" class="form-control" min="2000" max="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" step="1" value="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" name="dateMax" />
                                </div>
                            </div>
                            <button type="button" onclick="fetchDataForEvolutionChart()" class="btn btn-primary">
                                Voir
                            </button>
                        </div>
                    </div>
                    
                </form>
            </div>
            <canvas id="cotisation-an"></canvas>
        </div>
         <!---  Evolution des mpandray Statistiques --->
        <div class="col-md-6">
            <div class="row">
                <form id="evolution-form-mpandray">
                    <div class="my-md-3">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="col-md-3">
                                    <label class="form-label"> Année minimum </label>
                                </div>
                                <div class="col-md-9">
                                    <input type="number" class="form-control" min="2000" max="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" step="1" value="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" name="dateMin" />
                                </div>
                            </div>
                             <div class="col-md-6">
                                <div class="col-md-3">
                                    <label class="form-label"> Année maximum </label>
                                </div>
                                <div class="col-md-9">
                                    <input type="number" class="form-control" min="2000" max="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" step="1" value="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" name="dateMax" />
                                </div>
                            </div>
                            <button type="button" onclick="fetchDataForMpandrayChart()" class="btn btn-primary">
                                Voir
                            </button>
                        </div>
                    </div>
                    
                </form>
            </div>
            <canvas id="mpandray-evolution"></canvas>
        </div>
                                
        <div class="col-md-6">
            <div class="row">
                <form id="evolution-form-mpandray">
                    <div class="my-md-3">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="col-md-3">
                                    <label class="form-label"> Année minimum </label>
                                </div>
                                <div class="col-md-9">
                                    <input type="number" class="form-control" min="2000" max="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" step="1" value="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" name="dateMin" />
                                </div>
                            </div>
                             <div class="col-md-6">
                                <div class="col-md-3">
                                    <label class="form-label"> Année maximum </label>
                                </div>
                                <div class="col-md-9">
                                    <input type="number" class="form-control" min="2000" max="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" step="1" value="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" name="dateMax" />
                                </div>
                            </div>
                            <button type="button" onclick="fetchDataForPieChart()" class="btn btn-primary">
                                Voir
                            </button>
                        </div>
                    </div>
                    
                </form>
            </div>
            <canvas id="mpandray-faritra"></canvas>
        </div>
                                
                                
                                
    </div>
</div>


<script src="${pageContext.request.contextPath}/assets/js/chart-js/Chart.js"></script>
<script>
    
    var groupedBarChart;
    var mpandrayBarChart;
    var repartitionChart;
         
        function fetchDataForEvolutionChart( event ){

                let form = document.getElementById("evolution-form");
                let formData = new FormData( form );
                formData.append("acte", "evolutions");
                fetch('/fjkm/statistiques', {
                    method: 'post',
                    body: formData
                }).then( response => response.json() )
                        .then( response => {
                            updateEvolutionChartData(response);
                });

        }
        
          function fetchDataForMpandrayChart( event ){

                let form = document.getElementById("evolution-form-mpandray");
                let formData = new FormData( form );
                formData.append("acte", "ev-mpandray");
                fetch('/fjkm/statistiques', {
                    method: 'post',
                    body: formData
                }).then( response => response.json() )
                        .then( response => {
                            updateMpandrayChartData(response);
                });

        }
        
        
        function updateEvolutionChartData( datasets ){
            let labels = [];
            let data = [];

            datasets.forEach( d => {
                    labels.push( d.annee );
                    data.push( d.nombre );
            } );

            groupedBarChart.data.labels = labels;
            
            let newDataset = {
                label: 'Effectif',
                data: data,
                fill: false,
                backgroundColor: 'blue'
            };
            groupedBarChart.data.datasets = [];
            groupedBarChart.data.datasets.push(newDataset);

            groupedBarChart.update();


        }
        
        function updateMpandrayChartData( datasets ){
            let labels = [];
            let data = [];

            datasets.forEach( d => {
                    labels.push( d.annee );
                    data.push( d.nombre );
            } );

            mpandrayBarChart.data.labels = labels;
            
            let newDataset = {
                label: 'Effectif',
                data: data,
                fill: false,
                backgroundColor: 'blue'
            };
            mpandrayBarChart.data.datasets = [];
            mpandrayBarChart.data.datasets.push(newDataset);

            mpandrayBarChart.update();


        }

        function fetchInitData() {
            fetch('/fjkm/statistiques').then( response => response.json() ).then( data => {
                let statistiqueEvo = data.evolutionCroyants;
                let statistiqueMpandray = data.evolutionMpandray;
                updateEvolutionChartData(statistiqueEvo);
                updateMpandrayChartData(statistiqueMpandray);
            });
        }
    
    $(document).ready(function() {
        
//        fetchInitData();
        let cotisationAn = document.getElementById("cotisation-an").getContext('2d');
        let mpandrayEvolution = document.getElementById("mpandray-evolution").getContext('2d');
        let mpandrayFaritra = document.getElementById("mpandray-faritra").getContext('2d');
        let xValues = [100,200,300,400];
        let options = {
                scaleBeginAtZero: true,
                scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
        }
        };
        xValues = <%= evolutionCroyants[0] %>;
        // Mila maka valeur ny eto zao no fantatro
        // Donc misy servlet ngeza be any maka azy fotsiny
        //  Andao ary eh
        groupedBarChart = new Chart(cotisationAn, {
          type: "line",
          data: {
            labels: xValues,
            datasets: [
                {
                    type: 'line',
                    data: <%= evolutionCroyants[1] %>,
                    label: 'Effectif',
                    fill: false
                }
            ]
          },
          options: {
                      ...options,
            title:{
                display: true,
                text: 'évolution des nombres de croyants'
            }
          }
        });
        
        xValues = <%= evolutionMpandray[0] %>;

        
        mpandrayBarChart = new Chart(mpandrayEvolution, {
          type: "bar",
          data: {
            labels: xValues,
            datasets: [{
                    label: 'Effectif',
                    data: <%= evolutionMpandray[1] %>
            }]
          },
          options: {
                      ...options,
            title:{
                display: true,
                text: 'évolution des nombres de croyants en confirmation'
            }
          }
        });
        xValues = <%= repartitionFaritra[0] %>;
        repartitionChart = new Chart(mpandrayFaritra, {
          type: "doughnut",
          data: {
            labels: xValues,
            datasets: [ {
                    data: <%= repartitionFaritra[1] %>
            }]
          },
          options: {
                      ...options,
            title:{
                display: true,
                text: 'évolution des nombres de croyants en confirmation'
            }
          }
        });
        
    });
    
    
    
</script>