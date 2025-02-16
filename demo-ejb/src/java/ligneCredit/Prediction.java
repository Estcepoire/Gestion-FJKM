package ligneCredit;

import bean.AdminGen;
import bean.ClassMAPTable;

public class Prediction extends ClassMAPTable {

    String id;
    int annee;
    String val;
    double montant;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    public Prediction() {
        this.setNomTable("recette_depense_par_annee");
    }

    public double moyenne(Prediction[] p) {
        double somme = AdminGen.calculSommeDouble(p, "montant");
        return somme / p.length;
    }

    public double ecartype(Prediction[] p) {
        double sommeCarres = 0.0;
        double moyenne = this.moyenne(p);
        for (int i = 0; i < p.length; i++) {
            sommeCarres += Math.pow(p[i].getMontant() - moyenne, 2);
        }
        double variance = sommeCarres / (p.length - 1);
        return Math.sqrt(variance);
    }

    // public double valeurCritique(double alpha) {
    // NormalDistribution normalDist = new NormalDistribution();
    // return normalDist.inverseCumulativeProbability(1 - alpha / 2);
    // }

    public double valeurCritique(double alpha) {
        double p = 1 - alpha / 2;

        if (p <= 0 || p >= 1) {
            throw new IllegalArgumentException("La probabilite p doit être dans l'intervalle (0,1)");
        }

        double[] c = { 2.515517, 0.802853, 0.010328 };
        double[] d = { 1.432788, 0.189269, 0.001308 };

        boolean lowerHalf = p < 0.5;
        if (!lowerHalf) {
            p = 1 - p;
        }

        double t = Math.sqrt(-2.0 * Math.log(p));

        double numerator = ((c[2] * t + c[1]) * t) + c[0];
        double denominator = (((d[2] * t + d[1]) * t + d[0]) * t) + 1.0;
        double z = t - numerator / denominator;

        return lowerHalf ? -z : z;
    }

    public Prediction(String id, int annee, String val, double montant) {
        this.id = id;
        this.annee = annee;
        this.montant = montant;
        this.val = val;
    }

    public Prediction[] donnees() {
        Prediction[] p = new Prediction[35];
        double[] depenses = {
                36000000, 70500000, 57000000, 65500000, 30000000, 53000000, 69000000,
                51000000, 58000000, 46000000, 60000000, 39000000, 64000000, 55000000,
                49000000, 71000000, 48000000, 67000000, 59000000, 62000000, 44000000,
                52000000, 66000000, 35000000, 54000000, 68000000, 47000000, 56000000,
                61000000, 50000000, 63000000, 42000000, 70000000, 45000000, 55500000
        };
        int anneeDepart = 1988;
        for (int i = 0; i < depenses.length; i++) {
            String id = "LC0001" + (i + 1);
            int annee = anneeDepart + i;
            String val = "";
            double montant = depenses[i];
            p[i] = new Prediction(id, annee, val, montant);
        }
        return p;
    }

    public double[] algo(double alpha, Prediction[] p) {
        double ecartType = this.ecartype(p);
        double moyenne = this.moyenne(p);
        double z = this.valeurCritique(alpha);
        double SE_moyenne = ecartType / Math.sqrt(p.length);
        // Moyenne
        double margeErreurMoyenne = z * SE_moyenne;
        double borneInferieureMoyenne = moyenne - margeErreurMoyenne;
        double borneSuperieureMoyenne = moyenne + margeErreurMoyenne;
        double SE_prediction = ecartType * Math.sqrt(1 + 1.0 / p.length);
        double margeErreurPrediction = z * SE_prediction;
        // Prediction
        double borneInferieurePrediction = moyenne - margeErreurPrediction;
        double borneSuperieurePrediction = moyenne + margeErreurPrediction;

        return new double[] { borneInferieurePrediction, borneSuperieurePrediction, borneInferieureMoyenne,
                borneSuperieureMoyenne, moyenne };
    }

}
