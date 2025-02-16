/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bureaux.membership;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author sarobidy
 */
public class MembreBureaux extends ClassEtat {
          
          String idMembreBureaux;
          String idMpivavaka;
          String idBureaux;
          String idRole;
          Date dateAdmission;
          
          public MembreBureaux(){
                    this.setNomTable("membrebureaux");
          }

          public String getIdMembreBureaux() {
                    return idMembreBureaux;
          }

          public void setIdMembreBureaux(String idMembreBureaux) {
                    this.idMembreBureaux = idMembreBureaux;
          }

          public String getIdMpivavaka() {
                    return idMpivavaka;
          }

          public void setIdMpivavaka(String idMpivavaka) {
                    this.idMpivavaka = idMpivavaka;
          }

          public String getIdBureaux() {
                    return idBureaux;
          }

          public void setIdBureaux(String idBureaux) {
                    this.idBureaux = idBureaux;
          }

          public String getIdRole() {
                    return idRole;
          }
          
          public void setDefaultRole(){
                    this.idRole = utils.ConstanteFJKM.MEMBRE;
          }

          public void setIdRole(String idRole) {
                    
                    if( this.getMode().equalsIgnoreCase("modif") && ( idRole == null || idRole.trim().isEmpty() ) ){
                              this.setDefaultRole();
                              return;
                    }
                    this.idRole = idRole.trim();
          }

          public Date getDateAdmission() {
                    return dateAdmission;
          }

          public void setDateAdmission(Date dateAdmission) {
                    this.dateAdmission = dateAdmission;
          }

          @Override
          public String getTuppleID() {
                    return this.getIdMembreBureaux();
          }

          @Override
          public String getAttributIDName() {
                    return "idMembreBureaux";
          }
          
          @Override
          public void construirePK(Connection c) throws Exception {
                   this.preparePk("MMB", "get_seq_membrebureaux");
                   this.setIdMembreBureaux(this.makePK(c));
          }
          
          
}
