/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package croyance.fandraisana;

import bean.ClassMAPTable;
import croyance.MpivavakaLib;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author sarobidy
 */

public class Mpandray extends MpivavakaLib {
          
          String idMpandray;
          String numeroMpandray;
          Date dateNandraisana;
          String idPromotion;

          public String getNumeroMpandray() {
                    return numeroMpandray;
          }

          public void setNumeroMpandray(String numeroMpandray) {
                    this.numeroMpandray = numeroMpandray;
          }

          public Date getDateNandraisana() {
                    return dateNandraisana;
          }

          public void setDateNandraisana(Date dateNandraisana) {
                    this.dateNandraisana = dateNandraisana;
          }

          public String getIdPromotion() {
                    return idPromotion;
          }

          public void setIdPromotion(String idPromotion) {
                    this.idPromotion = idPromotion;
          }

          public String getIdMpandray() {
                    return idMpandray;
          }

          public void setIdMpandray(String idMpandray) {
                    this.idMpandray = idMpandray;
          }
          
          public Mpandray(){
                    this.setNomTable("mpandray");
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("MPY", "get_seq_mpandray");
                    this.setIdMpandray(this.makePK(c));
          }

          @Override
          public String getAttributIDName() {
                    return "idMpandray";
          }

          @Override
          public String getTuppleID() {
                    return this.getIdMpandray();
          }

          @Override
          public Object validerObject(String u, Connection c) throws Exception {
                    int numero = utilitaire.Utilitaire.getMaxSeq("get_numero_mpandray", c);
                    String feno = utilitaire.Utilitaire.completerInt(8,  numero);
                    this.setNumeroMpandray(feno);
                    return super.validerObject(u, c);
          }
          
          

          @Override
          public ClassMAPTable createObject(String u, Connection c) throws Exception {
                    return super.createObject(u, c);
          }
          
}
