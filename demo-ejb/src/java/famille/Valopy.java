package famille;

import java.sql.Connection;
import java.sql.Date;

import bean.ClassEtat;

public class Valopy extends ClassEtat {

    String id;
    String val;
    String desce;
    String idfamille;
    String idMpivavaka;
    double montant;
    Date daty;

    String idfamillelib, idMpivavakalib, idMpivavakalib2;

    public String getIdfamillelib() {
        return idfamillelib;
    }

    public void setIdfamillelib(String idfamillelib) {
        this.idfamillelib = idfamillelib;
    }

    public String getIdMpivavakalib() {
        return idMpivavakalib;
    }

    public void setIdMpivavakalib(String idMpivavakalib) {
        this.idMpivavakalib = idMpivavakalib;
    }

    public String getIdMpivavakalib2() {
        return idMpivavakalib2;
    }

    public void setIdMpivavakalib2(String idMpivavakalib2) {
        this.idMpivavakalib2 = idMpivavakalib2;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public String getDesce() {
        return desce;
    }

    public void setDesce(String desce) {
        this.desce = desce;
    }

    public String getIdfamille() {
        return idfamille;
    }

    public void setIdfamille(String idfamille) {
        this.idfamille = idfamille;
    }

    public String getIdMpivavaka() {
        return idMpivavaka;
    }

    public void setIdMpivavaka(String idMpivavaka) {
        this.idMpivavaka = idMpivavaka;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public Valopy() {
        setNomTable("valopy");
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

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("VAL", "GET_SEQfamille");
        this.setId(makePK(c));
    }

}
