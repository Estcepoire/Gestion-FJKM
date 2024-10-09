/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package croyance.promotion;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author sarobidy
 */
public class Promotion extends ClassEtat {
          
          String idPromotion;
          String nomPromotion;
          int anneePromotion;
          Date dateSortie;
          
          public Promotion(){
                    this.setNomTable("promotionmpandray");
          }

          public String getIdPromotion() {
                    return idPromotion;
          }

          public void setIdPromotion(String idPromotion) {
                    this.idPromotion = idPromotion;
          }

          public String getNomPromotion() {
                    return nomPromotion;
          }

          public void setNomPromotion(String nomPromotion) {
                    this.nomPromotion = nomPromotion;
          }

          public int getAnneePromotion() {
                    return anneePromotion;
          }

          public void setAnneePromotion(int anneePromotion) {
                    this.anneePromotion = anneePromotion;
          }

          public Date getDateSortie() {
                    return dateSortie;
          }

          public void setDateSortie(Date dateSortie) {
                    this.dateSortie = dateSortie;
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("PROM", "get_seq_promotion");
                    this.setIdPromotion(this.makePK(c));
          }

          @Override
          public String getTuppleID() {
                    return this.getIdPromotion();
          }

          @Override
          public String getAttributIDName() {
                    return "idPromotion";
          }
          
          
          
          
          
          
}
