/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cotisation;

import bean.ClassMere;
import java.sql.Connection;

/**
 *
 * @author sarobidy
 */
public class Cotisation extends ClassMere {
          
          String idPaiementCotisation;
          String designation;
          int mois;
          int annee;

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("PAC", "get_seq_cotisation");
                    this.setIdPaiementCotisation(this.makePK(c));
          }
          
          public Cotisation() throws Exception{
                    this.setNomTable("paiementcotisation");
                    this.setNomClasseFille("cotisation.DetailCotisation");
                    this.setLiaisonFille("idPaiementCotisation");
          }
          
          public String getIdPaiementCotisation() {
                    return idPaiementCotisation;
          }

          public void setIdPaiementCotisation(String idPaiementCotisation) {
                    this.idPaiementCotisation = idPaiementCotisation;
          }

          public int getMois() {
                    return mois;
          }

          public void setMois(int mois) {
                    this.mois = mois;
          }

          public int getAnnee() {
                    return annee;
          }

          public void setAnnee(int annee) {
                    this.annee = annee;
          }

          public String getDesignation() {
                    return designation;
          }

          public void setDesignation(String designation) {
                    this.designation = designation;
          }
          

          @Override
          public String getTuppleID() {
                    return this.getIdPaiementCotisation();
          }

          @Override
          public String getAttributIDName() {
                   return "idPaiementCotisation";
          }
          
          
          
}
