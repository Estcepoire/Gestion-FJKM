/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package croyance.information;

import bean.CGenUtil;
import bean.ClassMAPTable;
import com.google.gson.Gson;
import croyance.MpivavakaLib;
import java.sql.Connection;

/**
 *
 * @author sarobidy
 */
public class InformationMpivavaka extends MpivavakaLib {
          
          // Atao extends Mpivavaka Lib satria misy ilaiko azy avy eo
          String idInfoMpivavaka, idInfoAnnexe, valeur, information;
          
          public InformationMpivavaka(){
                    this.setNomTable("mpivavaka_informations");
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("INM","get_seq_information");
                    this.setIdInfoMpivavaka(this.makePK(c));
          }

          @Override
          public String getAttributIDName() {
                    return "idInfoMpivavaka";
          }

          @Override
          public String getTuppleID() {
                    return this.getIdInfoMpivavaka();
          }
          
         
          public String getIdInfoMpivavaka() {
                    return idInfoMpivavaka;
          }

          public void setIdInfoMpivavaka(String idInfo) {
                    this.idInfoMpivavaka = idInfo;
          }

          public String getIdInfoAnnexe() {
                    return idInfoAnnexe;
          }

          public void setIdInfoAnnexe(String idInfoAnnexe) {
                    
                    this.idInfoAnnexe = idInfoAnnexe;
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
                    inf.setIdInfoAnnexe(this.getIdInfoAnnexe());
                    System.out.println("hahahahahha");

                    InformationMpivavaka[] results = (InformationMpivavaka[]) CGenUtil.rechercher(inf, null, null, c, "");
                    if( results.length > 0 ){
                              results[0].setValeur(this.getValeur());
                              results[0].updateToTableWithHisto(u, c);
                              return results[0];
                    }
                    return super.createObject(u, c);
          }

          public String getInformation() {
                    return information;
          }

          public void setInformation(String information) {
                    this.information = information;
          }
          
          
          
          @Override
          public String toString(){
                    return new Gson().toJson(this);
          }
          
          
          
}
