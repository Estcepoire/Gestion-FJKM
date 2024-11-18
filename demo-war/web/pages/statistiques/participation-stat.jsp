<%-- 
    Document   : participation-stat
    Created on : Nov 15, 2024, 8:03:49 PM
    Author     : sarobidy
--%>

<%@page import="statistique.StatistiqueCotisation"%>
<%@page import="statistique.StastitiqueWrapper"%>
<%
    StatistiqueCotisation cotisaka = new StatistiqueCotisation();
    cotisaka.initFrequencePayement();
    
%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/Cal-Heatmap/cal-heatmap.css"/>

<div class="content-wrapper">
    
    <div class="row">
        <div class="col-md-10">
            <div class="box box-success bg-white p-3">
                <div class="box-body">
                    <h3 class="text-center"> Visualisation de la participation des membres sur la cotisation </h3>
                    <div class="row my-3">
                        <!-- Filtre par année -->
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-md-3">
                                    <label class="form-label"> Voir pour l'année </label>
                                </div>
                                <div class="col-md-4">
                                    <input type="number" class="form-control" id="filter" min="1970" max="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" value="<%= utilitaire.Utilitaire.getAnneeEnCours() %>" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row my-3">
                        <div class="col-md-12">
                            <div id="cal-heatmap"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
                                
                                
                                
<script src="${pageContext.request.contextPath}/assets/Cal-Heatmap/d3.v7.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/Cal-Heatmap/cal-heatmap.min.js"></script>
<script>
    var heatmap;
    
    $(document).ready(function() {

        var events = <%= cotisaka.getFrequences() %>;
        var data = [];
        for (var i = 0; i < events.length; i++) {
            data.push({
                date: events[i].datePaiement,
                value: parseInt(events[i].montant).toFixed(0)
            });
            
        }
    const cal = new CalHeatmap();
    cal.paint({
      data: {
          source: data,
          y: datum => {
                return  +datum['value'];
          }
      },
      range: 12, // Show the last 12 months
      domain: {
            type: 'month',
            gutter: 4,
            dynamicDimension: false,
            padding: [4, 4, 4, 4]
      },
      subDomain: {
            type: "day"
     },
     date: {
         start: new Date('2024-01-01')
     },
     scale: {
         color: {
             range: ['lightblue', 'blue'],
             interpolate: 'hsl',
             type: 'linear',
             domain: [0, 10, 20, 30, 40, 50, 60, 100]
         }
    }
      
    });
    
        $("#filter").blur( (e) => {
            fetchDataForYear(e.target.value);
        });
        
        function fetchDataForYear( year ){
            console.log("Hets");
            let uri = "/fjkm/statistiques";
            let formData = new FormData();
            formData.append("acte", "participation");
            formData.append("an", year);
            fetch(uri, {
                method: 'POST',
                body: formData
            }).then( response => response.json() )
                    .then(response => {
                        // miantso update data
                         let data = [];
                         for (let i = 0; i < response.length; i++) {
                             data.push({
                                 value: parseInt(response[i].montant).toFixed(0),
                                 date: response[i].datePaiement
                             });
                         }
                         
                         cal.paint({
                                data: {
                                    source: data,
                                    y: datum => {
                                          return  +datum['value'];
                                    }
                                },
                                range: 12, // Show the last 12 months
                                domain: {
                                      type: 'month',
                                      gutter: 4,
                                      dynamicDimension: false,
                                      padding: [4, 4, 4, 4]
                                },
                                subDomain: {
                                      type: "day"
                               },
                               date: {
                                   start: new Date(year+'-01-01')
                               },
                               scale: {
                                   color: {
                                       range: ['lightblue', 'blue'],
                                       interpolate: 'hsl',
                                       type: 'linear',
                                       domain: [0, 10, 20, 30, 40, 50, 60, 100]
                                   }
                              }

                              });

                     });
        }
        
    });
    
</script>