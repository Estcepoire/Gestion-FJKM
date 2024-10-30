package ligneCredit;

import java.sql.Connection;

import bean.ClassEtat;

public class LigneCredit extends ClassEtat {
    String id;

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
        this.preparePk("LIGNE", "GET_SEQMAGASIN");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

}
