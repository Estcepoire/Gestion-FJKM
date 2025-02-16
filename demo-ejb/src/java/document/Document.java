/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package document;

import bean.CGenUtil;
import bean.ClassMAPTable;
import historique.MapUtilisateur;
import java.sql.Connection;
import java.sql.Date;
import mg.spat.AttacherFichier;
import utilitaire.UtilDB;

/**
 *
 * @author sarobidy
 */
public class Document extends AttacherFichier {
          
          double taille;
          String extension;
          String idMpivavaka;
          Date dateAjout;
          String idTypeDocument;
          String numeroDocument;
          String mimeType;
          
          String typeDocument;

          public String getTypeDocument() {
                    return typeDocument;
          }

          public void setTypeDocument(String typeDocument) {
                    this.typeDocument = typeDocument;
          }
          
          public String getIdMpivavaka() {
                    return idMpivavaka;
          }

          public void setIdMpivavaka(String idMpivavaka) {
                    this.idMpivavaka = idMpivavaka;
          }

          public Date getDateAjout() {
                    return dateAjout;
          }

          public void setDateAjout(Date dateAjout) {
                    this.dateAjout = dateAjout;
          }

          public String getIdTypeDocument() {
                    return idTypeDocument;
          }

          public void setIdTypeDocument(String idTypeDocument) {
                    this.idTypeDocument = idTypeDocument;
          }

          public String getNumeroDocument() {
                    return numeroDocument;
          }

          public void setNumeroDocument(String numeroDocument) {
                    this.numeroDocument = numeroDocument;
          }

          public double getTaille() {
                    return taille;
          }

          public void setTaille(double taille) {
                    this.taille = taille;
          }

          public String getExtension() {
                    return extension;
          }

          public void setExtension(String extension) {
                    this.extension = extension;
          }
          
          public Document(){
                    this.setNomTable("document");
          }
          
          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("DOC", "get_seq_document");
                    this.setId(this.makePK(c));
          }
          
          void generateNumeroDocument( Connection c ) throws Exception{
                    int value = utilitaire.Utilitaire.getMaxSeq("get_seqpiecejointe", c);
                    String feno = utilitaire.Utilitaire.completerInt(8,  value);
                    this.setNumeroDocument(feno);
          }

          @Override
          public ClassMAPTable createObject(String u, Connection c) throws Exception {
                    this.construirePK(c);
                   this.generateNumeroDocument(c);
                    MapUtilisateur utilisateur =( (MapUtilisateur[])CGenUtil.rechercher(new MapUtilisateur(), null, null, c, " and refuser ='" + u + "'"))[0];
//                    this.setIdMpivavaka(u);
                    this.setIdMpivavaka(utilisateur.getIdMpivavaka());
                   this.insertToTableWithHisto(u, c);
                   return this;
          }

          public String getMimeType() {
                    return mimeType;
          }

          public void setMimeType(String mimeType) {
                    this.mimeType = mimeType;
          }
          
          public Document getDocument(String id) throws Exception{
                    try(Connection connection = new UtilDB().GetConn()){
                              Document[] docs = (Document[]) CGenUtil.rechercher( this, null, null, connection, " and id ='" + id + "'" );
                              return docs[0];
                    }
          }
}
