/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bureaux.membership;

/**
 *
 * @author sarobidy
 */
public class MembreBureauxLib extends MembreBureaux{
          
          String nomMpivavaka;
          String descrole;
          
          public MembreBureauxLib(){
                    this.setNomTable("v_membre_bureaux_lib");
          }

          public String getNomMpivavaka() {
                    return nomMpivavaka;
          }

          public void setNomMpivavaka(String nomMpivavaka) {
                    this.nomMpivavaka = nomMpivavaka;
          }

          public String getDescrole() {
                    return descrole;
          }

          public void setDescrole(String descrole) {
                    this.descrole = descrole;
          }
          
          
          
}
