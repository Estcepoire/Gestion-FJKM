/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package recensement;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author sarobidy
 */
public class Recensement extends ClassMAPTable {
          
          String idReportCroyant;
          String designation;
          int annee;
          int nombre;
          
          public Recensement(){
                    this.setNomTable("reportCroyant");
          }

          public String getIdReportCroyant() {
                    return idReportCroyant;
          }

          public void setIdReportCroyant(String idReportCroyant) {
                    this.idReportCroyant = idReportCroyant;
          }

          public String getDesignation() {
                    return designation;
          }

          public void setDesignation(String designation) {
                    this.designation = designation;
          }

          public int getAnnee() {
                    return annee;
          }

          public void setAnnee(int annee) {
                    this.annee = annee;
          }

          public int getNombre() {
                    return nombre;
          }

          public void setNombre(int nombre) {
                    this.nombre = nombre;
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("REC", "get_seq_reportcroyant");
                    this.setIdReportCroyant(this.makePK(c));
          }

          @Override
          public String getTuppleID() {
                    return this.getIdReportCroyant();
          }

          @Override
          public String getAttributIDName() {
                   return "idReportCroyant";
          }
          
          
          
          
}
