/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package evenement;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author sarobidy
 */
public class Evenement extends ClassEtat {
          
          String idEvenement;
          String description;
          Date dateDebutEvenement;
          Date dateFinEvenement;
          Time heureDebut;
          Time heureFin;
          String idTypeEvenement;
          String idMpivavaka;
          String idMere;
          
          public Evenement(){
                    this.setNomTable("evenement");
          }

          public String getIdEvenement() {
                    return idEvenement;
          }

          public void setIdEvenement(String idEvenement) {
                    this.idEvenement = idEvenement;
          }

          public String getDescription() {
                    return description;
          }

          public void setDescription(String description) {
                    this.description = description;
          }

          public Date getDateDebutEvenement() {
                    return dateDebutEvenement;
          }

          public void setDateDebutEvenement(Date dateDebutEvenement) {
                    this.dateDebutEvenement = dateDebutEvenement;
          }

          public Date getDateFinEvenement() {
                    return dateFinEvenement;
          }

          public void setDateFinEvenement(Date dateFinEvenement) {
                    this.dateFinEvenement = dateFinEvenement;
          }

          public Time getHeureDebut() {
                    return heureDebut;
          }

          public void setHeureDebut(Time heureDebut) {
                    this.heureDebut = heureDebut;
          }

          public Time getHeureFin() {
                    return heureFin;
          }

          public void setHeureFin(Time heureFin) {
                    this.heureFin = heureFin;
          }

          public String getIdTypeEvenement() {
                    return idTypeEvenement;
          }

          public void setIdTypeEvenement(String idTypeEvenement) {
                    this.idTypeEvenement = idTypeEvenement;
          }

          public String getIdMpivavaka() {
                    return idMpivavaka;
          }

          public void setIdMpivavaka(String idMpivavaka) {
                    this.idMpivavaka = idMpivavaka;
          }

          public String getIdMere() {
                    return idMere;
          }

          public void setIdMere(String idMere) {
                    if( this.getMode().equalsIgnoreCase("modif") ){
                              if( idMere == null || idMere.trim().isEmpty() ) idMere = null;
                    }
                    this.idMere = idMere;
          }
          
          @Override
          public String getTuppleID() {
                    return this.getIdEvenement();
          }

          @Override
          public String getAttributIDName() {
                    return "idEvenement";
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("EVE", "get_seq_evenement");
                    this.setIdEvenement(this.makePK(c));
          }
          
          // Okey vita zay ny classe de base
          // Attaquons nous au plus dangereux
          // Aiza no asiana anle localisation
          // Anaty base ve?
          
          
}
