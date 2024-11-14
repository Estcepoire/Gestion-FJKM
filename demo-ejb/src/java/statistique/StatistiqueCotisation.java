/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package statistique;

import bean.AdminGen;
import com.google.gson.Gson;
import cotisation.DetailCotisationLib;
import java.sql.Connection;
import java.util.List;
import statistique.chart.MultilineChart;
import utilitaire.UtilDB;
import utils.CalendarUtils;

/**
 *
 * @author sarobidy
 */
public class StatistiqueCotisation {
          
          
          /**
           * Datasets for mapping in Graph
           */
          class Datasets {
                    String label, borderColor;
                    String[] data;
                    String backgroundColor;

                    Datasets( String label, String color, String[] data ){
                              this.label = label;
                              this.borderColor = color;
                              this.data = data;
                              this.backgroundColor = color;
                    }
                              
          }
        
          
          DetailCotisationLib[] detailsAnnee;
          DetailCotisationLib[][] dataPerPeriods;
          
          MultilineChart multiple;

          public MultilineChart getMultiple() {
                    return multiple;
          }

          public void setMultiple(MultilineChart multiple) {
                    this.multiple = multiple;
          }
          
          public DetailCotisationLib[] getDetailsAnnee() {
                    return detailsAnnee;
          }

          public void setDetailsAnnee(DetailCotisationLib[] detailsAnnee) {
                    this.detailsAnnee = detailsAnnee;
          }
          
          public void init(Connection connection) throws Exception{
                    String[] debutFinAnneeEnCours = utilitaire.Utilitaire.getDebutFinAnnee();
                    String debut = debutFinAnneeEnCours[0];
                    String fin = debutFinAnneeEnCours[1];
                    this.setDetailsAnnee(new DetailCotisationLib().getPayementDetailsForYear(debut, fin, connection));
                    // Ilaina ny mois min
                    int moisMin = 1;
                    int moisMax = 12;
                    
                    int anneeFin = Integer.parseInt(fin.split("/")[2]);
                    int anneeDebut = anneeFin - 3;
                    
                    DetailCotisationLib[][] comparaisons = new DetailCotisationLib().getPayementsBetweenIntervals(moisMin, moisMax, anneeDebut, anneeFin, connection);
                    this.setDataPerPeriods(comparaisons);
                    // Mila avadika de type JSon
                    formatDatasetsMultiLine(anneeDebut, anneeFin);
                    
          }
          
          public void init() throws Exception{
                    try(Connection c = new UtilDB().GetConn()){
                              this.init(c);
                    }catch(Exception e){
                              e.printStackTrace();
                    }
          }
          
          public String[] getStatistiquesAnnees() {
                    String[] labels = new String[this.getDetailsAnnee().length];
                    String[] values = new String[this.getDetailsAnnee().length];
                    
                    for( int i = 0; i < this.getDetailsAnnee().length ; i++ ){
                              labels[i] = this.getDetailsAnnee()[i].getMoisLib();
                              values[i] = String.valueOf(this.getDetailsAnnee()[i].getMontant());
                    }
                    Gson g = new Gson();
                    String[] responses = { g.toJson(labels), g.toJson(values)  };
                    return responses;
          }
          
          // Okey ny statistiques manaraka de ny hoe evolution au cours de deux dates
         // Evolution sur 3 ans zany no atao zany aloha
          // Hoe otrany ahoana rehefa nandritra ny 3 taona isaky ny telo taona

          public DetailCotisationLib[][] getDataPerPeriods() {
                    return dataPerPeriods;
          }

          public void setDataPerPeriods(DetailCotisationLib[][] dataPerPeriods) {
                    this.dataPerPeriods = dataPerPeriods;
          }
          
          public void formatDatasetsMultiLine( int begin, int end ) throws Exception {
                    
                    List<String> colors = CalendarUtils.getColorsAsList();
                    String[] xAxes = AdminGen.getDistinct(dataPerPeriods[0], "moisLib");
                    Datasets[] datasets = new Datasets[dataPerPeriods.length];
                    for( int i = begin; i <= end; i++ ){
                              int index = i - begin;      
                              String color = CalendarUtils.getColors(colors, index);
                              String[] d = new String[ dataPerPeriods[index].length ];
                              for( int j = 0; j < d.length; j++ ){
                                        d[j] = String.valueOf( dataPerPeriods[index][j].getMontant()  );
                              }
                              datasets[index] = new Datasets( String.valueOf(i), color, d );
                    }
                    
                    MultilineChart multilines = new MultilineChart();
                    multilines.setData(datasets);
                    multilines.setLabels(xAxes);
                    //
                    setMultiple(multilines);

          }
          
          public DetailCotisationLib[] getPayementDetailsForYear(String mois1, String mois2, String an) throws Exception{
                    try(Connection connection = new UtilDB().GetConn()){
                             return new DetailCotisationLib().getPayementDetailsForYear(mois1, mois2, an, connection);
                    }
          }
          
          public MultilineChart getDataComparatif( String moisDebut, String moisFin, String anDebut, String anFin ) throws Exception{
                    try(Connection connection = new UtilDB().GetConn()){
                              
                              int m1 = Integer.parseInt(moisDebut);
                              int m2 = Integer.parseInt(moisFin);
                              int a1 = Integer.parseInt(anDebut);
                              int a2 = Integer.parseInt(anFin);
                              DetailCotisationLib[][] comparaisons = new DetailCotisationLib().getPayementsBetweenIntervals(m1, m2, a1, a2, connection);
                              this.setDataPerPeriods(comparaisons);
                              formatDatasetsMultiLine(a1, a2);
                              return this.getMultiple();
                              
                    }
          }
          
}
