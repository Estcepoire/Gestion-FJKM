/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package evenement;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import historique.MapUtilisateur;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import utilitaire.UtilDB;

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
          boolean ouvert;
          
          String longitude;
          String latitude;
          String lieu;

          public String getLieu() {
                    return lieu;
          }

          public void setLieu(String lieu) {
                    this.lieu = lieu;
          }
          
          public void setOuvert(boolean b){
                    this.ouvert = b;
          }
          public boolean getOuvert(){
                    return this.ouvert;
          }
          
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
          
          public boolean isEvenementFille(){
                    return this.getIdMere() != null && !this.getIdMere().isEmpty();
          }
          
          public void controllerEvenementFille(Connection c) throws Exception{
                    if( this.isEvenementFille() ){
                              Evenement e = new Evenement();
                              String requete = "select * from evenement where idEvenement = '" + this.getIdMere() + "'";
                              e = ( (Evenement[]) CGenUtil.rechercher(e, requete, c ))[0];
                              if( this.getDateDebutEvenement().before(e.getDateDebutEvenement()) ){
                                        throw new Exception("La date de début ne peut être antérieure à la date début mère : " + e.getDateDebutEvenement());
                              }
                              if(  utilitaire.Utilitaire.compareDaty(this.getDateDebutEvenement(), e.getDateFinEvenement())== 1 )
                                        throw new Exception("La date de début ne peut être postérieure à la date fin mère : " + e.getDateFinEvenement());
                              if( utilitaire.Utilitaire.compareDaty(this.getDateFinEvenement(), e.getDateFinEvenement())== 1 )
                                        throw new Exception("La date de fin ne peut être postérieure à la date fin mère : " + e.getDateFinEvenement());
                    }
          }

          @Override
          public void controler(Connection c) throws Exception {
                    if( this.getDateFinEvenement().before(this.getDateDebutEvenement()) ){
                              throw new Exception("La date fin de l&apos;evenement est inférieure à la date de début");
                    }
                    this.controllerEvenementFille(c);
          }

          @Override
          public void controlerUpdate(Connection c) throws Exception {
                    this.controler(c);
                    super.controlerUpdate(c);
          }
          
          @Override
          public ClassMAPTable createObject(String u, Connection c) throws Exception {
                    if( this.getTuppleID() != null && !this.getTuppleID().isEmpty() ) {
                              return this;
                    } // Efa feno avy amin'ny affichage
                    MapUtilisateur us = new MapUtilisateur();
                    us.setRefuser(u);
                    MapUtilisateur[] users = (MapUtilisateur[]) CGenUtil.rechercher(us, null, null, c, "");
                    if( users.length > 0 ) this.setIdMpivavaka(users[0].getIdMpivavaka());
                    return super.createObject(u, c); 
          }
          
          public String getOuvertString(){
                    if( this.getOuvert() ) return "1";
                    return "0";
          }

          public String getLongitude() {
                    return longitude;
          }

          public void setLongitude(String longitude) {
                    this.longitude = longitude;
          }

          public String getLatitude() {
                    return latitude;
          }

          public void setLatitude(String latitude) {
                    this.latitude = latitude;
          }
          
          public void terminer() throws Exception{
                    Connection connection = null;
                    try{
                              connection = new UtilDB().GetConn();
                              // Okey alohan'ny anao terminer de mila jerena hoe mety ve ilay condition
                              Date now = Date.valueOf( LocalDate.now() );
                              
                              Evenement e =((Evenement[]) CGenUtil.rechercher(this, null, null, connection, ""))[0];
                              if( utilitaire.Utilitaire.compareDaty(e.getDateDebutEvenement(), now) == 1 ){
                                        throw new Exception("Vous ne pouvez pas terminer un evenement qui n'a pas encore commencé");
                              }
                              // Sinon terminer ilay izy
                              // Etat 200
                              e.setEtat(200);
                              e.updateToTable(connection);
                    }catch(Exception e){
                              if( connection != null ) connection.rollback();
                              e.printStackTrace();
                              throw e;
                    }finally{
                              if(connection != null) connection.close();
                    }
          }
          
}
