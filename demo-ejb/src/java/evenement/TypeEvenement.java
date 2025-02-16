/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package evenement;

import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author sarobidy
 */
public class TypeEvenement extends TypeObjet {
          
          public TypeEvenement(){
                    this.setNomTable("typeevenement");
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("TPE", "get_seq_type_evenement");
                    this.setId( this.makePK(c) );
                    // super.construirePK(c); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
          }
          
          
}
