<%-- 
    Document   : index
    Created on : Nov 5, 2024, 10:03:02 AM
    Author     : sarobidy
--%>

<%@page import="affichage.Champ"%>
<%@page import="affichage.Liste"%>
<%@page import="statistique.chart.MultilineChart"%>
<%@page import="statistique.StatistiqueCotisation"%>
<%
          
    statistique.StatistiqueCotisation stats = new StatistiqueCotisation();
    stats.init();
    String[] datas = stats.getStatistiquesAnnees();
    MultilineChart multi = stats.getMultiple();
    
    Liste mois = new Liste("mois");
    mois.makeListeMois();
    Liste moisFin = new Liste("mois2");
    moisFin.makeListeMois();

%>



<style>
    
    .ui-datepicker-year{
        display: none;
    }

    .img-icon {
        width: 100px;
    }
    
</style>

<div class="content-wrapper my-2">

    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body border-1">
                    <div class="row justify-content-center">
                        <img src="${pageContext.request.contextPath}/assets/img/stats/statistic.png" alt="" class="img-icon">
                    </div>
                    Cotisations reçus en général : <%= utilitaire.Utilitaire.formaterAr(stats.getStatistiqueAnnuelle().getMontant()) %> Ar
                </div>
            </div>
        </div>
        <div class="col-md-5">
            <div class="card">
                <div class="card-body text-center">
                    <div class="row justify-content-center">
                        <img src="${pageContext.request.contextPath}/assets/img/stats/calendar.png" alt="" class="img-icon">
                    </div>
                    Montant cette année : <%= utilitaire.Utilitaire.formaterAr(stats.getStatistiqueAnnuelle().getMontantAnnee()) %> Ar
                </div>
            </div>
        </div>
    </div>
    <div class="row my-3">
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <div class="box box-success">
                    <div class="box-body">
                        <div class="row">
                            <h3 class="text-center">
                                Etat de paiement par année
                            </h3>
                            <form id="payement-an">
                                <div class="my-md-3">
                                    <div class="row">
                                        
                                        <div class="col-md-3">
                                            <label class="form-label"> Mois Début </label>
                                            <%= mois.getHtml() %>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label"> Mois Fin </label>
                                            <%= moisFin.getHtml() %>
                                        </div>
                                        <div class="col-md-3">
                                                <label class="form-label"> Année </label>
                                                <input type="number" class="form-control" min="2000" value="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" name="an" />
                                        </div>
                                            <div class="col-md-3">
                                                <label> &nbsp;&nbsp; </label>
                                                <button type="button" onclick="fetchDataForAYear(event)" class="btn btn-primary">
                                                    Voir
                                                </button>
                                            </div>
                                    </div>
                                </div>

                            </form>
                        </div>
                        <canvas id="cotisation-an"></canvas>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <div class="box box-primary">
                    <div class="box-body">
                        <div class="row">
                            <h3 class="text-center">
                                Comparaison des evolutions de paiements
                            </h3>
                            <form id="comparaison-an">
                                <div class="my-md-3">
                                    <div class="row">
                                        
                                        <div class="col-md-6">
                                            <label class="form-label"> Mois Sébut et Fin </label>
                                            <div class="row">
                                                <div class="col-md-6">
                                                        <%= mois.getHtml() %>
                                                </div>
                                                <div class="col-md-6">
                                                        <%= moisFin.getHtml() %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                                <label class="form-label"> Année à comparer </label>                          
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <input type="number" min="2000" id="date-test-1" class="form-control" value="<%= utilitaire.Utilitaire.getAneeEnCours() - 3 %>" name="dateMin" />
                                                </div>
                                                <div class="col-md-4">
                                                     <input type="number" min="2000" id="date-test-2" class="form-control" value="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" name="dateMax" />
                                                </div>
                                                <div class="col-md-4">
                                                    <button type="button" onclick="fetchDataComparatif()" class="btn btn-primary"> Consulter </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </form>
                        </div>
                        <canvas id="cotisation-an-lignes"></canvas>
                    </div>
                </div>
            </div>
        </div>
        
        
</div>



<script src="${pageContext.request.contextPath}/assets/js/chart-js/Chart.js"></script>

<script>
    
    var groupedBarChart ;
    var mLinesChart;
    
    function updateChartPerYearData(datasets){
        let labels = [];
        let data = [];
        
        datasets.forEach( dataset => {
            labels.push( dataset.moisLib );
            data.push( dataset.montant );
        });
        
        groupedBarChart.data.labels = labels;
        let newDataset = {
            label: 'Montant récolté',
            data: data,
            fill: false,
            borderColor: '#2e99bd'
        };
        groupedBarChart.data.datasets = [];
        groupedBarChart.data.datasets.push(newDataset);

        groupedBarChart.update();

    }
    
    function updateDataComparatif(response){
        let labels = response.labels;
        
        
        mLinesChart.data.labels = labels;
        let newDataset = {
            label: 'Montant récolté',
            data: data,
            fill: false,
            borderColor: '#2e99bd'
        };
        mLinesChart.data.datasets = response.data;
//        mLinesChart.data.datasets.push(newDataset);

        mLinesChart.update();

    }
    
    
    function fetchDataComparatif(){
        let form = document.getElementById("comparaison-an");
        let formData = new FormData(form);
        formData.append("acte", "comparaison-an");
        fetch('/fjkm/statistiques', {
            method: 'POST',
            body: formData
        }).then(response => response.json())
                .then( response => {
                    console.log(response);
            updateDataComparatif(response);
        });
    }
    
    /**
     * 
     * 
     */
    
    function fetchDataForAYear(event) {
        event.preventDefault();
        let forms = document.getElementById("payement-an");
        let formData = new FormData(forms);
        formData.append("acte", "paiement-an");
        fetch( '/fjkm/statistiques', {
            method: 'POST',
            body: formData
        }) .then(response => response.json())
            .then( response => {
                updateChartPerYearData(response);
        });
        
    }
    
    $(document).ready(function() {
        
        // Mamadika champ ho lasa DatePicker
        $("#date-test").datepicker({
            dateFormat: 'dd/mm',
            changeYear: false
        });
        $("#date-test-2").datepicker({
            dateFormat: 'dd/mm',
            changeYear: false
        });
        
        
        let cotisationAn = document.getElementById("cotisation-an").getContext('2d');
        let cotisationAnLignes = document.getElementById("cotisation-an-lignes").getContext('2d');
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
        xValues = <%= datas[0] %>;
        
        groupedBarChart = new Chart(cotisationAn, {
          type: "line",
          data: {
            labels: xValues,
            datasets: [{
                label: 'Montant Payées',
              data: <%= datas[1] %>,
              borderColor: '#2e99bd',
              fill: false
            }]
          },
          options: {
                      ...options,
            title:{
                display: true,
                text: 'Total des cotisations par mois'
            }
          }
        });
        mLinesChart = new Chart(cotisationAnLignes, {
          type: "line",
          data: {
            labels: <%= multi.getLabelsAsJson() %>,
            datasets: <%= multi.getDatasetsJson() %>
          },
          options: {
                      ...options,
            title:{
                display: true,
                text: 'Comparaison des paiements de cotisations'
            }
          }
        });
    });
    
</script>


<script>
    let data = {};
    //generate dummy data
    var current = new Date(new Date().getFullYear()+'-01-01T00:00:00');
    var end = new Date(new Date().getFullYear()+'-12-31T00:00:00');
    while(current <= end){
        unit = current.getDate()+'.'+(current.getMonth()+1)+'.'+current.getFullYear()+
            'T'+current.getHours()+':'+current.getMinutes()+':'+current.getSeconds();
        random = Math.floor((Math.random() * 10) + 1);
        if(random > 6){
            data[unit] = random -6;
        }
        current.setDate(current.getDate()+1);
    }
    
    console.log(data);
    let heatmap = new HeatmapPlugin('heatmap',data,{},{},true);
   
</script>