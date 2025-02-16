/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package croyance.fandraisana;

/**
 *
 * @author sarobidy
 */
public class MpandrayLib extends Mpandray {
          
          String nomPromotion;
          String etatMpandray;

          public String getEtatMpandray() {
                    return etatMpandray;
          }

          public void setEtatMpandray(String etatMpandray) {
                    this.etatMpandray = etatMpandray;
          }
          
          public String getNomPromotion() {
                    return nomPromotion;
          }

          public void setNomPromotion(String nomPromotion) {
                    this.nomPromotion = nomPromotion;
          }
          
          public MpandrayLib(){
                    setNomTable("v_mpandray_lib");
          }
}
