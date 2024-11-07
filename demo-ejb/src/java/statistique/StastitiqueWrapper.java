/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package statistique;

import annexe.Faritra;
import com.google.gson.Gson;
import java.sql.Connection;
import utilitaire.UtilDB;

/**
 *
 * @author sarobidy
 */
public class StastitiqueWrapper {
          
          EvolutionCroyant[] evolutionCroyants;
          EvolutionCroyant[] evolutionMpandray;
          Faritra[] repartitionFaritra;
          EvolutionCroyant etatActuelle;

          public EvolutionCroyant getEtatActuelle() {
                    return etatActuelle;
          }

          public void setEtatActuelle(EvolutionCroyant etatActuelle) {
                    this.etatActuelle = etatActuelle;
          }
          
          public Faritra[] getRepartitionFaritra() {
                    return repartitionFaritra;
          }

          public void setRepartitionFaritra(Faritra[] repartitionFaritra) {
                    this.repartitionFaritra = repartitionFaritra;
          }
          
          public EvolutionCroyant[] getEvolutionCroyants() {
                    return evolutionCroyants;
          }

          public void setEvolutionCroyants(EvolutionCroyant[] evolutionCroyants) {
                    this.evolutionCroyants = evolutionCroyants;
          }

          public EvolutionCroyant[] getEvolutionMpandray() {
                    return evolutionMpandray;
          }

          public void setEvolutionMpandray(EvolutionCroyant[] evolutionMpandray) {
                    this.evolutionMpandray = evolutionMpandray;
          }
          
          public void init( String min, String max, Connection connection ) throws Exception {
                    EvolutionCroyant[] s1 = new EvolutionCroyant().generateQueryBetweenMinMax(min, max, connection);
                    EvolutionCroyant[] s2 = new EvolutionCroyant().getMpandrayEvolution(min, max, connection);
                    this.setEvolutionCroyants(s1);
                    this.setEvolutionMpandray(s2);
                    
          }
          
          public void initCompletely( Connection connection ) throws Exception{
                    String max = utilitaire.Utilitaire.getAnneeEnCours();
                    String min = String.valueOf(utilitaire.Utilitaire.getAneeEnCours() - 5 );
                     EvolutionCroyant[] s1 = new EvolutionCroyant().generateQueryBetweenMinMax(min, max, connection);
                    EvolutionCroyant[] s2 = new EvolutionCroyant().getMpandrayEvolution(min, max, connection);
                    this.setEvolutionCroyants(s1);
                    this.setEvolutionMpandray(s2);
                    this.setRepartitionFaritra( new Faritra().getGeneralisationFaritra(connection) );
                    this.setEtatActuelle( new EvolutionCroyant().getCurrentStatus(utilitaire.Utilitaire.getAneeEnCours(), connection) );
                    
          }
          
          public void init() throws Exception{
                    try(Connection connection = new UtilDB().GetConn()){
                              this.initCompletely(connection);
                    }catch(Exception e){
                              throw e;
                    }
          }
          
          // Mila maka ny statistiques générales
          
          public String[] getStatistiquesEvolutionCroyant(){
                    String[] labels = new String[this.getEvolutionCroyants().length];
                    String[] values = new String[this.getEvolutionCroyants().length];
                    for(int i = 0; i < this.getEvolutionCroyants().length ; i++){
                              labels[i] = String.valueOf(this.getEvolutionCroyants()[i].getAnnee());
                              values[i] = String.valueOf( this.getEvolutionCroyants()[i].getNombre() );
                    }
                    
                    String[] returns = { new Gson().toJson(labels), new Gson().toJson(values) };
                    return returns;
                    
          }
          
          public String[] getStatistiquesEvolutionMpandray(){
                    String[] labels = new String[this.getEvolutionMpandray().length];
                    String[] values = new String[this.getEvolutionMpandray().length];
                    for(int i = 0; i < this.getEvolutionMpandray().length ; i++){
                              labels[i] = String.valueOf(this.getEvolutionMpandray()[i].getAnnee());
                              values[i] = String.valueOf( this.getEvolutionMpandray()[i].getNombre() );
                    }
                    
                    String[] returns = { new Gson().toJson(labels), new Gson().toJson(values) };
                    return returns;
                    
          }
          
         public String[] getRepartitionData(){
                    String[] labels = new String[this.getRepartitionFaritra().length];
                    String[] values = new String[this.getRepartitionFaritra().length];
                    for(int i = 0; i < this.getRepartitionFaritra().length ; i++){
                              labels[i] = String.valueOf(getRepartitionFaritra()[i].getNomFaritra());
                              values[i] = String.valueOf( getRepartitionFaritra()[i].getNombre() );
                    }
                    
                    String[] returns = { new Gson().toJson(labels), new Gson().toJson(values) };
                    return returns;
                    
          }
          
          
          
}
