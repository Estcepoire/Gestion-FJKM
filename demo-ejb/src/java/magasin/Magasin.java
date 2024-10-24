package magasin;

import java.sql.Connection;

import bean.ClassMAPTable;

public class Magasin extends ClassMAPTable {

    String id, val, desce;

    public Magasin() {
        this.setNomTable("MAGASIN");
    }

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

    public String getDesce() {
        return desce;
    }

    public void setDesce(String desce) {
        this.desce = desce;
    }


    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("UNIT", "GET_SEQMAGASIN");
        this.setId(makePK(c));
    }

}
