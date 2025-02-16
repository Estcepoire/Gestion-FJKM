/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package croyance;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author sarobidy
 */
public class Mpivavaka extends ClassEtat {
          
          String idMpivavaka;
          String nom;
          String prenom;
          Date datenaissance;
          String lieuDeNaissance;
          int sexe;
          String contact;
          String addresse;
          String idFaritra;
          
          public Mpivavaka(){
                    this.setNomTable("mpivavaka");
          }

          public String getIdMpivavaka() {
                    return idMpivavaka;
          }

          public void setIdMpivavaka(String idMpivavaka) {
                    this.idMpivavaka = idMpivavaka;
          }

          public String getNom() {
                    return nom;
          }

          public void setNom(String nom) {
                    this.nom = nom;
          }

          public String getPrenom() {
                    return prenom;
          }

          public void setPrenom(String prenom) {
                    this.prenom = prenom;
          }

          public Date getDatenaissance() {
                    return datenaissance;
          }

          public void setDatenaissance(Date datenaissance) {
                    this.datenaissance = datenaissance;
          }

          public String getLieuDeNaissance() {
                    return lieuDeNaissance;
          }

          public void setLieuDeNaissance(String lieuDeNaissance) {
                    this.lieuDeNaissance = lieuDeNaissance;
          }

          public int getSexe() {
                    return sexe;
          }

          public void setSexe(int sexe) {
                    this.sexe = sexe;
          }

          public String getContact() {
                    return contact;
          }

          public void setContact(String contact) {
                    this.contact = contact;
          }

          public String getAddresse() {
                    return addresse;
          }

          public void setAddresse(String addresse) {
                    this.addresse = addresse;
          }

          @Override
          public String getTuppleID() {
                    return this.getIdMpivavaka();
          }

          @Override
          public String getAttributIDName() {
                   return "idMpivavaka";
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("MPI", "get_seq_mpivavaka");
                    String pk = this.makePK(c);
                    this.setIdMpivavaka(pk);
          }

          public String getIdFaritra() {
                    return idFaritra;
          }

          public void setIdFaritra(String idFaritra) {
                    this.idFaritra = idFaritra;
          }
          
          
          
}
