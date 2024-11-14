<%-- 
    Document   : index
    Created on : Nov 5, 2024, 10:03:02 AM
    Author     : sarobidy
--%>

<%@page import="statistique.chart.MultilineChart"%>
<%@page import="statistique.StatistiqueCotisation"%>
<%
          
    statistique.StatistiqueCotisation stats = new StatistiqueCotisation();
    stats.init();
    String[] datas = stats.getStatistiquesAnnees();
    MultilineChart multi = stats.getMultiple();

%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/heatmap/heatmap.css"/>

<style>
    
    .ui-datepicker-year{
        display: none;
    }
    
</style>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-10">
            <div class="box box-success">
                <div class="box-body">
                    <div class="row">
                        <form id="">
                            <div class="my-md-3">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="col-md-3">
                                            <label class="form-label"> Année </label>
                                        </div>
                                        <div class="col-md-9">
                                            <input type="number" class="form-control" min="2000" value="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" name="an" />
                                        </div>
                                    </div>
                                        <div class="col-md-2">
                                            <button class="btn btn-primary">
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
                                
        <div class="col-md-10">
            <div class="box box-primary">
                <div class="box-body">
                    <div class="row">
                        <form id="">
                            <div class="my-md-3">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="col-md-3">
                                            <label class="form-label"> Du </label>
                                        </div>
                                        <div class="col-md-9">
                                            <input type="textbox" id="date-test" class="form-control" value="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" name="dateMin" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="col-md-3">
                                            <label class="form-label"> Aù </label>
                                        </div>
                                        <div class="col-md-9">
                                            <input type="textbox" id="date-test-2" class="form-control" value="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" name="dateMax" />
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
        <div class="col-md-6">
            <div class="row">
                <div id="heatmap"></div>
            </div>
        </div>
    </div>
</div>


<script src="${pageContext.request.contextPath}/assets/heatmap/heatmap.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/chart-js/Chart.js"></script>
<script>
    
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
        
        var groupedBarChart = new Chart(cotisationAn, {
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
        var mLinesChart = new Chart(cotisationAnLignes, {
          type: "line",
          data: {
            labels: <%= multi.getLabelsAsJson() %>,
            datasets: [{
                label: '2022',
              data: [50*9850,6*9850,53*9850,56*9850,57*9850,58*9850,72*9850,67*9850,34*9850, 100*9850,69*98500,9850*42],
              borderColor: '#C8A2C8',
              fill: false
            },{
                label: '2023',
              data: [50*20000,6*20000,53*20000,56*20000,57*20000,58*20000,72*20000,67*20000,34*20000, 100*20000,69*200000,20000*42],
              borderColor: '#DDA0DD',
              fill: false
            },{
                label: '2024',
              data: <%= datas[1] %>,
              borderColor: '#2e99bd',
              fill: false
            }]
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