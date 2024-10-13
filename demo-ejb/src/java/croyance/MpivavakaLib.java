/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package croyance;

/**
 *
 * @author sarobidy
 */
public class MpivavakaLib extends Mpivavaka {
          
          int ageActuelle;
          String nomFaritra;
          String genre;
          String nomComplet;

          public String getNomComplet() {
                    return nomComplet;
          }

          public void setNomComplet(String nomComplet) {
                    this.nomComplet = nomComplet;
          }
          
          public MpivavakaLib(){
                    this.setNomTable("v_mpivavaka_lib");
          }

          public int getAgeActuelle() {
                    return ageActuelle;
          }

          public void setAgeActuelle(int age) {
                    this.ageActuelle = age;
          }

          public String getNomFaritra() {
                    return nomFaritra;
          }

          public void setNomFaritra(String nomFaritra) {
                    this.nomFaritra = nomFaritra;
          }

          public String getGenre() {
                    return genre;
          }

          public void setGenre(String genre) {
                    this.genre = genre;
          }
          
          
}
