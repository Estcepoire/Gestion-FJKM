/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cotisation;

import bean.ClassFille;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author sarobidy
 */
public class DetailCotisation extends ClassFille {
          
          String idDetailPaiement, idMpivavaka, idPaiementCotisation, referencePaiement;
          double montant;
          Date datePaiement;

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("DPC", "get_seq_detailPaiementCotisation");
                    this.setIdDetailPaiement(this.makePK(c));
          }
          
          public DetailCotisation() throws Exception{
                    this.setNomTable("detailpaiementcotisation");
                    this.setLiaisonMere("idPaiementCotisation");
                    setNomClasseMere("cotisation.Cotisation");
          }
          
          

          public String getIdDetailPaiement() {
                    return idDetailPaiement;
          }

          public void setIdDetailPaiement(String idDetailPaiement) {
                    this.idDetailPaiement = idDetailPaiement;
          }

          public String getIdMpivavaka() {
                    return idMpivavaka;
          }

          public void setIdMpivavaka(String idMpivavaka) {
                    this.idMpivavaka = idMpivavaka;
          }

          public String getIdPaiementCotisation() {
                    return idPaiementCotisation;
          }

          public void setIdPaiementCotisation(String idPaiementCotisation) {
                    this.idPaiementCotisation = idPaiementCotisation;
          }

          public String getReferencePaiement() {
                    return referencePaiement;
          }

          public void setReferencePaiement(String referencePaiement) {
                    this.referencePaiement = referencePaiement;
          }

          public double getMontant() {
                    return montant;
          }

          public void setMontant(double montant) {
                    this.montant = montant;
          }

          public Date getDatePaiement() {
                    return datePaiement;
          }

          public void setDatePaiement(Date datePaiement) {
                    this.datePaiement = datePaiement;
          }
          
          

          @Override
          public String getTuppleID() {
                    return this.getIdDetailPaiement();
          }

          @Override
          public String getAttributIDName() {
                    return "idDetailPaiement";
          }
          
          
          
}
