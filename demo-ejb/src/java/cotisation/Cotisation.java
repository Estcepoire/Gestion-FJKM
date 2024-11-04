/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cotisation;

import bean.ClassMere;
import java.sql.Connection;
import utilitaire.UtilDB;

/**
 *
 * @author sarobidy
 */
public class Cotisation extends ClassMere {
          
          String idPaiementCotisation;
          String designation;
          int mois;
          int annee;
          
          String moisLib;
          double montant;

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
          
          public Cotisation(String mois, String annee) throws Exception{
                    this();
                    this.setAnnee(annee);
                    this.setMois(mois);
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
          
          public void setMois(String month){
                    this.setMois( Integer.parseInt(month) );
          }

          public int getAnnee() {
                    return annee;
          }

          public void setAnnee(int annee) {
                    this.annee = annee;
          }
          
          public void setAnnee(String ans){
                    this.setAnnee( Integer.parseInt(ans) );
          }

          public String getDesignation() {
                    return designation;
          }

          public void setDesignation(String designation) {
                    this.designation = designation;
          }

          public String getMoisLib() {
                    return moisLib;
          }

          public void setMoisLib(String moisLib) {
                    this.moisLib = moisLib;
          }

          public double getMontant() {
                    return montant;
          }

          public void setMontant(double montant) {
                    this.montant = montant;
          }
          
          @Override
          public String getTuppleID() {
                    return this.getIdPaiementCotisation();
          }

          @Override
          public String getAttributIDName() {
                   return "idPaiementCotisation";
          }
          
          public void ouvrirPayement( String refUser ) throws Exception {
                    
                    this.setEtat(10);
                    Connection connection = null;
                    try{
                              connection = new UtilDB().GetConn();
                              super.createObject(refUser, connection);
                    }catch(Exception e){
                              if(connection != null)
                                        connection.rollback();
                            e.printStackTrace();
                            throw e;
                    }finally{
                              if(connection != null)
                                        connection.close();
                    }
          }
          
          
          
}
