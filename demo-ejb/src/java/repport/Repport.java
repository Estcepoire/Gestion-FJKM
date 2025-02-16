package repport;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import caisse.EtatCaisse;

import java.sql.*;

public class Repport extends ClassEtat {
    String id;
    String idcaisse;
    double montant;
    double montanttheorique;
    Date daty;
    String remarque;

    String idcaisselib;

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

    public String getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(String idcaisse) {
        this.idcaisse = idcaisse;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getMontanttheorique() {
        return montanttheorique;
    }

    public void setMontanttheorique(double montanttheorique) {
        this.montanttheorique = montanttheorique;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public Repport() {
        this.setNomTable("reportcaisse");
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("REPPORT", "GET_SEQmvtcaisse");
        this.setId(makePK(c));
    }

    public void calculeMontanttheorique() throws Exception {
        EtatCaisse etatCaisse = new EtatCaisse();
        etatCaisse.setIdCaisse(this.getIdcaisse());
        EtatCaisse[] etatcaisses = etatCaisse.caculEtatCaisse();
        if (etatcaisses.length <= 0) {
            throw new Exception("Etat de caisse invalide");
        }
        this.setMontanttheorique(etatcaisses[0].getReste());
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        this.calculeMontanttheorique();
        return super.createObject(u, c);
    }

    public boolean checkDoublon(Connection c) throws Exception {
        Repport base = new Repport();
        base.setNomTable("reportcaisse");
        String sqlWhere = String.format(" and daty = to_date('%s', 'YYYY-MM-DD') and idcaisse = '%s' ", this.getDaty(),
                this.getIdcaisse());
        Repport[] result = (Repport[]) CGenUtil.rechercher(base, null, null, c, sqlWhere);
        return result.length > 0;
    }

    @Override
    public void controler(Connection c) throws Exception {
        if (checkDoublon(c)) {
            throw new Exception("Report deja effectue pour cette caisse");
        }
        super.controler(c);
    }

}
