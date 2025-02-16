/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cotisation;

import bean.AdminGen;
import bean.CGenUtil;
import com.google.gson.annotations.Expose;
import java.sql.Connection;
import utilitaire.UtilDB;

/**
 *
 * @author sarobidy
 */
public class DetailCotisationLib extends DetailCotisation {
          @Expose
          String moisLib;
          @Expose
          int mois;
          @Expose
          int annee;
          @Expose
          double montantAnnee;
          
          public DetailCotisationLib() throws Exception{
                    super();
                    this.setNomTable("v_paiement_cotisation_lib_montant");
          }

          public String getMoisLib() {
                    return moisLib;
          }

          public void setMoisLib(String moisLib) {
                    this.moisLib = moisLib;
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
          
          public DetailCotisationLib[] getPayementDetailsForYear( String debut, String fin, Connection connection ) throws Exception {
                    
                    String moiss = debut.split("/")[1];
                    String anneee = debut.split("/")[2];
                    
                    String moisFin = fin.split("/")[1];
                    String anneeFin = fin.split("/")[2];
                    
                    DetailCotisationLib[] libs = ( DetailCotisationLib[] ) CGenUtil.rechercher( this, null, null, connection, " and mois >= " + moiss + " and mois <= " + moisFin + " and annee >= " + anneee + " and annee <= " + anneeFin );
                    return libs;
                    
          }
          
          public DetailCotisationLib[] getPayementDetailsForYear( String mois1, String mois2, String an, Connection connection ) throws Exception {
                  
                    DetailCotisationLib[] libs = ( DetailCotisationLib[] ) CGenUtil.rechercher( this, null, null, connection, " and mois >= " + mois1 + " and mois <= " + mois2 + " and annee = "  + an);
                    return libs;
          }
          
          
          public DetailCotisationLib[][] getPayementsBetweenIntervals( int moisMin, int moisMax, int anneeMin, int anneeMax, Connection c ) throws Exception{
                    
                    // Mois entre ( moisMin, moisMax ) fermés
                    // et année entre (anneeMin, anneeMax)
                    
                    this.setNomTable("v_paiement_cotisation_lib_montant");
                    String[] colInt = {"mois", "annee"};
                    String[] valInt = { String.valueOf(moisMin) , String.valueOf(moisMax), String.valueOf(anneeMin), String.valueOf(anneeMax)    };
                    
                    DetailCotisationLib[] cotisationsSurPeriodes = ( DetailCotisationLib[] ) CGenUtil.rechercher(this, colInt, valInt, c, "");
                    
                    int yearGap = anneeMax - anneeMin;
                    int monthGap = moisMax - moisMin;
                    
                    // Initialisation des données pour garder les valeurs par ans
                    DetailCotisationLib[][] separatedDetails = new DetailCotisationLib[ yearGap + 1 ][ monthGap + 1 ];
                    // Boucler pour les années
                    int j = 0;
                    for( int i = anneeMin; i <= anneeMax ; i++ ){
                              // Récuperer les données pour les années
                              String[] valEt = { String.valueOf(i) };
                              String[] attEt = {"annee"};
                              DetailCotisationLib[] perMonths = ( DetailCotisationLib[] ) AdminGen.findInList(cotisationsSurPeriodes, attEt , valEt);
                              separatedDetails[j] = perMonths;
                              j = j + 1;
                    }
                    
                    return separatedDetails;
                    
          }

          public double getMontantAnnee() {
                    return montantAnnee;
          }

          public void setMontantAnnee(double montantAnnee) {
                    this.montantAnnee = montantAnnee;
          }
          
          public DetailCotisationLib getStatistiquesTotales( int year, Connection connection ) throws Exception {
                    String sql = "SELECT \n" +
                              "    SUM(montant)::double precision AS montant,\n" +
                              "    SUM(CASE WHEN EXTRACT(YEAR FROM datePaiement) = %d THEN montant ELSE 0 END)::double precision AS montantAnnee \n" +
                              " FROM detailpaiementcotisation";
                    sql = String.format(sql, year);
                    this.setNomTable("v_map_stat_an");
                    DetailCotisationLib detail = ((DetailCotisationLib[]) CGenUtil.rechercher( this, sql, connection ))[0];
                    return detail;
          }
          
}
