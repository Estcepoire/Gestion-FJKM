package bureaux;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;

public class Bureaux extends ClassEtat {
    
    String idBureaux, nomBureaux, descriptionBureaux;
    Date dateCreation;
    String idTypeBureau;
    String typeBureau;

          public String getTypeBureau() {
                    return typeBureau;
          }

          public void setTypeBureau(String typeBureau) {
                    this.typeBureau = typeBureau;
          }
    
          public String getIdTypeBureau() {
                    return idTypeBureau;
          }

          public void setIdTypeBureau(String idTypeBureau) {
                    this.idTypeBureau = idTypeBureau;
          }

    public void setIdBureaux(String id){
        this.idBureaux = id;
    }

    public String getIdBureaux(){
        return this.idBureaux;
    }

    public void setNomBureaux( String nomBureaux ){
        this.nomBureaux = nomBureaux;
    }
    public String getNomBureaux(){
        return this.nomBureaux;
    }

    public void setDescriptionBureaux(String desc){
        this.descriptionBureaux = desc;
    }
    public String getDescriptionBureaux(){
        return this.descriptionBureaux;
    }

    public void setDateCreation( Date date ){
        this.dateCreation = date;
    }

    public Date getDateCreation(){
        return this.dateCreation;
    }

    public Bureaux(){
        this.setNomTable("bureaux");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("BUR", "get_seq_bureaux");
        this.setIdBureaux(this.makePK(c));
    }

          @Override
          public String getTuppleID() {
                   return this.getIdBureaux();
          }

          @Override
          public String getAttributIDName() {
                    return "idBureaux";
          }
    

}