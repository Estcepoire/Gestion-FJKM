/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package document;

import bean.ClassMAPTable;
import bean.TypeObjet;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;

/**
 *
 * @author sarobidy
 */
public class TypeDocument extends TypeObjet {
          
          public TypeDocument() {
                    this.setNomTable("typedocument");
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("TPD", "get_seq_type_document");
                    this.setId( this.makePK(c) );
          }

          @Override
          public ClassMAPTable createObject(String u, Connection c) throws Exception {
                    // Inona no atao ato
                    // Mila alaiko ny urlAna Download
                    String downloadUrl = utils.ConstanteFJKM.downloadPath;
                    // Mila mi-tcheck if file exists aloha za
                    String folderDocuments = downloadUrl + this.getVal();
                    System.out.println(folderDocuments);
                    File f = new File(folderDocuments);
                    if( ! f.exists() ){
                             Files.createDirectories(Paths.get(folderDocuments) );
                    }
                    return super.createObject(u, c);
          }
          
         
          
}
