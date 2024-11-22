/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package annexe;

/**
 *
 * @author sarobidy
 */
public class InformationAnnexeLib extends InformationAnnexe {
          
          String typeChamp;
          String valeur = "";
          String idInfoMpivavaka;

          public InformationAnnexeLib() {
                    this.setNomTable("v_information_lib");
          }

          public String getTypeChamp() {
                    return typeChamp;
          }

          public void setTypeChamp(String typeChamp) {
                    this.typeChamp = typeChamp;
          }
          
          
          public String getValeur() {
                    return valeur;
          }

          public void setValeur(String valeur) {
                    this.valeur = valeur;
          }

          public String getIdInfoMpivavaka() {
                    return idInfoMpivavaka;
          }

          public void setIdInfoMpivavaka(String idInfoMpivavaka) {
                    this.idInfoMpivavaka = idInfoMpivavaka;
          }
          
}
