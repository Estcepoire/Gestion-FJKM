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
          
          String idDetailPaiement, idMpivavaka, idPaiementCotisation, referencePaiement, nomComplet;
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

          public void setMontant(double montant) throws Exception {
                    System.out.println();
                    if(this.getMode().equalsIgnoreCase("modif"))
                              if( montant < 0 ) throw new Exception("Le montant ne doit pas etre négatif");
                    this.montant = montant;
          }

          public Date getDatePaiement() {
                    return datePaiement;
          }

          public void setDatePaiement(Date datePaiement) {
                    this.datePaiement = datePaiement;
          }

          public String getNomComplet() {
                    return nomComplet;
          }

          public void setNomComplet(String nomComplet) {
                    this.nomComplet = nomComplet;
          }
          
          @Override
          public String getTuppleID() {
                    return this.getIdDetailPaiement();
          }

          @Override
          public String getAttributIDName() {
                    return "idDetailPaiement";
          }

          @Override
          public void controlerUpdate(Connection c) throws Exception {
                    this.setLiaisonMere("idPaiementCotisation");
                    this.setNomClasseMere("cotisation.Cotisation");
                    super.controlerUpdate(c);
          }
          
          
          
          
          
}
