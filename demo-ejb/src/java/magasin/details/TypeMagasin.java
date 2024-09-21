package magasin.details;

import java.sql.Connection;

import bean.ClassMAPTable;

public class TypeMagasin extends ClassMAPTable {
    String id, val, desce;

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

    public TypeMagasin() {
        this.setNomTable("TYPEMAGASIN");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TYPRO", "GET_SEQTYPEMAGASIN");
        this.setId(makePK(c));
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

}
