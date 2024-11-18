/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package statistique.chart;

import com.google.gson.Gson;
import com.google.gson.annotations.Expose;

/**
 *
 * @author sarobidy
 */
public class MultilineChart {
          @Expose

          String[] labels;
                    @Expose
          Object[] data;

          public String[] getLabels() {
                    return labels;
          }

          public void setLabels(String[] labels) {
                    this.labels = labels;
          }

          public Object[] getData() {
                    return data;
          }

          public void setData(Object[] data) {
                    this.data = data;
          }
          
          public String getLabelsAsJson(){
                    return new Gson().toJson(this.getLabels());
          }
          
          
          public String getDatasetsJson(){
                    return new Gson().toJson(this.getData());
          }
          
          public String toJson(){
                    return new Gson().toJson(this);
          }
}
