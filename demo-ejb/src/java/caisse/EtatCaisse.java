package caisse;

import bean.*;
import java.sql.Date;
import utilitaire.*;

public class EtatCaisse extends ClassMAPTable {

    String id;
    String idCaisse;
    String idcaisseLib;
    String idtypecaisse;
    String idtypecaisselib;
    Date dateDernierReport;
    double montantDernierReport;
    double debit;
    double credit;
    double reste;

    Date daty;
    String datyMin;
    String datyMax;

    

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getDatyMin() {
        return datyMin;
    }

    public void setDatyMin(String datyMin) {
        this.datyMin = datyMin;
    }

    public String getDatyMax() {
        return datyMax;
    }

    public void setDatyMax(String datyMax) {
        this.datyMax = datyMax;
    }

    public EtatCaisse() {
        setNomTable("V_ETATCAISSEVIDE");
    }


    public String getIdcaisseLib() {
        return idcaisseLib;
    }

    public void setIdcaisseLib(String idcaisseLib) {
        this.idcaisseLib = idcaisseLib;
    }

    public String getIdtypecaisse() {
        return idtypecaisse;
    }

    public void setIdtypecaisse(String idtypecaisse) {
        this.idtypecaisse = idtypecaisse;
    }

    public String getIdtypecaisselib() {
        return idtypecaisselib;
    }

    public void setIdtypecaisselib(String idtypecaisselib) {
        this.idtypecaisselib = idtypecaisselib;
    }

    public Date getDateDernierReport() {
        return dateDernierReport;
    }

    public void setDateDernierReport(Date dateDernierReport) {
        this.dateDernierReport = dateDernierReport;
    }

    public double getMontantDernierReport() {
        return montantDernierReport;
    }

    public void setMontantDernierReport(double montantDernierReport) {
        this.montantDernierReport = montantDernierReport;
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

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String generateQueryCore(Date dateMax, Date dateMin) {
        String query = " SELECT  " +
                "r.ID ,  " +
                "r.IDCAISSE,  " +
                "c.val AS idcaisseLib,  " +
                "c.idtypecaisse,  " +
                "tc.desce AS idtypecaisselib,  " +
                "r.DATY AS dateDernierReport,  " +
                "COALESCE(r.MONTANT, 0) AS montantDernierReport,  " +
                "COALESCE(mvt.debit, 0) AS debit,   " +
                "COALESCE(mvt.credit, 0) AS credit,   " +
                "COALESCE(mvt.credit, 0) + COALESCE(r.MONTANT, 0) - COALESCE(mvt.debit, 0) AS reste  " +
                "FROM   " +
                "REPORTCAISSE r " +
                "JOIN  " +
                "(SELECT   " +
                "r.IDCAISSE,  " +
                "MAX(r.DATY) AS maxDateReport  " +
                "FROM   " +
                "REPORTCAISSE r   " +
                "WHERE   " +
                "r.ETAT = 11   " +
                "AND r.DATY <= '" + Utilitaire.datetostring(dateMin) + "'  " +
                "GROUP BY r.IDCAISSE  " +
                ") rm ON r.IDCAISSE = rm.IDCAISSE AND r.DATY = rm.maxDateReport " +
                "LEFT JOIN  " +
                "(SELECT   " +
                "m.IDCAISSE,  " +
                "SUM(COALESCE(m.DEBIT, 0)) AS DEBIT,   " +
                "SUM(COALESCE(m.CREDIT, 0)) AS CREDIT   " +
                "FROM   " +
                "MVTCAISSE m  " +
                "JOIN  " +
                "(SELECT   " +
                "r.IDCAISSE,  " +
                "MAX(r.DATY) AS maxDateReport  " +
                "FROM   " +
                "REPORTCAISSE r   " +
                "WHERE   " +
                "r.ETAT = 11   " +
                "AND r.DATY <= '" + Utilitaire.datetostring(dateMin) + "'  " +
                "GROUP BY r.IDCAISSE  " +
                ") rm ON m.IDCAISSE = rm.IDCAISSE " +
                "WHERE   " +
                "m.DATY > rm.maxDateReport  " +
                "AND m.DATY <= '" + Utilitaire.datetostring(dateMax) + "'  " +
                "GROUP BY m.IDCAISSE  " +
                ") mvt ON r.IDCAISSE = mvt.IDCAISSE  " +
                "LEFT JOIN caisse c ON r.IDCAISSE = c.ID  " +
                "LEFT JOIN typecaisse tc ON c.IDTYPECAISSE = tc.ID  " +
                "WHERE   " +
                "r.ETAT = 11";
        return query;
    }


    public EtatCaisse[] caculEtatCaisse() throws Exception {
        String query = this.generateQueryCore(Utilitaire.stringDate(this.getDatyMin()),
                Utilitaire.stringDate(this.getDatyMin()));
        if (this.getIdCaisse() != null) {
            query = query + " and r.IDCAISSE = '"+this.getIdCaisse()+"'";
        }

        EtatCaisse[] etatCaisse = (EtatCaisse[]) CGenUtil.rechercher(new EtatCaisse(), query);
        return etatCaisse;
    }

    public String getIdCaisse() {
        return idCaisse;
    }

}
