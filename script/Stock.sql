CREATE TABLE TYPEMAGASIN(
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    val VARCHAR(250),
    desce VARCHAR(250)
);

CREATE OR REPLACE SEQUENCE SEQTYPEMAGASIN
    START WITH 1 
    INCREMENT BY 1  
    MINVALUE 1 
    NO MAXVALUE 
    CACHE 1; 

CREATE OR REPLACE FUNCTION public.GET_SEQTYPEMAGASIN()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN (SELECT nextval('SEQTYPEMAGASIN'));
END
$function$
;
--

CREATE TABLE MAGASIN(
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    val VARCHAR(250),
    desce VARCHAR(250),
    etat NUMBER(30,0) NOT NULL DEFAULT 0,
    idTypeMagasin VARCHAR(50) REFERENCES TYPEMAGASIN(id)
);

CREATE OR REPLACE SEQUENCE SEQMAGASIN
    START WITH 1 
    INCREMENT BY 1  
    MINVALUE 1 
    NO MAXVALUE 
    CACHE 1; 

CREATE OR REPLACE FUNCTION public.GET_SEQMAGASIN()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN (SELECT nextval('SEQMAGASIN'));
END
$function$
;

--
CREATE TABLE TYPEMVTSTOCK(
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    val VARCHAR(250),
    desce VARCHAR(250)
);

CREATE OR REPLACE SEQUENCE SEQTYPEMVTSTOCK
    START WITH 1 
    INCREMENT BY 1  
    MINVALUE 1 
    NO MAXVALUE 
    CACHE 1; 

CREATE OR REPLACE FUNCTION public.GET_SEQTYPEMVTSTOCK()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN (SELECT nextval('SEQTYPEMVTSTOCK'));
END
$function$
;

--
CREATE TABLE TRANSFERT(
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    designation VARCHAR(250),
    daty DATE DEFAULT NOW() NOT NULL,
    etat NUMBER(30,0) NOT NULL DEFAULT 0,
    idMagasinDepart VARCHAR(50) REFERENCES MAGASIN(id) NOT NULL,
    idMagasinArrive VARCHAR(50) REFERENCES MAGASIN(id) NOT NULL,
    CONSTRAINT check_magasin_diff CHECK (idMagasinDepart <> idMagasinArrive)
);

CREATE OR REPLACE SEQUENCE SEQTRANSFERT
    START WITH 1 
    INCREMENT BY 1  
    MINVALUE 1 
    NO MAXVALUE 
    CACHE 1; 

CREATE OR REPLACE FUNCTION public.GET_SEQTRANSFERT()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN (SELECT nextval('SEQTRANSFERT'));
END
$function$
;

--
CREATE TABLE CONSOMMATION(
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    designation VARCHAR(250),
    Remarque VARCHAR(250),
    daty DATE NOT NULL DEFAULT NOW(),
    etat NUMBER(30,0) NOT NULL DEFAULT 0,
);

CREATE OR REPLACE SEQUENCE SEQCONSOMMATION
    START WITH 1 
    INCREMENT BY 1  
    MINVALUE 1 
    NO MAXVALUE 
    CACHE 1; 

CREATE OR REPLACE FUNCTION public.GET_SEQCONSOMMATION()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN (SELECT nextval('SEQCONSOMMATION'));
END
$function$
;

--
CREATE TABLE MVTSTOCK(
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    designation VARCHAR(250),
    remarque VARCHAR(250),
    daty DATE NOT NULL DEFAULT NOW(),
    etat NUMBER(30,0) NOT NULL DEFAULT 0,
    idTypeMmvtstock VARCHAR(50) REFERENCES TYPEMVTSTOCK(id) NOT NULL,
    idTransfert VARCHAR(50) REFERENCES TRANSFERT(id),
    idConsommation VARCHAR(50) REFERENCES CONSOMMATION(id),
    CONSTRAINT check_source CHECK (
        (idTransfert IS NOT NULL AND idConsommation IS NULL) OR 
        (idTransfert IS NULL AND idConsommation IS NOT NULL)
    )
);

CREATE OR REPLACE SEQUENCE SEQMVTSTOCK
    START WITH 1 
    INCREMENT BY 1  
    MINVALUE 1 
    NO MAXVALUE 
    CACHE 1; 

CREATE OR REPLACE FUNCTION public.GET_SEQMVTSTOCK()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN (SELECT nextval('SEQMVTSTOCK'));
END
$function$
;

--
CREATE TABLE TYPEPRODUIT(
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    val VARCHAR(250),
    desce VARCHAR(250)
);

CREATE OR REPLACE SEQUENCE SEQTYPEPRODUIT
    START WITH 1 
    INCREMENT BY 1  
    MINVALUE 1 
    NO MAXVALUE 
    CACHE 1; 

CREATE OR REPLACE FUNCTION public.GET_SEQTYPEPRODUIT()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN (SELECT nextval('SEQTYPEPRODUIT'));
END
$function$
;

--
CREATE TABLE UNITE(
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    val VARCHAR(250),
    desce VARCHAR(250)
);

CREATE OR REPLACE SEQUENCE SEQUNITE
    START WITH 1 
    INCREMENT BY 1  
    MINVALUE 1 
    NO MAXVALUE 
    CACHE 1; 

CREATE OR REPLACE FUNCTION public.GET_SEQUNITE()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN (SELECT nextval('SEQUNITE'));
END
$function$
;

CREATE TABLE PRODUIT(
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    val VARCHAR(250),
    desce VARCHAR(250),
    prixUnitaire NUMBER(38,2) NOT NULL,
    idUnite VARCHAR(50) REFERENCES UNITE(id) NOT NULL,
    idTypeProduit VARCHAR(50) REFERENCES TYPEPRODUIT (id) NOT NULL
);

CREATE OR REPLACE SEQUENCE SEQPRODUIT
    START WITH 1 
    INCREMENT BY 1
    MINVALUE 1 
    NO MAXVALUE 
    CACHE 1; 

CREATE OR REPLACE FUNCTION public.GET_SEQPRODUIT()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN (SELECT nextval('SEQPRODUIT'));
END
$function$
;

--
CREATE TABLE MVTSTOCKFILLE(
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    idMere VARCHAR(50) REFERENCES MVTSTOCK (id) NOT NULL,
    designation VARCHAR(250),
    remarque VARCHAR(250),
    daty DATE NOT NULL DEFAULT NOW(),
    etat NUMBER(30,0) NOT NULL DEFAULT 0,
    idProduit VARCHAR(50) REFERENCES PRODUIT(id),
    prixUnitaire NUMBER(38,2) NOT NULL,
    entree NUMBER(38,2) NOT NULL,
    sortie NUMBER(38,2) NOT NULL,
    quantites NUMBER(38,2) NOT NULL
);

CREATE OR REPLACE SEQUENCE SEQMVTSTOCKFILLE
    START WITH 1 
    INCREMENT BY 1  
    MINVALUE 1 
    NO MAXVALUE 
    CACHE 1; 

CREATE OR REPLACE FUNCTION public.GET_SEQMVTSTOCKFILLE()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN (SELECT nextval('SEQMVTSTOCKFILLE'));
END
$function$
;
