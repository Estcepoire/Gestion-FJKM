package ligneCredit;

import bean.ClassMAPTable;

public class EtatLigne extends ClassMAPTable {

    String id;
    String val;
    int annee;
    String idtypelignecredit;
    String idtypelignecreditlib;
    double totalcredit;
    double totalrecettes;
    double totaldepenses;
    double balance;

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

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public String getIdtypelignecredit() {
        return idtypelignecredit;
    }

    public void setIdtypelignecredit(String idtypelignecredit) {
        this.idtypelignecredit = idtypelignecredit;
    }

    public String getIdtypelignecreditlib() {
        return idtypelignecreditlib;
    }

    public void setIdtypelignecreditlib(String idtypelignecreditlib) {
        this.idtypelignecreditlib = idtypelignecreditlib;
    }

    public double getTotalcredit() {
        return totalcredit;
    }

    public void setTotalcredit(double totalcredit) {
        this.totalcredit = totalcredit;
    }

    public double getTotalrecettes() {
        return totalrecettes;
    }

    public void setTotalrecettes(double totalrecettes) {
        this.totalrecettes = totalrecettes;
    }

    public double getTotaldepenses() {
        return totaldepenses;
    }

    public void setTotaldepenses(double totaldepenses) {
        this.totaldepenses = totaldepenses;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public EtatLigne() {
        this.setNomTable("v_typelignecredit");
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
