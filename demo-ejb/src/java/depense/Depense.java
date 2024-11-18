package depense;

import java.sql.Connection;
import java.sql.Date;

import bean.ClassEtat;
import caisse.MvtCaisse;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

public class Depense extends ClassEtat {

    String id;
    String designation;
    Date daty;
    String idtypedepense;
    double montant;
    String idlignecredit;
    String idCaisse;

    String idOrigine;
    String recu;

    String idtypedepenselib;
    String idlignecreditlib;
    String idOriginelib;
    String idCaisselib;


    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }

    public String getIdCaisselib() {
        return idCaisselib;
    }

    public void setIdCaisselib(String idCaisselib) {
        this.idCaisselib = idCaisselib;
    }

    public String getIdtypedepenselib() {
        return idtypedepenselib;
    }

    public void setIdtypedepenselib(String idtypedepenselib) {
        this.idtypedepenselib = idtypedepenselib;
    }

    public String getIdlignecreditlib() {
        return idlignecreditlib;
    }

    public void setIdlignecreditlib(String idlignecreditlib) {
        this.idlignecreditlib = idlignecreditlib;
    }

    public String getIdOriginelib() {
        return idOriginelib;
    }

    public void setIdOriginelib(String idOriginelib) {
        this.idOriginelib = idOriginelib;
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

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIdtypedepense() {
        return idtypedepense;
    }

    public void setIdtypedepense(String idtypedepense) {
        this.idtypedepense = idtypedepense;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
        if (montant <= 0) {
            throw new Exception("montant invalide");
        }
        this.montant = montant;
    }

    public String getIdlignecredit() {
        return idlignecredit;
    }

    public void setIdlignecredit(String idlignecredit) {
        this.idlignecredit = idlignecredit;
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
        this.preparePk("DEP", "GET_SEQdepense");
        this.setId(makePK(c));

    }

    public String getIdOrigine() {
        return idOrigine;
    }

    public void setIdOrigine(String idOrigine) {
        this.idOrigine = idOrigine;
    }

    public Depense() {
        this.setNomTable("depense");
    }

    public String genererCaisse(String u, Connection c, String idCaisse) throws Exception {
        boolean canClose = false;
        String idmvt;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                canClose = true;
            }
            MvtCaisse mvtCaisse = new MvtCaisse();
            if (this.getEtat() == 11) {
                mvtCaisse.setIdCaisse(idCaisse);
                mvtCaisse.setIdOrigine(this.getId());
                mvtCaisse.setDaty(Utilitaire.dateDuJourSql());
                mvtCaisse.setDesignation(this.getDesignation());
                mvtCaisse.setCredit(this.getMontant());
                mvtCaisse.setDebit(0);
                mvtCaisse = (MvtCaisse) mvtCaisse.createObject(u, c);
                idmvt = mvtCaisse.getId();
            } else {
                throw new Exception("La d&eacute;pense doit &ecirc;tre valid&eacute;e");
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (canClose) {
                c.close();
            }
        }
        return idmvt;
    }

    public String getRecu() {
        return recu;
    }

    public void setRecu(String recu) {
        this.recu = recu;
    }

}