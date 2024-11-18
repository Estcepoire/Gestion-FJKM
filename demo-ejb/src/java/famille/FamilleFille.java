package famille;

import java.sql.Connection;

import bean.ClassFille;

public class FamilleFille extends ClassFille {
    String id;
    String idMere;
    String idMpivavaka;
    String remarque;

    String idMpivavakalib;
    String idMpivavakalib2;

    public String getIdMpivavakalib() {
        return idMpivavakalib;
    }

    public void setIdMpivavakalib(String idMpivavakalib) {
        this.idMpivavakalib = idMpivavakalib;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdMere() {
        return idMere;
    }

    public void setIdMere(String idMere) {
        this.idMere = idMere;
    }

    public String getIdMpivavaka() {
        return idMpivavaka;
    }

    public void setIdMpivavaka(String idMpivavaka) {
        this.idMpivavaka = idMpivavaka;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("FAMF", "GET_SEQfamille");
        this.setId(makePK(c));
    }

    public FamilleFille() throws Exception {
        this.setNomTable("familleFille");
        this.setLiaisonMere("idMere");
        setNomClasseMere("famille.Famille");
    }

    public String getIdMpivavakalib2() {
        return idMpivavakalib2;
    }

    public void setIdMpivavakalib2(String idMpivavakalib2) {
        this.idMpivavakalib2 = idMpivavakalib2;
    }

}
