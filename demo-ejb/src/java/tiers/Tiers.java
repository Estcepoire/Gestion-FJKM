package tiers;

import java.sql.Connection;

import bean.TypeObjet;

public class Tiers extends TypeObjet {
    String id, val, desc;

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

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Tiers() {
        this.setNomTable("tiers");
    }

    @Override
    public String[] getMotCles() {
        String[] motCles = { "id", "val" };
        return motCles;
    }

    @Override
    public String[] getValMotCles() {
        String[] valMotCles = { "val" };
        return valMotCles;
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
        this.preparePk("TIERS", "GET_SEQPRODUIT");
        this.setId(makePK(c));
    }

}
