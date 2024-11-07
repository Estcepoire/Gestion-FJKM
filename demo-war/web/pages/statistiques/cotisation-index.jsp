<%-- 
    Document   : index
    Created on : Nov 5, 2024, 10:03:02 AM
    Author     : sarobidy
--%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="row">
                <form>
                    <div class="my-md-3">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="col-md-3">
                                    <label class="form-label"> Année minimum </label>
                                </div>
                                <div class="col-md-9">
                                    <input type="date" name="an-min" />
                                </div>
                            </div>
                             <div class="col-md-6">
                                <div class="col-md-3">
                                    <label class="form-label"> Année maximum </label>
                                </div>
                                <div class="col-md-9">
                                    <input type="date" name="an-max" />
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </form>
            </div>
            <canvas id="cotisation-an"></canvas>
        </div>
    </div>
</div>


<script src="${pageContext.request.contextPath}/assets/js/chart-js/Chart.js"></script>
<script>
    
    $(document).ready(function() {
            let cotisationAn = document.getElementById("cotisation-an").getContext('2d');
            let xValues = [100,200,300,400];
        let options = {
            scaleBeginAtZero: true
        };
        xValues = ["jan", "fev","mar","avr","mai","juin","juillet","août","septembre","octobre","novembre","décembre"];
        // Mila maka valeur ny eto zao no fantatro
        // Donc misy servlet ngeza be any maka azy fotsiny
        //  Andao ary eh
        var groupedBarChart = new Chart(cotisationAn, {
          type: "line",
          data: {
            labels: xValues,
            datasets: [{
                label: 'Visiteurs',
              data: [50,50,53,56,57,58,72,67,34, 45,69,42],
              backgroundColor: '#2e99bd',
              fill: false
            }]
          },
          options: {
                      ...options,
            title:{
                display: true,
                text: 'Total visiteurs et clients'
            }
          }
        });
    });
    
</script>