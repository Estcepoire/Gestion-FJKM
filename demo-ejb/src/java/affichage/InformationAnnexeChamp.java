/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package affichage;

import annexe.InformationAnnexeLib;

/**
 *
 * @author sarobidy
 */
public class InformationAnnexeChamp extends InformationAnnexeLib {
          
          // Okey getHtml no ato
          String html;
          String name;
          
          public String getHtml(){
                    if( this.html == null  ) this.makeHtml();
                    return this.html;
          }
          
          public void setHtml( String html ){
                    this.html = html;
          }

          public String getName() {
                    return name;
          }

          public void setName(String name) {
                    this.name = name;
          }
          
          public void makeHtml(){
                    
                    if( this.getTypeChamp().contains("text") ) {
                              this.prepareTextInput();
                    }else if( this.getTypeChamp().contains("date") ){
                              this.prepareDateInput();
                    }else if( this.getTypeChamp().contains("select") ){
                              this.prepareListChamp();
                    }else{
                              this.prepareTextInput();
                    }
          }
          
          void prepareTextInput() {
                    String text = "<input name='%s' id='%s' value='%s' class='form-control' type='text' />";
                    text = String.format(text, this.getName(), this.getName(), this.getValeur() );
                    this.setHtml(text);
          }
          void prepareDateInput() {
                    String text = "<input name='%s' id='%s' value='%s  class='form-control' type='date' />";
                    text = String.format(text, this.getName(), this.getName(), this.getValeur() );
                    this.setHtml(text);
          }
          
          void prepareListChamp() {
                    String values = this.getValeurPossible();
                    String[] vals = values.split(";");
                    StringBuilder dropdown = new StringBuilder();
                    String entete = "<select name='%s' id='%s' class='form-control'>";
                    entete = String.format(entete, this.getName(), this.getName());
                    dropdown.append(entete);
                    for( String valeur: vals ){
                              String option = (valeur.equalsIgnoreCase(this.getValeur())) ? "selected": "";
                              String append = "<option %s value='%s'>%s</option>";
                              append = String.format(append, option ,valeur, valeur);
                              dropdown.append(append);
                    }
                    dropdown.append("</select>");
                    this.setHtml( dropdown.toString() );
          }

          
}
