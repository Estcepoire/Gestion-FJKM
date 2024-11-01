package ligneCredit;

import java.sql.Connection;

import bean.ClassEtat;

public class LigneCredit extends ClassEtat {
    String id;
    String val;
    String desce;
    double credit;
    int annnee;
    String idtypelc;
    String idTypelclib;

    @Override
    public String getAttributIDName() {
        return "id";
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

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public int getAnnnee() {
        return annnee;
    }

    public void setAnnnee(int annnee) {
        this.annnee = annnee;
    }

    public String getIdtypelc() {
        return idtypelc;
    }

    public void setIdtypelc(String idtypelc) {
        this.idtypelc = idtypelc;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("LIGNE", "GET_SEQlignecredit");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public LigneCredit() {
        this.setNomTable("lignecredit");
    }

    public String getIdTypelclib() {
        return idTypelclib;
    }

    public void setIdTypelclib(String idTypelclib) {
        this.idTypelclib = idTypelclib;
    }

}
