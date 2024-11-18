package consommation;

import java.sql.Connection;
import java.sql.Date;

import bean.ClassMere;

public class Consommation extends ClassMere {
    String id;
    String val;
    Date daty;
    String description;
    String itypeconsommation;

    String itypeconsommationlib;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getItypeconsommation() {
        return itypeconsommation;
    }

    public void setItypeconsommation(String itypeconsommation) {
        this.itypeconsommation = itypeconsommation;
    }

    public Consommation() throws Exception {
        this.setNomTable("Consommation");
        setLiaisonFille("idMere");
        setNomClasseFille("consommation.ConsommationFille");
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CONSO", "GET_SEQMVTSTOCK");
        this.setId(makePK(c));
    }

    public String getItypeconsommationlib() {
        return itypeconsommationlib;
    }

    public void setItypeconsommationlib(String itypeconsommationlib) {
        this.itypeconsommationlib = itypeconsommationlib;
    }

}
