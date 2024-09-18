package annexe.details;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ClassEtat;
import java.sql.Connection;

public class Unite  extends ClassMAPTable{
    String id, val, desce;

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

    public String getDesce() {
        return desce;
    }

    public void setDesce(String desce) {
        this.desce = desce;
    }
    public Unite() {
        this.setNomTable("UNITE");
    }
    
    @Override
     public void construirePK(Connection c) throws Exception {
        this.preparePk("UNIT", "GET_SEQUNITE");
        this.setId(makePK(c));
    }
    @Override
    public String getAttributIDName() {
        return "id";
    }
    @Override
    public String getTuppleID() {
        return this.getId();
    }
    
}
