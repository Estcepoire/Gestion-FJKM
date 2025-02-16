package famille;

import java.sql.Date;

import bean.ClassMAPTable;

public class Mpivavaka extends ClassMAPTable {

    private String id;
    private String nom;
    private String prenom;
    private Date dateNaissance;
    private int sexe;
    private String lieuDeNaissance;
    private String contact;
    private String addresse;
    private String idFaritra;

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(Date dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public int getSexe() {
        return sexe;
    }

    public void setSexe(int sexe) {
        this.sexe = sexe;
    }

    public String getLieuDeNaissance() {
        return lieuDeNaissance;
    }

    public void setLieuDeNaissance(String lieuDeNaissance) {
        this.lieuDeNaissance = lieuDeNaissance;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getAddresse() {
        return addresse;
    }

    public void setAddresse(String addresse) {
        this.addresse = addresse;
    }

    public String getIdFaritra() {
        return idFaritra;
    }

    public void setIdFaritra(String idFaritra) {
        this.idFaritra = idFaritra;
    }

    public Mpivavaka() {
        this.setNomTable("mpivavaka");
    }

    @Override
    public String[] getMotCles() {
        String[] motCles = { "id", "nom", "prenom" };
        return motCles;
    }

    @Override
    public String[] getValMotCles() {
        String[] valMotCles = { "id", "nom", "prenom" };
        return valMotCles;
    }

}