/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package affichage;

import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author sarobidy
 */
public class TypeChamp extends TypeObjet {
          
          public TypeChamp(){
                    this.setNomTable("typechamp");
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("TYP", "get_seq_typechamp");
                    this.setId( this.makePK(c) );
          }
          
}
