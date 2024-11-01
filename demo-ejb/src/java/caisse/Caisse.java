package caisse;

import bean.ClassMAPTable;

public class Caisse extends ClassMAPTable {

    String id, val, desce, idtypecaisse;

    public Caisse() {
        setNomTable("caisse");
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

    public String getIdtypecaisse() {
        return idtypecaisse;
    }

    public void setIdtypecaisse(String idtypecaisse) {
        this.idtypecaisse = idtypecaisse;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return id;
    }

}
