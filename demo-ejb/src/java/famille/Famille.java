package famille;

import java.sql.Connection;

import bean.ClassMere;

public class Famille extends ClassMere {
    String id;
    String val;
    String desce;
    String idFaritra;
    String idFaritralib;

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

    public String getIdFaritra() {
        return idFaritra;
    }

    public void setIdFaritra(String idFaritra) {
        this.idFaritra = idFaritra;
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
        this.preparePk("FAM", "GET_SEQfamille");
        this.setId(makePK(c));
    }

    public Famille() throws Exception {
        this.setNomTable("famille");
        this.setLiaisonFille("idMere");
        this.setNomClasseFille("famille.FamilleFille");
    }

    public String getIdFaritralib() {
        return idFaritralib;
    }

    public void setIdFaritralib(String idFaritralib) {
        this.idFaritralib = idFaritralib;
    }

    @Override
    public String[] getMotCles() {
        String[] motCles = { "id", "val" };
        return motCles;
    }

    @Override
    public String[] getValMotCles() {
        String[] valMotCles = { "id", "val" };
        return valMotCles;
    }

}
