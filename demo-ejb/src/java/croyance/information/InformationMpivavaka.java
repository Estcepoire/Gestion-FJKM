/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package croyance.information;

import bean.CGenUtil;
import bean.ClassMAPTable;
import croyance.MpivavakaLib;
import java.sql.Connection;

/**
 *
 * @author sarobidy
 */
public class InformationMpivavaka extends MpivavakaLib {
          
          // Atao extends Mpivavaka Lib satria misy ilaiko azy avy eo
          String idInfo, idAnnexe, valeur;
          
          public InformationMpivavaka(){
                    this.setNomTable("mpivavaka_informations");
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("INM","get_seq_information");
          }

          @Override
          public String getAttributIDName() {
                    return "idInfo";
          }

          @Override
          public String getTuppleID() {
                    return this.getIdInfo();
          }
          
         
          public String getIdInfo() {
                    return idInfo;
          }

          public void setIdInfo(String idInfo) {
                    this.idInfo = idInfo;
          }

          public String getIdAnnexe() {
                    return idAnnexe;
          }

          public void setIdAnnexe(String idAnnexe) {
                    
                    this.idAnnexe = idAnnexe;
          }

          public String getValeur() {
                    return valeur;
          }

          public void setValeur(String valeur) throws Exception {
                    if( this.getMode().equalsIgnoreCase("modif") ) {
                              if( !valeur.isEmpty()  && valeur.trim().isEmpty() ) throw new Exception("Veuillez entrez une valeur correcte");
                    }
                    this.valeur = valeur;
          }

          @Override
          public ClassMAPTable createObject(String u, Connection c) throws Exception {
                    // Inona moa no ato
                    // Raha mi-existe ilay couple de atao update
                    InformationMpivavaka inf = new InformationMpivavaka();
                    inf.setIdMpivavaka(this.getIdMpivavaka());
                    inf.setIdAnnexe(this.getIdAnnexe());
                    InformationMpivavaka[] results = (InformationMpivavaka[]) CGenUtil.rechercher(inf, null, null, c, idAnnexe);
                    if( results.length > 0 ){
                              results[0].setValeur(this.getValeur());
                              results[0].updateToTableWithHisto(u, c);
                              return results[0];
                    }
                    return this;
          }
          
          
          
          
          
}
