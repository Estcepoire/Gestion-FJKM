/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package annexe;

import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author sarobidy
 */
public class InformationAnnexe extends ClassEtat {
          String id;
          String val;
          String desce;
          String valeurPossible;
          String idTypeChamp;
          // Okey efa azoko eto ito de lasa miampy valeur possible sy idTypeChamp
          
          public InformationAnnexe(){
                    this.setNomTable("infoannexe");
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("INF", "get_seqInfo");
                    this.setId( this.makePK(c) );
          }
          
          public String getId() {
                    return id;
          }

          public void setId(String id) {
                    this.id = id;
          }

          public String getVal() {
                    return val;
          }

          public void setVal(String val) {
                    this.val = val;
          }

          public String getDesce() {
                    return desce;
          }

          public void setDesce(String desce) {
                    this.desce = desce;
          }

          @Override
          public String getTuppleID() {
                    return this.getId();
          }

          @Override
          public String getAttributIDName() {
                    return "id";
          }

          public String getValeurPossible() {
                    return valeurPossible;
          }

          public void setValeurPossible(String valeurPossible) {
                    this.valeurPossible = valeurPossible;
          }

          public String getIdTypeChamp() {
                    return idTypeChamp;
          }

          public void setIdTypeChamp(String idTypeChamp) {
                    this.idTypeChamp = idTypeChamp;
          }
          
}
