package caisse;

import bean.ClassEtat;
import java.sql.Date;

import java.sql.Connection;

public class MvtCaisse extends ClassEtat {

    String id;
    String designation;
    String idCaisse;
    Date daty;
    String idOrigine;
    String idTiers;
    double debit;
    double credit;

    String idFacturefournisseurlib;
    String idtierslib;
    String idcaisselib;

    public String getIdFacturefournisseurlib() {
        return idFacturefournisseurlib;
    }

    public void setIdFacturefournisseurlib(String idFacturefournisseurlib) {
        this.idFacturefournisseurlib = idFacturefournisseurlib;
    }

    public String getIdtierslib() {
        return idtierslib;
    }

    public void setIdtierslib(String idtierslib) {
        this.idtierslib = idtierslib;
    }

    public String getIdcaisselib() {
        return idcaisselib;
    }

    public void setIdcaisselib(String idcaisselib) {
        this.idcaisselib = idcaisselib;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIdOrigine() {
        return idOrigine;
    }

    public void setIdOrigine(String idOrigine) {
        this.idOrigine = idOrigine;
    }

    public String getIdTiers() {
        return idTiers;
    }

    public void setIdTiers(String idTiers) {
        this.idTiers = idTiers;
    }

    public double getDebit() {
        return debit;
    }

    public void setDebit(double debit) {
        this.debit = debit;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public MvtCaisse() {
        this.setNomTable("mvtcaisse");
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
        this.preparePk("MVTCAISSE", "GET_SEQmvtcaisse");
        this.setId(makePK(c));
    }

}
