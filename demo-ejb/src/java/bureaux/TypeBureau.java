package bureaux;

import java.sql.Connection;

import bean.TypeObjet;

public class TypeBureau extends TypeObjet{

    public TypeBureau(){
        this.setNomTable("typebureaux");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TYB", "get_seq_type_bureaux");
        this.setId( this.makePK(c) );
    }
    
}