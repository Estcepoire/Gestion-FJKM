--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-3)
-- Dumped by pg_dump version 15.4 (Debian 15.4-3)

-- Started on 2024-09-02 17:13:03 EAT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE fjkm;
--
-- TOC entry 3861 (class 1262 OID 506366)
-- Name: fjkm; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE fjkm WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';


ALTER DATABASE fjkm OWNER TO postgres;

\connect fjkm

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3862 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 361 (class 1255 OID 506367)
-- Name: actiondependante(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actiondependante(identite character varying, rep character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare tmp varchar; test varchar;
begin
	select string_agg(case
						when idmere = '' then null
						else idmere
						end, '-') into tmp
	from action
	where idfille = any (string_to_array(identite, '-'));

	if tmp is null then
		return rep;
	else
		select string_agg(unnest,'-') into test from unnest(string_to_array(tmp, '-'))
		where unnest = any (string_to_array(rep, '-'));
		if test is not null then
			return rep;
		end if;

		if rep is null then
			rep = tmp;
		else rep = rep||'-'||tmp;
		end if;

		return actionDependante(tmp, rep);
	end if;
end;
$$;


ALTER FUNCTION public.actiondependante(identite character varying, rep character varying) OWNER TO postgres;

--
-- TOC entry 369 (class 1255 OID 506368)
-- Name: basedependance(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.basedependance(idbase character varying, rep character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare tmp varchar; test varchar;
 begin
	 select string_agg(idfille, ',') into tmp
	 from baserelation
	 where idmere = any (string_to_array(idbase, ','));
	 if tmp is null then
		 return rep;
	 else
		select string_agg(unnest,',') into test from unnest(string_to_array(tmp, ','))
		where unnest = any (string_to_array(rep, ','));
		if test is not null then
			return rep;
		end if;
		 if rep is null then
			 rep = tmp;
		 else rep = rep||','||tmp;
		 end if;
		 return basedependance(tmp, rep);
	 end if;
 end;
 $$;


ALTER FUNCTION public.basedependance(idbase character varying, rep character varying) OWNER TO postgres;

--
-- TOC entry 375 (class 1255 OID 506369)
-- Name: basedependante(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.basedependante(idbase character varying, rep character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare tmp varchar; test varchar;
 begin
	 select string_agg(idmere, ',') into tmp
	 from baserelation
	 where idfille = any (string_to_array(idbase, ','));
	 if tmp is null then
		 return rep;
	 else
		select string_agg(unnest,',') into test from unnest(string_to_array(tmp, ','))
		where unnest = any (string_to_array(rep, ','));
		if test is not null then
			return rep;
		end if;
		 if rep is null then
			 rep = tmp;
		 else rep = rep||','||tmp;
		 end if;
		 return basedependante(tmp, rep);
	 end if;
 end;
 $$;


ALTER FUNCTION public.basedependante(idbase character varying, rep character varying) OWNER TO postgres;

--
-- TOC entry 395 (class 1255 OID 506370)
-- Name: constructabsence(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.constructabsence(utilisateur_ character varying) RETURNS TABLE(id date, absence double precision)
    LANGUAGE plpgsql
    AS $$
declare r record; datytmp date; nbrejourtmp float8; nbrejourtotal float8;
begin
	for r in (select *
				from absence where utilisateur = utilisateur_) loop
																datytmp:= r.datedebut;
																nbrejourtmp:= r.nombrejour;
																nbrejourtotal:=r.nombrejour;
																	loop
																		if isJourFerie(datytmp) = 1 then
																			datytmp:= datytmp + interval '1 day';
																			continue;
																		end if;
																		if nbrejourtmp <=  0 then
																			exit;
																		end if;
																		if nbrejourtmp < 1 then
																			id:=datytmp;
																			absence:= nbrejourtmp;
																			nbrejourtmp:=0;
																		else absence:=0;
																			id:=datytmp;
																			nbrejourtmp:= nbrejourtmp - 1;
																			datytmp:= datytmp + interval '1 day';
																		end if;
																		return next;
																	end loop;
																end loop;
end;
$$;


ALTER FUNCTION public.constructabsence(utilisateur_ character varying) OWNER TO postgres;

--
-- TOC entry 396 (class 1255 OID 506371)
-- Name: constructlistabsence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.constructlistabsence() RETURNS TABLE(id date, utilisateur character varying, jourperdu double precision)
    LANGUAGE plpgsql
    AS $$
declare r record; datytmp date; nbrejourtmp float8; nbrejourtotal float8;
begin
	for r in (select *
				from absence) loop
																datytmp:= r.datedebut;
																nbrejourtmp:= r.nombrejour;
																nbrejourtotal:=r.nombrejour;
																	loop
																		if isJourFerie(datytmp) = 1 then
																			datytmp:= datytmp + interval '1 day';
																			continue;
																		end if;
																		if nbrejourtmp <=  0 then
																			exit;
																		end if;
																		if nbrejourtmp < 1 then
																			id:=datytmp;
																			jourperdu := nbrejourtmp;
																			utilisateur:= r.utilisateur;
																			nbrejourtmp:=0;
																		else jourperdu:=1;
																			id:=datytmp;
																			utilisateur:= r.utilisateur;
																			nbrejourtmp:= nbrejourtmp - 1;
																			datytmp:= datytmp + interval '1 day';
																		end if;
																		return next;
																	end loop;
																end loop;
end;
$$;


ALTER FUNCTION public.constructlistabsence() OWNER TO postgres;

--
-- TOC entry 365 (class 1255 OID 506372)
-- Name: entitedependante(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.entitedependante(identite character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare rep varchar; entitefille varchar; actionDependante varchar;
begin
	actionDependante = actionDependante(identite, null);
	if actionDependante is not null and actionDependante != '' then
		rep = actionDependante;
		identite = actionDependante || '-' || identite;
	end if;

	entitefille = entitefille(identite, null);
	if entitefille is not null and entitefille != '' then
		if rep is not null then
			rep = rep || '-' || entitefille;
		else rep = entitefille;
		end if;
	end if;

	return rep;
end;
$$;


ALTER FUNCTION public.entitedependante(identite character varying) OWNER TO postgres;

--
-- TOC entry 367 (class 1255 OID 506373)
-- Name: entitefille(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.entitefille(identite character varying, rep character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare tmp varchar;
begin
	select string_agg(id, '-') into tmp
	from entite
	where idmere = any (string_to_array(identite, '-'));
	if tmp is null then
		return rep;
	else
		if rep is null then
			rep = tmp;
		else rep = rep||'-'||tmp;
		end if;
		return entitefille(tmp, rep);
	end if;
end;
$$;


ALTER FUNCTION public.entitefille(identite character varying, rep character varying) OWNER TO postgres;

--
-- TOC entry 381 (class 1255 OID 506374)
-- Name: entitefilleclass(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.entitefilleclass(identite character varying, rep character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare tmp varchar;
begin
	select string_agg(id, '-') into tmp
	from entite
	where idmere = any (string_to_array(identite, '-'))
	and idcategorieniveau = any(select id
								from categorieniveau
								where idniveau = 'CLASS' and lower(val) = lower('class'));
	if tmp is null then
		return rep;
	else
		if rep is null then
			rep = tmp;
		else rep = rep||'-'||tmp;
		end if;
		return entitefilleclass(tmp, rep);
	end if;
end;
$$;


ALTER FUNCTION public.entitefilleclass(identite character varying, rep character varying) OWNER TO postgres;

--
-- TOC entry 386 (class 1255 OID 506375)
-- Name: get_seq_absence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_absence() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seq_absence'));
END
$$;


ALTER FUNCTION public.get_seq_absence() OWNER TO postgres;

--
-- TOC entry 393 (class 1255 OID 506376)
-- Name: get_seq_article(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_article() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_Article'));
        END
    $$;


ALTER FUNCTION public.get_seq_article() OWNER TO postgres;

--
-- TOC entry 360 (class 1255 OID 506377)
-- Name: get_seq_caisse(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_caisse() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_CAISSE'));
        END
    $$;


ALTER FUNCTION public.get_seq_caisse() OWNER TO postgres;

--
-- TOC entry 362 (class 1255 OID 506378)
-- Name: get_seq_categorie(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_categorie() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_Categorie'));
        END
    $$;


ALTER FUNCTION public.get_seq_categorie() OWNER TO postgres;

--
-- TOC entry 366 (class 1255 OID 506379)
-- Name: get_seq_categorieavoirfc(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_categorieavoirfc() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_categorieavoirfc'));
        END
    $$;


ALTER FUNCTION public.get_seq_categorieavoirfc() OWNER TO postgres;

--
-- TOC entry 368 (class 1255 OID 506380)
-- Name: get_seq_categoriecaisse(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_categoriecaisse() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_CategorieCaisse'));
        END
    $$;


ALTER FUNCTION public.get_seq_categoriecaisse() OWNER TO postgres;

--
-- TOC entry 370 (class 1255 OID 506381)
-- Name: get_seq_configuration(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_configuration() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_CONFIGURATION'));
        END
    $$;


ALTER FUNCTION public.get_seq_configuration() OWNER TO postgres;

--
-- TOC entry 371 (class 1255 OID 506382)
-- Name: get_seq_connexion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_connexion() RETURNS integer
    LANGUAGE plpgsql
    AS $$ begin return (
select
	nextval('seq_connexion'));
end $$;


ALTER FUNCTION public.get_seq_connexion() OWNER TO postgres;

--
-- TOC entry 373 (class 1255 OID 506383)
-- Name: get_seq_couleurcombinaison(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_couleurcombinaison() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_CouleurCombinaison'));
        END
    $$;


ALTER FUNCTION public.get_seq_couleurcombinaison() OWNER TO postgres;

--
-- TOC entry 374 (class 1255 OID 506384)
-- Name: get_seq_couleurprimaire(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_couleurprimaire() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_CouleurPrimaire'));
        END
    $$;


ALTER FUNCTION public.get_seq_couleurprimaire() OWNER TO postgres;

--
-- TOC entry 376 (class 1255 OID 506385)
-- Name: get_seq_couleurprimairecombinaison(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_couleurprimairecombinaison() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_CouleurPrimaireCombinaison'));
        END
    $$;


ALTER FUNCTION public.get_seq_couleurprimairecombinaison() OWNER TO postgres;

--
-- TOC entry 377 (class 1255 OID 506386)
-- Name: get_seq_enregistrementproduit(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_enregistrementproduit() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_enregistrementProduit'));
        END
    $$;


ALTER FUNCTION public.get_seq_enregistrementproduit() OWNER TO postgres;

--
-- TOC entry 378 (class 1255 OID 506387)
-- Name: get_seq_enregitrementprodfille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_enregitrementprodfille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_enregistrementprdtfille'));
        END
    $$;


ALTER FUNCTION public.get_seq_enregitrementprodfille() OWNER TO postgres;

--
-- TOC entry 380 (class 1255 OID 506388)
-- Name: get_seq_entitescript(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_entitescript() RETURNS integer
    LANGUAGE plpgsql
    AS $$
		BEGIN
		RETURN (SELECT nextval('seq_entitescript'));
		END
		$$;


ALTER FUNCTION public.get_seq_entitescript() OWNER TO postgres;

--
-- TOC entry 364 (class 1255 OID 506389)
-- Name: get_seq_genre(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_genre() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_Genre'));
        END
    $$;


ALTER FUNCTION public.get_seq_genre() OWNER TO postgres;

--
-- TOC entry 397 (class 1255 OID 506390)
-- Name: get_seq_historiqueprix(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_historiqueprix() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_HistoriquePrix'));
        END
    $$;


ALTER FUNCTION public.get_seq_historiqueprix() OWNER TO postgres;

--
-- TOC entry 398 (class 1255 OID 506391)
-- Name: get_seq_jourrepos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_jourrepos() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seq_jourrepos'));
END
$$;


ALTER FUNCTION public.get_seq_jourrepos() OWNER TO postgres;

--
-- TOC entry 399 (class 1255 OID 506392)
-- Name: get_seq_modele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_modele() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_Modele'));
        END
    $$;


ALTER FUNCTION public.get_seq_modele() OWNER TO postgres;

--
-- TOC entry 400 (class 1255 OID 506393)
-- Name: get_seq_modeledispo(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_modeledispo() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_ModeleDispo'));
        END
    $$;


ALTER FUNCTION public.get_seq_modeledispo() OWNER TO postgres;

--
-- TOC entry 401 (class 1255 OID 506394)
-- Name: get_seq_motifavoirfc(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_motifavoirfc() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_motifavoirfc'));
        END
    $$;


ALTER FUNCTION public.get_seq_motifavoirfc() OWNER TO postgres;

--
-- TOC entry 402 (class 1255 OID 506395)
-- Name: get_seq_mouvementcaisse(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_mouvementcaisse() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_MOUVEMENTCAISSE'));
        END
    $$;


ALTER FUNCTION public.get_seq_mouvementcaisse() OWNER TO postgres;

--
-- TOC entry 403 (class 1255 OID 506396)
-- Name: get_seq_notification(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_notification() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seq_notification'));
END
$$;


ALTER FUNCTION public.get_seq_notification() OWNER TO postgres;

--
-- TOC entry 404 (class 1255 OID 506397)
-- Name: get_seq_notificationsignal(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_notificationsignal() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seq_notificationSignal'));
END
$$;


ALTER FUNCTION public.get_seq_notificationsignal() OWNER TO postgres;

--
-- TOC entry 405 (class 1255 OID 506398)
-- Name: get_seq_paiementfacture(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_paiementfacture() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seq_paiement'));
END
$$;


ALTER FUNCTION public.get_seq_paiementfacture() OWNER TO postgres;

--
-- TOC entry 406 (class 1255 OID 506399)
-- Name: get_seq_reportcaisse(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_reportcaisse() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_REPORTCAISSE'));
        END
    $$;


ALTER FUNCTION public.get_seq_reportcaisse() OWNER TO postgres;

--
-- TOC entry 407 (class 1255 OID 506400)
-- Name: get_seq_script(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_script() RETURNS integer
    LANGUAGE plpgsql
    AS $$
		BEGIN
		RETURN (SELECT nextval('seq_script'));
		END
		$$;


ALTER FUNCTION public.get_seq_script() OWNER TO postgres;

--
-- TOC entry 408 (class 1255 OID 506401)
-- Name: get_seq_scriptversionning(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_scriptversionning() RETURNS integer
    LANGUAGE plpgsql
    AS $$
		BEGIN
		RETURN (SELECT nextval('seq_scriptversionning'));
		END
		$$;


ALTER FUNCTION public.get_seq_scriptversionning() OWNER TO postgres;

--
-- TOC entry 409 (class 1255 OID 506402)
-- Name: get_seq_taille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_taille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_Taille'));
        END
    $$;


ALTER FUNCTION public.get_seq_taille() OWNER TO postgres;

--
-- TOC entry 410 (class 1255 OID 506403)
-- Name: get_seq_taillegenre(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_taillegenre() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_TailleGenre'));
        END
    $$;


ALTER FUNCTION public.get_seq_taillegenre() OWNER TO postgres;

--
-- TOC entry 411 (class 1255 OID 506404)
-- Name: get_seq_tempstravail(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_tempstravail() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seq_tempstravail'));
END
$$;


ALTER FUNCTION public.get_seq_tempstravail() OWNER TO postgres;

--
-- TOC entry 412 (class 1255 OID 506405)
-- Name: get_seq_typecaisse(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_typecaisse() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_TypeCaisse'));
        END
    $$;


ALTER FUNCTION public.get_seq_typecaisse() OWNER TO postgres;

--
-- TOC entry 372 (class 1255 OID 506406)
-- Name: get_seq_typescript(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_typescript() RETURNS integer
    LANGUAGE plpgsql
    AS $$
		BEGIN
		RETURN (SELECT nextval('seq_typescript'));
		END
		$$;


ALTER FUNCTION public.get_seq_typescript() OWNER TO postgres;

--
-- TOC entry 413 (class 1255 OID 506407)
-- Name: get_seq_userhomepage(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_userhomepage() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_USERHOMEPAGE'));
        END
    $$;


ALTER FUNCTION public.get_seq_userhomepage() OWNER TO postgres;

--
-- TOC entry 414 (class 1255 OID 506408)
-- Name: get_seq_virementintracaisse(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seq_virementintracaisse() RETURNS integer
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN (SELECT nextval('seq_VIREMENTINTRACAISSE'));
        END
    $$;


ALTER FUNCTION public.get_seq_virementintracaisse() OWNER TO postgres;

--
-- TOC entry 415 (class 1255 OID 506409)
-- Name: get_seqattacher_fichier(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seqattacher_fichier() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqattacher_fichier'));
END
$$;


ALTER FUNCTION public.get_seqattacher_fichier() OWNER TO postgres;

--
-- TOC entry 416 (class 1255 OID 506410)
-- Name: get_seqbranche(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seqbranche() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqbranche'));
END
$$;


ALTER FUNCTION public.get_seqbranche() OWNER TO postgres;

--
-- TOC entry 417 (class 1255 OID 506411)
-- Name: get_seqclient(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seqclient() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqclient'));
END
$$;


ALTER FUNCTION public.get_seqclient() OWNER TO postgres;

--
-- TOC entry 418 (class 1255 OID 506412)
-- Name: get_seqexecution_script(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seqexecution_script() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqEXECUTION_SCRIPT'));
END
$$;


ALTER FUNCTION public.get_seqexecution_script() OWNER TO postgres;

--
-- TOC entry 419 (class 1255 OID 506413)
-- Name: get_seqexecution_scriptfille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seqexecution_scriptfille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqEXECUTION_SCRIPTFILLE'));
END
$$;


ALTER FUNCTION public.get_seqexecution_scriptfille() OWNER TO postgres;

--
-- TOC entry 420 (class 1255 OID 506414)
-- Name: get_seqfonctionnalite(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seqfonctionnalite() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqfonctionnalite'));
END
$$;


ALTER FUNCTION public.get_seqfonctionnalite() OWNER TO postgres;

--
-- TOC entry 421 (class 1255 OID 506415)
-- Name: get_seqpage(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seqpage() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqpage'));
END
$$;


ALTER FUNCTION public.get_seqpage() OWNER TO postgres;

--
-- TOC entry 422 (class 1255 OID 506416)
-- Name: get_seqpiecejointe(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seqpiecejointe() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqpieceJointe'));
END
$$;


ALTER FUNCTION public.get_seqpiecejointe() OWNER TO postgres;

--
-- TOC entry 423 (class 1255 OID 506417)
-- Name: get_seqprojet(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seqprojet() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqprojet'));
END
$$;


ALTER FUNCTION public.get_seqprojet() OWNER TO postgres;

--
-- TOC entry 424 (class 1255 OID 506418)
-- Name: get_seqscript_projet(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seqscript_projet() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqscript_projet'));
END
$$;


ALTER FUNCTION public.get_seqscript_projet() OWNER TO postgres;

--
-- TOC entry 425 (class 1255 OID 506419)
-- Name: get_seqtachemere(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seqtachemere() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqtacheMere'));
END
$$;


ALTER FUNCTION public.get_seqtachemere() OWNER TO postgres;

--
-- TOC entry 426 (class 1255 OID 506420)
-- Name: get_seqtypefichier(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_seqtypefichier() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqtypeFichier'));
END
$$;


ALTER FUNCTION public.get_seqtypefichier() OWNER TO postgres;

--
-- TOC entry 427 (class 1255 OID 506421)
-- Name: getcategorieniveau(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getcategorieniveau() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seqcategorieniveau'));
END
$$;


ALTER FUNCTION public.getcategorieniveau() OWNER TO postgres;

--
-- TOC entry 430 (class 1255 OID 506422)
-- Name: getheuresup(date, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getheuresup(daty_ date, debut_ timestamp without time zone, fin_ timestamp without time zone) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
	declare rep float8;
			dmatin time;
			fmatin time;
			dapresmidi time;
			fapresmidi time;
			refs time;
			refsdebut timestamp;
			refsfin timestamp;
			dmatinref timestamp;
			fmatinref timestamp;
			dapresmidiref timestamp;
			fapresmidiref timestamp;
			tmp timestamp;
begin
	select cast(debutmatin as time), cast(finmatin as time), cast(debutapresmidi as time), cast(finapresmidi as time) into dmatin, fmatin, dapresmidi, fapresmidi
				from tempstravail t where id in(
					select max(id) from "tempstravail" c where daty in (
						select max(daty) from tempstravail where daty<=daty_));
	rep = 0;
	if debut_>=fin_ then
		return rep;
	end if;

	if cast(debut_ as time) >= fapresmidi and cast(fin_ as time) >= fapresmidi and date(debut_) = date(fin_) then
		rep = rep + date_part('epoch'::text, fin_ - debut_)/60;
	elsif cast(debut_ as time) >= fapresmidi and cast(fin_ as time) <= dmatin and date(fin_) = (date(debut_) + '1 day'::interval) then
		rep = rep + date_part('epoch'::text, '24:00'::time - cast(debut_ as time))/60 + date_part('epoch'::text, cast(fin_ as time) - '00:00'::time) /60;
	elsif cast(debut_ as time) <= dmatin and cast(fin_ as time) <= dmatin and date(debut_) = date(fin_) then
	 		rep = rep + date_part('epoch'::text, fin_ - debut_)/60;
	elsif cast(debut_ as time) >= fmatin and cast(debut_ as time) <= dapresmidi and cast(fin_ as time) >= fmatin and cast(fin_ as time) <= dapresmidi and date(debut_) = date(fin_) then
			rep = rep + date_part('epoch'::text, fin_ - debut_)/60;
	else
		refs = cast(debut_ as time);
		refsdebut = date(debut_);
		if refs = dmatin or refs = fmatin or refs = dapresmidi or refs = fapresmidi then
			refsdebut = debut_;
		else
			if refs>=fapresmidi or refs<=dmatin then
				if refs<='24:00'::time and refs>=fapresmidi then
					rep = rep + date_part('epoch'::text, '24:00'::time - refs)/60;
					refs = '00:00'::time;
					refsdebut = refsdebut  + '1 day'::interval;
				end if;
				if refs<=dmatin and refs>='00:00'::time then
					rep = rep + date_part('epoch'::text, dmatin - refs)/60;
					refsdebut = refsdebut + dmatin;
				end if;
			end if;
			if refs>=fmatin and refs<=dapresmidi then
				if refs != dapresmidi then
					rep = rep + date_part('epoch'::text, dapresmidi - refs)/60;
				end if;
				refsdebut = refsdebut + dapresmidi;
			end if;
			if refs>=dmatin and refs<=fmatin then
				refsdebut = refsdebut + fmatin;
			end if;
			if refs>=dapresmidi and refs<=fapresmidi then
				refsdebut = refsdebut + fapresmidi;
			end if;
		end if;

		refs = cast (fin_ as time);
		refsfin = date(fin_);
		if refs>=fapresmidi or refs<=dmatin then
			if refs<=dmatin and refs>='00:00'::time then
				rep = rep + date_part('epoch'::text, refs - '00:00'::time)/60;
				refs = '24:00'::time;
				refsfin = refsfin - '1 day'::interval;
			end if;
			if refs<='24:00'::time and refs>=fapresmidi then
				rep = rep + date_part('epoch'::text, refs - fapresmidi)/60;
				refsfin = refsfin + fapresmidi;
			end if;
		end if;
		if refs>=fmatin and refs<=dapresmidi then
			if refs != dapresmidi then
				rep = rep + date_part('epoch'::text, refs - fmatin)/60;
			end if;
			refsfin = refsfin + fmatin;
		end if;
		if refs>=dmatin and refs<=fmatin then
			refsfin = refsfin + dmatin;
		end if;
		if refs>=dapresmidi and refs<=fapresmidi then
			refsfin = refsfin + dapresmidi;
		end if;

		tmp = date(refsdebut);
		loop
				if date(refsfin) < tmp then
					exit;
				end if;
				dmatinref = tmp::timestamp + dmatin;
				fmatinref = tmp::timestamp + fmatin;
				dapresmidiref = tmp::timestamp + dapresmidi;
				fapresmidiref = tmp::timestamp + fapresmidi;
				if fmatinref>=refsdebut and dapresmidiref<=refsfin then
					rep = rep + date_part('epoch'::text, dapresmidiref - fmatinref)/60;
				end if;
				if fapresmidiref>=refsdebut and ((date(fapresmidiref) + '1 day'::interval)::timestamp + dmatin)<=refsfin then
					rep = rep + date_part('epoch'::text, ((date(fapresmidiref) + '1 day'::interval)::timestamp + dmatin) - fapresmidiref)/60;
				end if;
				tmp = tmp + '1 day'::interval;
		end loop;
	end if;

	return rep;
end;
$$;


ALTER FUNCTION public.getheuresup(daty_ date, debut_ timestamp without time zone, fin_ timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 431 (class 1255 OID 506423)
-- Name: getheuretravailmax(date, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getheuretravailmax(daty_ date, unite character varying) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
	declare rep float8;
			dmatin time;
			fmatin time;
			dapresmidi time;
			fapresmidi time;

begin
	select cast(debutmatin as time), cast(finmatin as time), cast(debutapresmidi as time), cast(finapresmidi as time) into dmatin, fmatin, dapresmidi, fapresmidi
				from tempstravail t where id in(
					select max(id) from "tempstravail" c where daty in (
						select max(daty) from tempstravail where daty<=daty_));
	rep = 0;
	rep = (date_part('epoch'::text, fmatin - dmatin)/60) + date_part('epoch'::text, fapresmidi - dapresmidi)/60;

	if unite = 'h' then
		rep = rep/60;
	end if;
	return rep;
end;
$$;


ALTER FUNCTION public.getheuretravailmax(daty_ date, unite character varying) OWNER TO postgres;

--
-- TOC entry 432 (class 1255 OID 506424)
-- Name: getseq_attacher_fichier(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseq_attacher_fichier() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqattacher_fichier'));
END
$$;


ALTER FUNCTION public.getseq_attacher_fichier() OWNER TO postgres;

--
-- TOC entry 433 (class 1255 OID 506425)
-- Name: getseqaction(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqaction() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seqaction'));
END
$$;


ALTER FUNCTION public.getseqaction() OWNER TO postgres;

--
-- TOC entry 434 (class 1255 OID 506426)
-- Name: getseqactiontache(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqactiontache() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seqactionTache'));
END
$$;


ALTER FUNCTION public.getseqactiontache() OWNER TO postgres;

--
-- TOC entry 435 (class 1255 OID 506427)
-- Name: getseqarchitecture(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqarchitecture() RETURNS integer
    LANGUAGE plpgsql
    AS $$
 BEGIN
 RETURN (SELECT nextval('seqarchitecture'));
 END
 $$;


ALTER FUNCTION public.getseqarchitecture() OWNER TO postgres;

--
-- TOC entry 436 (class 1255 OID 506428)
-- Name: getseqas_bondecommandeclient(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqas_bondecommandeclient() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqas_bondecommandeclient'));
END
$$;


ALTER FUNCTION public.getseqas_bondecommandeclient() OWNER TO postgres;

--
-- TOC entry 437 (class 1255 OID 506429)
-- Name: getseqas_bondecommandeclient_fille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqas_bondecommandeclient_fille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqas_bondecommandeclient'));
END
$$;


ALTER FUNCTION public.getseqas_bondecommandeclient_fille() OWNER TO postgres;

--
-- TOC entry 438 (class 1255 OID 506430)
-- Name: getseqas_bondelivraisonclientclient(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqas_bondelivraisonclientclient() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqas_bondelivraisonclientclient'));
END
$$;


ALTER FUNCTION public.getseqas_bondelivraisonclientclient() OWNER TO postgres;

--
-- TOC entry 439 (class 1255 OID 506431)
-- Name: getseqas_bondelivraisonclientclient_fille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqas_bondelivraisonclientclient_fille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqas_bondelivraisonclientclient_fille'));
END
$$;


ALTER FUNCTION public.getseqas_bondelivraisonclientclient_fille() OWNER TO postgres;

--
-- TOC entry 428 (class 1255 OID 506432)
-- Name: getseqavoirfc(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqavoirfc() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqavoirfc'));
END
$$;


ALTER FUNCTION public.getseqavoirfc() OWNER TO postgres;

--
-- TOC entry 429 (class 1255 OID 506433)
-- Name: getseqavoirfcfille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqavoirfcfille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqavoirfcfille'));
END
$$;


ALTER FUNCTION public.getseqavoirfcfille() OWNER TO postgres;

--
-- TOC entry 363 (class 1255 OID 506434)
-- Name: getseqbase(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqbase() RETURNS integer
    LANGUAGE plpgsql
    AS $$
 BEGIN
 RETURN (SELECT nextval('seqbase'));
 END
 $$;


ALTER FUNCTION public.getseqbase() OWNER TO postgres;

--
-- TOC entry 440 (class 1255 OID 506435)
-- Name: getseqbaserelation(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqbaserelation() RETURNS integer
    LANGUAGE plpgsql
    AS $$
 BEGIN
 RETURN (SELECT nextval('seqbaserelation'));
 END
 $$;


ALTER FUNCTION public.getseqbaserelation() OWNER TO postgres;

--
-- TOC entry 441 (class 1255 OID 506436)
-- Name: getseqboncommande(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqboncommande() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQBONCOMMANDE'));
END
$$;


ALTER FUNCTION public.getseqboncommande() OWNER TO postgres;

--
-- TOC entry 442 (class 1255 OID 506437)
-- Name: getseqbondecommandefille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqbondecommandefille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQBONDECOMMANDEFILLE'));
END
$$;


ALTER FUNCTION public.getseqbondecommandefille() OWNER TO postgres;

--
-- TOC entry 443 (class 1255 OID 506438)
-- Name: getseqbondelivraison(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqbondelivraison() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQBONDELIVRAISON'));
END
$$;


ALTER FUNCTION public.getseqbondelivraison() OWNER TO postgres;

--
-- TOC entry 444 (class 1255 OID 506439)
-- Name: getseqbondelivraisonfille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqbondelivraisonfille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SeqBondeLivraisonFille'));
END
$$;


ALTER FUNCTION public.getseqbondelivraisonfille() OWNER TO postgres;

--
-- TOC entry 445 (class 1255 OID 506440)
-- Name: getseqbranche(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqbranche() RETURNS integer
    LANGUAGE plpgsql
    AS $$
		BEGIN
		RETURN (SELECT nextval('seq_branche'));
		END
		$$;


ALTER FUNCTION public.getseqbranche() OWNER TO postgres;

--
-- TOC entry 446 (class 1255 OID 506441)
-- Name: getseqcategorie(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqcategorie() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN (SELECT nextval('Seqcategorie'));
END;
$$;


ALTER FUNCTION public.getseqcategorie() OWNER TO postgres;

--
-- TOC entry 447 (class 1255 OID 506442)
-- Name: getseqclasse(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqclasse() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seq_classe'));
END
$$;


ALTER FUNCTION public.getseqclasse() OWNER TO postgres;

--
-- TOC entry 448 (class 1255 OID 506443)
-- Name: getseqclient(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqclient() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqclient'));
END
$$;


ALTER FUNCTION public.getseqclient() OWNER TO postgres;

--
-- TOC entry 449 (class 1255 OID 506444)
-- Name: getseqcloturecaisse(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqcloturecaisse() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqcloturecaisse'));
END
$$;


ALTER FUNCTION public.getseqcloturecaisse() OWNER TO postgres;

--
-- TOC entry 450 (class 1255 OID 506445)
-- Name: getseqcnapsuser(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqcnapsuser() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQCNAPSUSER'));
END
$$;


ALTER FUNCTION public.getseqcnapsuser() OWNER TO postgres;

--
-- TOC entry 451 (class 1255 OID 506446)
-- Name: getseqconception_pm(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqconception_pm() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seq_Conception_PM'));
END
$$;


ALTER FUNCTION public.getseqconception_pm() OWNER TO postgres;

--
-- TOC entry 452 (class 1255 OID 506447)
-- Name: getseqcote(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqcote() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN (SELECT nextval('SeqCote'));
END;
$$;


ALTER FUNCTION public.getseqcote() OWNER TO postgres;

--
-- TOC entry 453 (class 1255 OID 506448)
-- Name: getseqcreation_projet(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqcreation_projet() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN (SELECT nextval('SeqCreation_projet'));
END;
$$;


ALTER FUNCTION public.getseqcreation_projet() OWNER TO postgres;

--
-- TOC entry 454 (class 1255 OID 506449)
-- Name: getseqdeploiement(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqdeploiement() RETURNS integer
    LANGUAGE plpgsql
    AS $$
		BEGIN
		RETURN (SELECT nextval('seq_deploiement'));
		END
		$$;


ALTER FUNCTION public.getseqdeploiement() OWNER TO postgres;

--
-- TOC entry 455 (class 1255 OID 506450)
-- Name: getseqdevise(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqdevise() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQDEVISE'));
END
$$;


ALTER FUNCTION public.getseqdevise() OWNER TO postgres;

--
-- TOC entry 456 (class 1255 OID 506451)
-- Name: getseqentite(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqentite() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seqentite'));
END
$$;


ALTER FUNCTION public.getseqentite() OWNER TO postgres;

--
-- TOC entry 457 (class 1255 OID 506452)
-- Name: getseqfactureclient(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqfactureclient() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqfactureclient'));
END
$$;


ALTER FUNCTION public.getseqfactureclient() OWNER TO postgres;

--
-- TOC entry 458 (class 1255 OID 506453)
-- Name: getseqfactureclientfille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqfactureclientfille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqfactureclientfille'));
END
$$;


ALTER FUNCTION public.getseqfactureclientfille() OWNER TO postgres;

--
-- TOC entry 459 (class 1255 OID 506454)
-- Name: getseqfacturefournisseur(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqfacturefournisseur() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQFACTUREFOURNISSEUR'));
END
$$;


ALTER FUNCTION public.getseqfacturefournisseur() OWNER TO postgres;

--
-- TOC entry 460 (class 1255 OID 506455)
-- Name: getseqfacturefournisseurfille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqfacturefournisseurfille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQFACTUREFOURNISSEURFILLE'));
END
$$;


ALTER FUNCTION public.getseqfacturefournisseurfille() OWNER TO postgres;

--
-- TOC entry 461 (class 1255 OID 506456)
-- Name: getseqfonctionnalite(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqfonctionnalite() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqfonctionnalite'));
END
$$;


ALTER FUNCTION public.getseqfonctionnalite() OWNER TO postgres;

--
-- TOC entry 462 (class 1255 OID 506457)
-- Name: getseqhistorique(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqhistorique() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN (SELECT nextval('seqhistorique'));
END;
$$;


ALTER FUNCTION public.getseqhistorique() OWNER TO postgres;

--
-- TOC entry 463 (class 1255 OID 506458)
-- Name: getseqhistovaleur(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqhistovaleur() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN (SELECT nextval('seqhistovaleur'));
END;
$$;


ALTER FUNCTION public.getseqhistovaleur() OWNER TO postgres;

--
-- TOC entry 464 (class 1255 OID 506459)
-- Name: getseqinventaire(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqinventaire() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQINVENTAIRE'));
END
$$;


ALTER FUNCTION public.getseqinventaire() OWNER TO postgres;

--
-- TOC entry 465 (class 1255 OID 506460)
-- Name: getseqinventairefille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqinventairefille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQINVENTAIREFILLE'));
END
$$;


ALTER FUNCTION public.getseqinventairefille() OWNER TO postgres;

--
-- TOC entry 466 (class 1255 OID 506461)
-- Name: getseqjauge(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqjauge() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQJAUGE'));
END
$$;


ALTER FUNCTION public.getseqjauge() OWNER TO postgres;

--
-- TOC entry 467 (class 1255 OID 506462)
-- Name: getseqmagasin(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqmagasin() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQMAGASIN'));
END
$$;


ALTER FUNCTION public.getseqmagasin() OWNER TO postgres;

--
-- TOC entry 468 (class 1255 OID 506463)
-- Name: getseqmailcc(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqmailcc() RETURNS integer
    LANGUAGE plpgsql
    AS $$
 BEGIN
 RETURN (SELECT nextval('seqmailcc'));
 END
 $$;


ALTER FUNCTION public.getseqmailcc() OWNER TO postgres;

--
-- TOC entry 469 (class 1255 OID 506464)
-- Name: getseqmetier(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqmetier() RETURNS integer
    LANGUAGE plpgsql
    AS $$
 BEGIN
 RETURN (SELECT nextval('seqmetier'));
 END
 $$;


ALTER FUNCTION public.getseqmetier() OWNER TO postgres;

--
-- TOC entry 470 (class 1255 OID 506465)
-- Name: getseqmetierfille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqmetierfille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seq_MetierFille'));
END
$$;


ALTER FUNCTION public.getseqmetierfille() OWNER TO postgres;

--
-- TOC entry 471 (class 1255 OID 506466)
-- Name: getseqmetierrelation(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqmetierrelation() RETURNS integer
    LANGUAGE plpgsql
    AS $$
 BEGIN
 RETURN (SELECT nextval('seqmetierrelation'));
 END
 $$;


ALTER FUNCTION public.getseqmetierrelation() OWNER TO postgres;

--
-- TOC entry 472 (class 1255 OID 506467)
-- Name: getseqmodepaiement(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqmodepaiement() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQMODEPAIEMENT'));
END
$$;


ALTER FUNCTION public.getseqmodepaiement() OWNER TO postgres;

--
-- TOC entry 473 (class 1255 OID 506468)
-- Name: getseqmvtstock(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqmvtstock() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQMVTSTOCK'));
END
$$;


ALTER FUNCTION public.getseqmvtstock() OWNER TO postgres;

--
-- TOC entry 474 (class 1255 OID 506469)
-- Name: getseqmvtstockfille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqmvtstockfille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQMVTSTOCKFILLE'));
END
$$;


ALTER FUNCTION public.getseqmvtstockfille() OWNER TO postgres;

--
-- TOC entry 475 (class 1255 OID 506470)
-- Name: getseqniveau(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqniveau() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seqniveau'));
END
$$;


ALTER FUNCTION public.getseqniveau() OWNER TO postgres;

--
-- TOC entry 476 (class 1255 OID 506471)
-- Name: getseqnotificationaction(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqnotificationaction() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seqnotificationAction'));
END
$$;


ALTER FUNCTION public.getseqnotificationaction() OWNER TO postgres;

--
-- TOC entry 477 (class 1255 OID 506472)
-- Name: getseqpagerelation(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqpagerelation() RETURNS integer
    LANGUAGE plpgsql
    AS $$
 BEGIN
 RETURN (SELECT nextval('seqpagerelation'));
 END
 $$;


ALTER FUNCTION public.getseqpagerelation() OWNER TO postgres;

--
-- TOC entry 478 (class 1255 OID 506473)
-- Name: getseqpaiementfacturef(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqpaiementfacturef() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQpaiementfactureF'));
END
$$;


ALTER FUNCTION public.getseqpaiementfacturef() OWNER TO postgres;

--
-- TOC entry 479 (class 1255 OID 506474)
-- Name: getseqparamcrypt(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqparamcrypt() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQPARAMCRYPT'));
END
$$;


ALTER FUNCTION public.getseqparamcrypt() OWNER TO postgres;

--
-- TOC entry 480 (class 1255 OID 506475)
-- Name: getseqpoint(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqpoint() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQPOINT'));
END
$$;


ALTER FUNCTION public.getseqpoint() OWNER TO postgres;

--
-- TOC entry 481 (class 1255 OID 506476)
-- Name: getseqproduit(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqproduit() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQPRODUIT'));
END
$$;


ALTER FUNCTION public.getseqproduit() OWNER TO postgres;

--
-- TOC entry 482 (class 1255 OID 506477)
-- Name: getseqretourbl(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqretourbl() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqretourbl'));
END
$$;


ALTER FUNCTION public.getseqretourbl() OWNER TO postgres;

--
-- TOC entry 483 (class 1255 OID 506478)
-- Name: getseqretourblfille(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqretourblfille() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seqretourblfille'));
END
$$;


ALTER FUNCTION public.getseqretourblfille() OWNER TO postgres;

--
-- TOC entry 484 (class 1255 OID 506479)
-- Name: getseqroles(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqroles() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seq_roles'));
END
$$;


ALTER FUNCTION public.getseqroles() OWNER TO postgres;

--
-- TOC entry 485 (class 1255 OID 506480)
-- Name: getseqsource(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqsource() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seqsource'));
END
$$;


ALTER FUNCTION public.getseqsource() OWNER TO postgres;

--
-- TOC entry 486 (class 1255 OID 506481)
-- Name: getseqsouscategorie(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqsouscategorie() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQSOUSCATEGORIE'));
END
$$;


ALTER FUNCTION public.getseqsouscategorie() OWNER TO postgres;

--
-- TOC entry 487 (class 1255 OID 506482)
-- Name: getseqtache(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtache() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN (SELECT nextval('SeqTache'));
END;
$$;


ALTER FUNCTION public.getseqtache() OWNER TO postgres;

--
-- TOC entry 488 (class 1255 OID 506483)
-- Name: getseqtiers(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtiers() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQTIERS'));
END
$$;


ALTER FUNCTION public.getseqtiers() OWNER TO postgres;

--
-- TOC entry 489 (class 1255 OID 506484)
-- Name: getseqtransfertstock(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtransfertstock() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQTRANSFERTSTOCK'));
END
$$;


ALTER FUNCTION public.getseqtransfertstock() OWNER TO postgres;

--
-- TOC entry 490 (class 1255 OID 506485)
-- Name: getseqtransfertstockdetails(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtransfertstockdetails() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQTRANSFERTSTOCKDETAILS'));
END
$$;


ALTER FUNCTION public.getseqtransfertstockdetails() OWNER TO postgres;

--
-- TOC entry 379 (class 1255 OID 506486)
-- Name: getseqtype(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtype() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN (SELECT nextval('SeqType'));
END;
$$;


ALTER FUNCTION public.getseqtype() OWNER TO postgres;

--
-- TOC entry 491 (class 1255 OID 506487)
-- Name: getseqtype_produit(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtype_produit() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQTYPE_PRODUIT'));
END
$$;


ALTER FUNCTION public.getseqtype_produit() OWNER TO postgres;

--
-- TOC entry 492 (class 1255 OID 506488)
-- Name: getseqtypeabsence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtypeabsence() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seqtypeabsence'));
END
$$;


ALTER FUNCTION public.getseqtypeabsence() OWNER TO postgres;

--
-- TOC entry 493 (class 1255 OID 506489)
-- Name: getseqtypeaction(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtypeaction() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seqtypeaction'));
END
$$;


ALTER FUNCTION public.getseqtypeaction() OWNER TO postgres;

--
-- TOC entry 494 (class 1255 OID 506490)
-- Name: getseqtypeactionmetier(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtypeactionmetier() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('seq_typeactionmetier'));
END
$$;


ALTER FUNCTION public.getseqtypeactionmetier() OWNER TO postgres;

--
-- TOC entry 495 (class 1255 OID 506491)
-- Name: getseqtypebase(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtypebase() RETURNS integer
    LANGUAGE plpgsql
    AS $$
 BEGIN
 RETURN (SELECT nextval('seqtypebase'));
 END
 $$;


ALTER FUNCTION public.getseqtypebase() OWNER TO postgres;

--
-- TOC entry 496 (class 1255 OID 506492)
-- Name: getseqtypemagasin(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtypemagasin() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQTYPEMAGASIN'));
END
$$;


ALTER FUNCTION public.getseqtypemagasin() OWNER TO postgres;

--
-- TOC entry 497 (class 1255 OID 506493)
-- Name: getseqtypemetier(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtypemetier() RETURNS integer
    LANGUAGE plpgsql
    AS $$
 BEGIN
 RETURN (SELECT nextval('seqtypemetier'));
 END
 $$;


ALTER FUNCTION public.getseqtypemetier() OWNER TO postgres;

--
-- TOC entry 498 (class 1255 OID 506494)
-- Name: getseqtypemvtstock(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtypemvtstock() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQTYPEMVTSTOCK'));
END
$$;


ALTER FUNCTION public.getseqtypemvtstock() OWNER TO postgres;

--
-- TOC entry 499 (class 1255 OID 506495)
-- Name: getseqtypepage(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtypepage() RETURNS integer
    LANGUAGE plpgsql
    AS $$
 BEGIN
 RETURN (SELECT nextval('seqtypepage'));
 END
 $$;


ALTER FUNCTION public.getseqtypepage() OWNER TO postgres;

--
-- TOC entry 500 (class 1255 OID 506496)
-- Name: getseqtyperemise(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtyperemise() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQtyperemise'));
END
$$;


ALTER FUNCTION public.getseqtyperemise() OWNER TO postgres;

--
-- TOC entry 501 (class 1255 OID 506497)
-- Name: getseqtyperepos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtyperepos() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN (SELECT nextval('seqtyperepos'));
END
$$;


ALTER FUNCTION public.getseqtyperepos() OWNER TO postgres;

--
-- TOC entry 502 (class 1255 OID 506498)
-- Name: getseqtypetiers(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqtypetiers() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQTYPETIERS'));
END
$$;


ALTER FUNCTION public.getseqtypetiers() OWNER TO postgres;

--
-- TOC entry 503 (class 1255 OID 506499)
-- Name: getsequnite(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getsequnite() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQUNITE'));
END
$$;


ALTER FUNCTION public.getsequnite() OWNER TO postgres;

--
-- TOC entry 504 (class 1255 OID 506500)
-- Name: getsequsermenu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getsequsermenu() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQCNAPSUSER'));
END
$$;


ALTER FUNCTION public.getsequsermenu() OWNER TO postgres;

--
-- TOC entry 505 (class 1255 OID 506501)
-- Name: getsequtilisateur(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getsequtilisateur() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN (SELECT nextval('sequtilisateur'));
END;
$$;


ALTER FUNCTION public.getsequtilisateur() OWNER TO postgres;

--
-- TOC entry 506 (class 1255 OID 506502)
-- Name: getseqvente(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqvente() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQVENTE'));
END
$$;


ALTER FUNCTION public.getseqvente() OWNER TO postgres;

--
-- TOC entry 507 (class 1255 OID 506503)
-- Name: getseqvente_details(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getseqvente_details() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT nextval('SEQVENTE_DETAILS'));
END
$$;


ALTER FUNCTION public.getseqvente_details() OWNER TO postgres;

--
-- TOC entry 508 (class 1255 OID 506504)
-- Name: isferie(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.isferie(daty_ date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	declare rep varchar;
begin
	select valeur into rep from jourreposferie where valeur = daty_::varchar and daty<=daty_;
	if rep is null	then
		return 0;
	end if;
	return 1;
end;
$$;


ALTER FUNCTION public.isferie(daty_ date) OWNER TO postgres;

--
-- TOC entry 509 (class 1255 OID 506505)
-- Name: isferieweekend(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.isferieweekend(daty_ date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	declare rep varchar;
begin
	select max(id) into rep from "jourreposweekend" c where daty in (
															select max(daty) from jourreposweekend where daty<=daty_ and valeur = extract(isodow from daty_)::varchar) and valeur = extract(isodow from daty_)::varchar;
	if rep is null	then
		return 0;
	end if;
	return 1;
end;
$$;


ALTER FUNCTION public.isferieweekend(daty_ date) OWNER TO postgres;

--
-- TOC entry 510 (class 1255 OID 506506)
-- Name: isjourferie(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.isjourferie(daty_ date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	if isFerie(daty_) = 1 then
		return 1;
	end if;
	if isFerieWeekEnd(daty_) = 1 then
		return 1;
	end if;
	return 0;
end;
$$;


ALTER FUNCTION public.isjourferie(daty_ date) OWNER TO postgres;

--
-- TOC entry 511 (class 1255 OID 506507)
-- Name: metierdependance(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.metierdependance(idmetier character varying, rep character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare tmp varchar; test varchar;
 begin
	 select string_agg(idfille, ',') into tmp
	 from metierrelation
	 where idmere = any (string_to_array(idmetier, ','));
	 if tmp is null then
		 return rep;
	 else
		select string_agg(unnest,',') into test from unnest(string_to_array(tmp, ','))
		where unnest = any (string_to_array(rep, ','));
		if test is not null then
			return rep;
		end if;
		 if rep is null then
			 rep = tmp;
		 else rep = rep||','||tmp;
		 end if;
		 return metierdependance(tmp, rep);
	 end if;
 end;
 $$;


ALTER FUNCTION public.metierdependance(idmetier character varying, rep character varying) OWNER TO postgres;

--
-- TOC entry 512 (class 1255 OID 506508)
-- Name: metierdependancecomplet(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.metierdependancecomplet(idmetier character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare rep varchar; metierdependance varchar; metiermere varchar; metiermeredep varchar;
 begin
	 metiermere = metiermere(idmetier, null);
	if metiermere is not null and metiermere != '' then
		rep = metiermere;
	end if;

	metierdependance = metierdependance(idmetier, null);
	if metierdependance is not null and metierdependance != '' then
		if rep is not null then
			rep = rep || ',' || metierdependance;
		else rep = metierdependance;
		end if;
		metiermeredep = metiermere(metierdependance, null);
		if metiermeredep is not null and metiermeredep != '' then
			rep = rep || ',' || metiermeredep;
		end if;
	end if;
	return rep;
 end;
 $$;


ALTER FUNCTION public.metierdependancecomplet(idmetier character varying) OWNER TO postgres;

--
-- TOC entry 513 (class 1255 OID 506509)
-- Name: metierdependante(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.metierdependante(idmetier character varying, rep character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare tmp varchar; test varchar;
 begin
	 select string_agg(idmere, ',') into tmp
	 from metierrelationlib
	 where idfille = any (string_to_array(idmetier, ','));
	 if tmp is null then
		 return rep;
	 else
		select string_agg(unnest,',') into test from unnest(string_to_array(tmp, ','))
		where unnest = any (string_to_array(rep, ','));
		if test is not null then
			return rep;
		end if;
		 if rep is null then
			 rep = tmp;
		 else rep = rep||','||tmp;
		 end if;
		 return metierdependante(tmp, rep);
	 end if;
 end;
 $$;


ALTER FUNCTION public.metierdependante(idmetier character varying, rep character varying) OWNER TO postgres;

--
-- TOC entry 514 (class 1255 OID 506510)
-- Name: metierdependantecomplet(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.metierdependantecomplet(idmetier character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare rep varchar; metierdependante varchar; metierfille varchar;
 begin
	 metierdependante = metierdependante(idmetier, null);
	if metierdependante is not null and metierdependante != '' then
		rep = metierdependante;
		idmetier = idmetier || ',' || metierdependante;
	end if;

	metierfille = metierfille(idmetier, null);
	if metierfille is not null and metierfille != '' then
		if rep is not null then
			rep = rep || ',' || metierfille;
		else rep = metierfille;
		end if;
	end if;
	return rep;
 end;
 $$;


ALTER FUNCTION public.metierdependantecomplet(idmetier character varying) OWNER TO postgres;

--
-- TOC entry 515 (class 1255 OID 506511)
-- Name: metierfille(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.metierfille(idmetier character varying, rep character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare tmp varchar;
 begin
	 select string_agg(id, ',') into tmp
	 from metierlib
	 where idmere = any (string_to_array(idmetier, ','));
	 if tmp is null then
		 return rep;
	 else
		 if rep is null then
			 rep = tmp;
		 else rep = rep||','||tmp;
		 end if;
		 return metierfille(tmp, rep);
	 end if;
 end;
 $$;


ALTER FUNCTION public.metierfille(idmetier character varying, rep character varying) OWNER TO postgres;

--
-- TOC entry 516 (class 1255 OID 506512)
-- Name: metiermere(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.metiermere(idmetier character varying, rep character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare tmp varchar;
 begin
	 select string_agg(idmere, ',') into tmp
	 from metier
	 where id = any (string_to_array(idmetier, ','));
	 if tmp is null then
		 return rep;
	 else
		 if rep is null then
			 rep = tmp;
		 else rep = rep||','||tmp;
		 end if;
		 return metiermere(tmp, rep);
	 end if;
 end;
 $$;


ALTER FUNCTION public.metiermere(idmetier character varying, rep character varying) OWNER TO postgres;

--
-- TOC entry 517 (class 1255 OID 506513)
-- Name: nombreutilisateur(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.nombreutilisateur(role character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare rep int;
begin
	select count(refuser) into rep from utilisateur where idrole = role;
	return rep;
end;
$$;


ALTER FUNCTION public.nombreutilisateur(role character varying) OWNER TO postgres;

--
-- TOC entry 518 (class 1255 OID 506514)
-- Name: pagedependance(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.pagedependance(idpage character varying, rep character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare tmp varchar; test varchar;
 begin
	 select string_agg(idfille, ',') into tmp
	 from pagerelation
	 where idmere = any (string_to_array(idpage, ','));
	 if tmp is null then
		 return rep;
	 else
		select string_agg(unnest,',') into test from unnest(string_to_array(tmp, ','))
		where unnest = any (string_to_array(rep, ','));
		if test is not null then
			return rep;
		end if;

		 if rep is null then
			 rep = tmp;
		 else rep = rep||','||tmp;
		 end if;
		 return pagedependance(tmp, rep);
	 end if;
 end;
 $$;


ALTER FUNCTION public.pagedependance(idpage character varying, rep character varying) OWNER TO postgres;

--
-- TOC entry 519 (class 1255 OID 506515)
-- Name: pagedependante(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.pagedependante(idpage character varying, rep character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare tmp varchar; test varchar;
 begin
	 select string_agg(idmere, ',') into tmp
	 from pagerelation
	 where idfille = any (string_to_array(idpage, ','));
	 if tmp is null then
		 return rep;
	 else
		select string_agg(unnest,',') into test from unnest(string_to_array(tmp, ','))
		where unnest = any (string_to_array(rep, ','));
		if test is not null then
			return rep;
		end if;
		 if rep is null then
			 rep = tmp;
		 else rep = rep||','||tmp;
		 end if;
		 return pagedependante(tmp, rep);
	 end if;
 end;
 $$;


ALTER FUNCTION public.pagedependante(idpage character varying, rep character varying) OWNER TO postgres;

--
-- TOC entry 520 (class 1255 OID 506516)
-- Name: propositionestimation(character varying, character varying, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.propositionestimation(cote_ character varying, type_ character varying, niveau_ integer, responsable_ character varying) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
declare tempspasse_ float8;
begin
		select tempspasse into tempspasse_
		from moyenneTempsTacheResponsable
		where cote = cote_ and type = type_ and niveau = niveau_ and responsable = responsable_;

		if tempspasse_ is null then
			select tempspasse into tempspasse_
			from moyenneTempsTacheDefaut
			where cote = cote_ and type = type_ and niveau = niveau_;
		end if;

		if tempspasse_ is null then
			if niveau_>=0 then
				return propositionEstimation(cote_, type_, (niveau_ - 1), responsable_) + (30::numeric/60::numeric);
			end if;
			return (10::numeric/60::numeric);
		elsif tempspasse_ < (3::numeric/60::numeric) then
			return (3::numeric/60::numeric);
		else return tempspasse_;
		end if;
end;
$$;


ALTER FUNCTION public.propositionestimation(cote_ character varying, type_ character varying, niveau_ integer, responsable_ character varying) OWNER TO postgres;

--
-- TOC entry 521 (class 1255 OID 506517)
-- Name: propositionestimation(character varying, character varying, integer, character varying, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.propositionestimation(cote_ character varying, type_ character varying, niveau_ integer, responsable_ character varying, datymin date, datymax date) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
declare tempspasse_ float8;
begin
		if datymin is null then
			datymin = '1940-01-01';
		end if;
		if datymax is null then
			datymax = now();
		end if;

		select avg(dureetachedouble) as tempspasse, cote, type, responsable, niveau into tempspasse_
		from tache_libcompletformat tl
		where etatfille != 80 and responsable is not null and responsable != ''
				and fin is not null and debut is not null
				and cote = cote_ and type = type_ and niveau = niveau_ and responsable = responsable_
				and daty>=datymin and daty<=datymax
		group by cote, type, responsable, niveau;


		if tempspasse_ is null then
			select  avg(dureetachedouble) as tempspasse, cote, type, niveau into tempspasse_
			from tache_libcompletformat tl
			where etatfille != 80 and responsable is not null and responsable != ''
				and fin is not null and debut is not null
				and cote = cote_ and type = type_ and niveau = niveau_
				and daty>=datymin and daty<=datymax
			group by cote, type, niveau;
		end if;

		if tempspasse_ is null then
			if niveau_>=0 then
				return propositionEstimation(cote_, type_, (niveau_ - 1), responsable_, datymin, datymax) + (30::numeric/60::numeric);
			end if;
			return (10::numeric/60::numeric);
		elsif tempspasse_ < (3::numeric/60::numeric) then
			return (3::numeric/60::numeric);
		else return tempspasse_;
		--else return round(tempspasse_::numeric, 0);
		end if;
end;
$$;


ALTER FUNCTION public.propositionestimation(cote_ character varying, type_ character varying, niveau_ integer, responsable_ character varying, datymin date, datymax date) OWNER TO postgres;

--
-- TOC entry 522 (class 1255 OID 506518)
-- Name: setdatyhistorique_prix_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.setdatyhistorique_prix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
            NEW.daty := current_timestamp ;     
  
       RETURN NEW;
END;
$$;


ALTER FUNCTION public.setdatyhistorique_prix_trigger() OWNER TO postgres;

--
-- TOC entry 523 (class 1255 OID 506519)
-- Name: tachedependance(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.tachedependance(idtache_ character varying) RETURNS TABLE(id character varying)
    LANGUAGE plpgsql
    AS $$
declare r record;
begin
	for r in(select idtache, idmere, idfille
	from actionTacheLibvalide
	where (idtype = 'CREER' or idtype='MODIF') and idtache!=idtache_ and ((idmere in(
	select unnest(
			case
				when idtype = 'USAGE' then array[idmere::varchar, idfille::varchar]
				else
					case
						when (idmere is not null and idmere != '') and (idfille is not null and idfille != '') then array[idfille::varchar]
						when (idmere is null or (idmere is not null and idmere = '')) and (idfille is not null and idfille != '') then array[idfille::varchar]
						when (idfille is null or (idfille is not null and idfille = '')) and (idmere is not null and idmere != '') then array[idmere::varchar]
					end
			end
			)
	from actionTacheLibvalide
	where idtache = idtache_)) or ((idmere = '' or idmere is null) and idfille in(
	select unnest(
			case
				when idtype = 'USAGE' then array[idmere::varchar, idfille::varchar]
				else
					case
						when (idmere is not null and idmere != '') and (idfille is not null and idfille != '') then array[idfille::varchar]
						when (idmere is null or (idmere is not null and idmere = '')) and (idfille is not null and idfille != '') then array[idfille::varchar]
						when (idfille is null or (idfille is not null and idfille = '')) and (idmere is not null and idmere != '') then array[idmere::varchar]
					end
			end
			)
	from actionTacheLibvalide
	where idtache = idtache_)))) loop
									id:=r.idtache;
									return next;
								end loop;
end;
$$;


ALTER FUNCTION public.tachedependance(idtache_ character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 507061)
-- Name: direction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.direction (
    id character varying(50) NOT NULL,
    val character varying(100),
    desce character varying(200)
);


ALTER TABLE public.direction OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 507278)
-- Name: historique; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historique (
    idhistorique character varying(50) NOT NULL,
    datehistorique date,
    heure character varying(50),
    objet character varying(100),
    action character varying(50),
    idutilisateur integer,
    refobjet character varying(50)
);


ALTER TABLE public.historique OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 507281)
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    refuser integer NOT NULL,
    loginuser character varying(200),
    pwduser character varying(200),
    nomuser character varying(200),
    adruser character varying(200),
    teluser character varying(100),
    idrole character varying(100)
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 507286)
-- Name: historique_libelle; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.historique_libelle AS
 SELECT h.idhistorique,
    h.datehistorique,
    to_char((to_timestamp((h.heure)::text, 'HH24:MI:SS:FF2'::text) - '02:00:00'::interval hour), 'HH24:MI:SS:FF2'::text) AS heure,
    h.objet,
    h.action,
    u.refuser AS idutilisateur,
    h.refobjet,
    u.loginuser AS utilisateurlib
   FROM (public.historique h
     JOIN public.utilisateur u ON ((h.idutilisateur = u.refuser)))
  WHERE ((h.action)::text !~~ '%login%'::text);


ALTER TABLE public.historique_libelle OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 507383)
-- Name: menudynamique; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menudynamique (
    id character varying(50) NOT NULL,
    libelle character varying(50),
    icone character varying(250),
    href character varying(250),
    rang integer,
    niveau integer,
    id_pere character varying(50)
);


ALTER TABLE public.menudynamique OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 507388)
-- Name: menu_fils; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.menu_fils AS
 SELECT menudynamique.id,
    menudynamique.libelle,
    menudynamique.icone,
    menudynamique.href,
    menudynamique.rang,
    menudynamique.niveau,
    menudynamique.id_pere
   FROM public.menudynamique
  WHERE ((menudynamique.href)::text <> '#'::text);


ALTER TABLE public.menu_fils OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 507392)
-- Name: menudynamiquelib; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.menudynamiquelib AS
 SELECT mf.id,
    ((((mf.libelle)::text || ' '::text) || (menu.libelle)::text))::character varying(200) AS libelle,
    mf.icone,
    mf.href,
    mf.rang,
    mf.niveau,
    mf.id_pere
   FROM (public.menu_fils mf
     JOIN public.menudynamique menu ON (((menu.id)::text = (mf.id_pere)::text)));


ALTER TABLE public.menudynamiquelib OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 507477)
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id character varying(50) NOT NULL,
    sender character varying(50),
    receiver character varying(50),
    message text,
    lien character varying(150),
    daty date,
    heure time without time zone NOT NULL,
    etat integer,
    ref character varying(50)
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 507482)
-- Name: paramcrypt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paramcrypt (
    id character varying(100) NOT NULL,
    niveau integer,
    croissante integer,
    idutilisateur character varying(100)
);


ALTER TABLE public.paramcrypt OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 507524)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    idrole character varying NOT NULL,
    descrole character varying,
    rang integer
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 507529)
-- Name: seq_absence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_absence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seq_absence OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 507530)
-- Name: seq_article; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_article
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_article OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 507531)
-- Name: seq_branche; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_branche
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_branche OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 507532)
-- Name: seq_caisse; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_caisse
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_caisse OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 507533)
-- Name: seq_categorie; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_categorie
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_categorie OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 507534)
-- Name: seq_categorieavoirfc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_categorieavoirfc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_categorieavoirfc OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 507535)
-- Name: seq_categoriecaisse; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_categoriecaisse
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_categoriecaisse OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 507536)
-- Name: seq_classe; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_classe
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 20;


ALTER TABLE public.seq_classe OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 507537)
-- Name: seq_conception_pm; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_conception_pm
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 20;


ALTER TABLE public.seq_conception_pm OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 507538)
-- Name: seq_configuration; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_configuration
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_configuration OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 507539)
-- Name: seq_connexion; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_connexion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seq_connexion OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 507540)
-- Name: seq_couleurcombinaison; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_couleurcombinaison
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_couleurcombinaison OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 507541)
-- Name: seq_couleurprimaire; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_couleurprimaire
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_couleurprimaire OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 507542)
-- Name: seq_couleurprimairecombinaison; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_couleurprimairecombinaison
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_couleurprimairecombinaison OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 507543)
-- Name: seq_deploiement; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_deploiement
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_deploiement OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 507544)
-- Name: seq_enregistrementprdtfille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_enregistrementprdtfille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_enregistrementprdtfille OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 507545)
-- Name: seq_enregistrementproduit; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_enregistrementproduit
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_enregistrementproduit OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 507546)
-- Name: seq_entitescript; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_entitescript
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_entitescript OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 507547)
-- Name: seq_genre; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_genre
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_genre OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 507548)
-- Name: seq_historiqueprix; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_historiqueprix
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_historiqueprix OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 507549)
-- Name: seq_jourrepos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_jourrepos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seq_jourrepos OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 507550)
-- Name: seq_metierfille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_metierfille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 20;


ALTER TABLE public.seq_metierfille OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 507551)
-- Name: seq_modele; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_modele
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_modele OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 507552)
-- Name: seq_modeledispo; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_modeledispo
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_modeledispo OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 507553)
-- Name: seq_motifavoirfc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_motifavoirfc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_motifavoirfc OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 507554)
-- Name: seq_mouvementcaisse; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_mouvementcaisse
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_mouvementcaisse OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 507555)
-- Name: seq_notification; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_notification
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seq_notification OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 507556)
-- Name: seq_notificationsignal; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_notificationsignal
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seq_notificationsignal OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 507557)
-- Name: seq_paiement; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_paiement
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seq_paiement OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 507558)
-- Name: seq_reportcaisse; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_reportcaisse
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_reportcaisse OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 507559)
-- Name: seq_roles; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_roles
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_roles OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 507560)
-- Name: seq_script; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_script
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_script OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 507561)
-- Name: seq_scriptversionning; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_scriptversionning
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_scriptversionning OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 507562)
-- Name: seq_tache; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_tache
    START WITH 182
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_tache OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 507563)
-- Name: seq_taille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_taille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_taille OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 507564)
-- Name: seq_taillegenre; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_taillegenre
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_taillegenre OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 507565)
-- Name: seq_tempstravail; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_tempstravail
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seq_tempstravail OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 507566)
-- Name: seq_typeactionmetier; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_typeactionmetier
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 20;


ALTER TABLE public.seq_typeactionmetier OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 507567)
-- Name: seq_typecaisse; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_typecaisse
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_typecaisse OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 507568)
-- Name: seq_typescript; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_typescript
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_typescript OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 507569)
-- Name: seq_userhomepage; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_userhomepage
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_userhomepage OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 507570)
-- Name: seq_virementintracaisse; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_virementintracaisse
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999
    CACHE 20;


ALTER TABLE public.seq_virementintracaisse OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 507571)
-- Name: seqaction; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqaction
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqaction OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 507572)
-- Name: seqactiontache; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqactiontache
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqactiontache OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 507573)
-- Name: seqarchitecture; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqarchitecture
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqarchitecture OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 507574)
-- Name: seqas_bondecommandeclient; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqas_bondecommandeclient
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqas_bondecommandeclient OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 507575)
-- Name: seqas_bondecommandeclient_fille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqas_bondecommandeclient_fille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqas_bondecommandeclient_fille OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 507576)
-- Name: seqas_bondelivraisonclientclient; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqas_bondelivraisonclientclient
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqas_bondelivraisonclientclient OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 507577)
-- Name: seqas_bondelivraisonclientclient_fille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqas_bondelivraisonclientclient_fille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqas_bondelivraisonclientclient_fille OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 507578)
-- Name: seqattacher_fichier; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqattacher_fichier
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqattacher_fichier OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 507579)
-- Name: seqavoirfc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqavoirfc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqavoirfc OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 507580)
-- Name: seqavoirfcfille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqavoirfcfille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqavoirfcfille OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 507581)
-- Name: seqbase; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqbase
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqbase OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 507582)
-- Name: seqbaserelation; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqbaserelation
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqbaserelation OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 507583)
-- Name: seqboncommande; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqboncommande
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqboncommande OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 507584)
-- Name: seqbondecommandefille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqbondecommandefille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqbondecommandefille OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 507585)
-- Name: seqbondelivraison; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqbondelivraison
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqbondelivraison OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 507586)
-- Name: seqbondelivraisonfille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqbondelivraisonfille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqbondelivraisonfille OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 507587)
-- Name: seqbranche; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqbranche
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqbranche OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 507588)
-- Name: seqcategorie; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqcategorie
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 20;


ALTER TABLE public.seqcategorie OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 507589)
-- Name: seqcategorieniveau; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqcategorieniveau
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqcategorieniveau OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 507590)
-- Name: seqclient; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqclient
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqclient OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 507591)
-- Name: seqcloturecaisse; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqcloturecaisse
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqcloturecaisse OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 507592)
-- Name: seqcnapsuser; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqcnapsuser
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqcnapsuser OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 507593)
-- Name: seqcote; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqcote
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999999
    CACHE 20;


ALTER TABLE public.seqcote OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 507594)
-- Name: seqcreation_projet; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqcreation_projet
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999999
    CACHE 20;


ALTER TABLE public.seqcreation_projet OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 507595)
-- Name: seqdevise; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqdevise
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqdevise OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 507596)
-- Name: seqentite; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqentite
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqentite OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 507597)
-- Name: seqexecution_script; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqexecution_script
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqexecution_script OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 507598)
-- Name: seqexecution_scriptfille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqexecution_scriptfille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqexecution_scriptfille OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 507599)
-- Name: seqfactureclient; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqfactureclient
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqfactureclient OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 507600)
-- Name: seqfactureclientfille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqfactureclientfille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqfactureclientfille OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 507601)
-- Name: seqfacturefournisseur; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqfacturefournisseur
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqfacturefournisseur OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 507602)
-- Name: seqfacturefournisseurfille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqfacturefournisseurfille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqfacturefournisseurfille OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 507603)
-- Name: seqfonctionnalite; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqfonctionnalite
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqfonctionnalite OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 507604)
-- Name: seqhistorique; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqhistorique
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999999
    CACHE 20;


ALTER TABLE public.seqhistorique OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 507605)
-- Name: seqhistovaleur; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqhistovaleur
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999999
    CACHE 20;


ALTER TABLE public.seqhistovaleur OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 507606)
-- Name: seqinventaire; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqinventaire
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqinventaire OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 507607)
-- Name: seqinventairefille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqinventairefille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqinventairefille OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 507608)
-- Name: seqjauge; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqjauge
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqjauge OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 507609)
-- Name: seqmagasin; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqmagasin
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqmagasin OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 507610)
-- Name: seqmailcc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqmailcc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqmailcc OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 507611)
-- Name: seqmetier; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqmetier
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqmetier OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 507612)
-- Name: seqmetierrelation; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqmetierrelation
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqmetierrelation OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 507613)
-- Name: seqmodepaiement; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqmodepaiement
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqmodepaiement OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 507614)
-- Name: seqmvtstock; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqmvtstock
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqmvtstock OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 507615)
-- Name: seqmvtstockfille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqmvtstockfille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqmvtstockfille OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 507616)
-- Name: seqniveau; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqniveau
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqniveau OWNER TO postgres;

--
-- TOC entry 313 (class 1259 OID 507617)
-- Name: seqnotificationaction; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqnotificationaction
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqnotificationaction OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 507618)
-- Name: seqpage; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqpage
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqpage OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 507619)
-- Name: seqpagerelation; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqpagerelation
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqpagerelation OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 507620)
-- Name: seqpaiementfacturef; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqpaiementfacturef
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqpaiementfacturef OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 507621)
-- Name: seqparamcrypt; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqparamcrypt
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqparamcrypt OWNER TO postgres;

--
-- TOC entry 318 (class 1259 OID 507622)
-- Name: seqpiecejointe; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqpiecejointe
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqpiecejointe OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 507623)
-- Name: seqpoint; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqpoint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqpoint OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 507624)
-- Name: seqproduit; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqproduit
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqproduit OWNER TO postgres;

--
-- TOC entry 321 (class 1259 OID 507625)
-- Name: seqprojet; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqprojet
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqprojet OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 507626)
-- Name: seqretourbl; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqretourbl
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqretourbl OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 507627)
-- Name: seqretourblfille; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqretourblfille
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqretourblfille OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 507628)
-- Name: seqscript_projet; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqscript_projet
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqscript_projet OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 507629)
-- Name: seqsource; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqsource
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqsource OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 507630)
-- Name: seqsouscategorie; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqsouscategorie
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqsouscategorie OWNER TO postgres;

--
-- TOC entry 327 (class 1259 OID 507631)
-- Name: seqtache; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtache
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999999
    CACHE 20;


ALTER TABLE public.seqtache OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 507632)
-- Name: seqtachemere; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtachemere
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqtachemere OWNER TO postgres;

--
-- TOC entry 329 (class 1259 OID 507633)
-- Name: seqtiers; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtiers
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqtiers OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 507634)
-- Name: seqtransfertstock; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtransfertstock
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqtransfertstock OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 507635)
-- Name: seqtransfertstockdetails; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtransfertstockdetails
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqtransfertstockdetails OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 507636)
-- Name: seqtype; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtype
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999999
    CACHE 20;


ALTER TABLE public.seqtype OWNER TO postgres;

--
-- TOC entry 333 (class 1259 OID 507637)
-- Name: seqtype_produit; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtype_produit
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqtype_produit OWNER TO postgres;

--
-- TOC entry 334 (class 1259 OID 507638)
-- Name: seqtypeabsence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtypeabsence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqtypeabsence OWNER TO postgres;

--
-- TOC entry 335 (class 1259 OID 507639)
-- Name: seqtypeaction; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtypeaction
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqtypeaction OWNER TO postgres;

--
-- TOC entry 336 (class 1259 OID 507640)
-- Name: seqtypebase; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtypebase
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqtypebase OWNER TO postgres;

--
-- TOC entry 337 (class 1259 OID 507641)
-- Name: seqtypefichier; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtypefichier
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqtypefichier OWNER TO postgres;

--
-- TOC entry 338 (class 1259 OID 507642)
-- Name: seqtypemagasin; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtypemagasin
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqtypemagasin OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 507643)
-- Name: seqtypemetier; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtypemetier
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqtypemetier OWNER TO postgres;

--
-- TOC entry 340 (class 1259 OID 507644)
-- Name: seqtypemvtstock; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtypemvtstock
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqtypemvtstock OWNER TO postgres;

--
-- TOC entry 341 (class 1259 OID 507645)
-- Name: seqtypepage; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtypepage
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqtypepage OWNER TO postgres;

--
-- TOC entry 342 (class 1259 OID 507646)
-- Name: seqtyperemise; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtyperemise
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqtyperemise OWNER TO postgres;

--
-- TOC entry 343 (class 1259 OID 507647)
-- Name: seqtyperepos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtyperepos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999
    CACHE 1;


ALTER TABLE public.seqtyperepos OWNER TO postgres;

--
-- TOC entry 344 (class 1259 OID 507648)
-- Name: seqtypetiers; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqtypetiers
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqtypetiers OWNER TO postgres;

--
-- TOC entry 345 (class 1259 OID 507649)
-- Name: sequnite; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sequnite
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sequnite OWNER TO postgres;

--
-- TOC entry 346 (class 1259 OID 507650)
-- Name: sequsermenu; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sequsermenu
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sequsermenu OWNER TO postgres;

--
-- TOC entry 347 (class 1259 OID 507651)
-- Name: sequtilisateur; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sequtilisateur
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999999
    CACHE 20;


ALTER TABLE public.sequtilisateur OWNER TO postgres;

--
-- TOC entry 348 (class 1259 OID 507652)
-- Name: seqvente; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqvente
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqvente OWNER TO postgres;

--
-- TOC entry 349 (class 1259 OID 507653)
-- Name: seqvente_details; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seqvente_details
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqvente_details OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 507709)
-- Name: userhomepage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userhomepage (
    id character varying(50) NOT NULL,
    codeservice character varying(50),
    codedir character varying(50),
    idrole character varying(50),
    urlpage character varying(500)
);


ALTER TABLE public.userhomepage OWNER TO postgres;

--
-- TOC entry 351 (class 1259 OID 507714)
-- Name: usermenu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usermenu (
    id character varying(50) NOT NULL,
    refuser character varying(50),
    idmenu character varying(50),
    idrole character varying(50),
    codeservice character varying(50),
    codedir character varying(50),
    interdit integer
);


ALTER TABLE public.usermenu OWNER TO postgres;

--
-- TOC entry 352 (class 1259 OID 507717)
-- Name: usermenu_s; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.usermenu_s AS
 SELECT um.id,
    u.loginuser AS login,
    u.nomuser,
    u.refuser,
    menu.libelle AS idmenu,
    um.idrole,
    um.codeservice,
    um.codedir,
    um.interdit,
        CASE
            WHEN (um.interdit = 1) THEN 'OUI'::text
            ELSE 'NON'::text
        END AS interditlib,
    r.descrole AS role
   FROM (((public.usermenu um
     LEFT JOIN public.menudynamiquelib menu ON (((menu.id)::text = (um.idmenu)::text)))
     LEFT JOIN public.utilisateur u ON ((u.refuser = (um.refuser)::integer)))
     LEFT JOIN public.roles r ON (((r.idrole)::text = (um.idrole)::text)))
  WHERE ((um.refuser)::text <> '*'::text);


ALTER TABLE public.usermenu_s OWNER TO postgres;

--
-- TOC entry 353 (class 1259 OID 507722)
-- Name: usermenu_t; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.usermenu_t AS
 SELECT um.id,
    u.loginuser AS login,
    u.nomuser,
    u.refuser,
    menu.libelle AS idmenu,
    um.idrole,
    um.codeservice,
    um.codedir,
    um.interdit,
        CASE
            WHEN (um.interdit = 1) THEN 'OUI'::text
            ELSE 'NON'::text
        END AS interditlib,
    r.descrole AS role
   FROM (((public.usermenu um
     LEFT JOIN public.menudynamiquelib menu ON (((menu.id)::text = (um.idmenu)::text)))
     CROSS JOIN public.utilisateur u)
     LEFT JOIN public.roles r ON (((r.idrole)::text = (um.idrole)::text)))
  WHERE ((um.refuser)::text = '*'::text);


ALTER TABLE public.usermenu_t OWNER TO postgres;

--
-- TOC entry 354 (class 1259 OID 507727)
-- Name: utilisateurlib; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.utilisateurlib AS
 SELECT u.refuser,
    u.loginuser,
    u.nomuser,
    d.desce AS adruser,
    u.teluser,
    r.descrole AS idrole
   FROM ((public.utilisateur u
     LEFT JOIN public.roles r ON (((r.idrole)::text = (u.idrole)::text)))
     LEFT JOIN public.direction d ON (((d.id)::text = (u.adruser)::text)));


ALTER TABLE public.utilisateurlib OWNER TO postgres;

--
-- TOC entry 355 (class 1259 OID 507731)
-- Name: utilisateurvalide; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.utilisateurvalide AS
 SELECT u.refuser,
    u.loginuser,
    u.pwduser,
    u.nomuser,
    u.adruser,
    u.teluser,
    r.idrole,
    r.rang
   FROM (public.utilisateur u
     JOIN public.roles r ON (((u.idrole)::text = (r.idrole)::text)));


ALTER TABLE public.utilisateurvalide OWNER TO postgres;

--
-- TOC entry 356 (class 1259 OID 507735)
-- Name: utilisateurvue; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.utilisateurvue AS
 SELECT u.refuser,
    u.loginuser,
    u.pwduser,
    u.nomuser,
    d.desce AS adruser,
    u.teluser,
    u.idrole,
    r.rang
   FROM public.utilisateur u,
    public.direction d,
    public.roles r
  WHERE (((u.adruser)::text = (d.id)::text) AND ((r.idrole)::text = (u.idrole)::text));


ALTER TABLE public.utilisateurvue OWNER TO postgres;

--
-- TOC entry 357 (class 1259 OID 507739)
-- Name: utilisateurvue_fiche; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.utilisateurvue_fiche AS
 SELECT (u.refuser)::character varying(50) AS refuser,
    u.loginuser,
    u.nomuser,
    u.pwduser,
    d.id AS adruser,
    u.teluser,
    r.descrole AS rolelib,
    r.idrole
   FROM ((public.utilisateur u
     LEFT JOIN public.roles r ON (((r.idrole)::text = (u.idrole)::text)))
     LEFT JOIN public.direction d ON (((d.id)::text = (u.adruser)::text)));


ALTER TABLE public.utilisateurvue_fiche OWNER TO postgres;

--
-- TOC entry 358 (class 1259 OID 507744)
-- Name: utilisateurvue_str; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.utilisateurvue_str AS
 SELECT (u.refuser)::character varying(50) AS refuser,
    u.loginuser,
    u.nomuser,
    d.desce AS adruser,
    u.teluser,
    u.pwduser,
    r.descrole AS idrole
   FROM ((public.utilisateur u
     LEFT JOIN public.roles r ON (((r.idrole)::text = (u.idrole)::text)))
     LEFT JOIN public.direction d ON (((d.id)::text = (u.adruser)::text)));


ALTER TABLE public.utilisateurvue_str OWNER TO postgres;

--
-- TOC entry 359 (class 1259 OID 507759)
-- Name: v_usermenu; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_usermenu AS
 SELECT us.id,
    us.login,
    us.nomuser,
    us.refuser,
    us.idmenu,
    us.idrole,
    us.codeservice,
    us.codedir,
    us.interdit,
    us.interditlib,
    us.role
   FROM public.usermenu_s us
UNION
 SELECT ut.id,
    ut.login,
    ut.nomuser,
    ut.refuser,
    ut.idmenu,
    ut.idrole,
    ut.codeservice,
    ut.codedir,
    ut.interdit,
    ut.interditlib,
    ut.role
   FROM public.usermenu_t ut;


ALTER TABLE public.v_usermenu OWNER TO postgres;

--
-- TOC entry 3722 (class 0 OID 507061)
-- Dependencies: 215
-- Data for Name: direction; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.direction VALUES ('DIR000002', 'DG', 'Direction Générale');


--
-- TOC entry 3723 (class 0 OID 507278)
-- Dependencies: 216
-- Data for Name: historique; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3725 (class 0 OID 507383)
-- Dependencies: 219
-- Data for Name: menudynamique; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.menudynamique VALUES ('MENIM001', 'Menu 01', NULL, NULL, 1, 1, NULL);


--
-- TOC entry 3726 (class 0 OID 507477)
-- Dependencies: 222
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3727 (class 0 OID 507482)
-- Dependencies: 223
-- Data for Name: paramcrypt; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.paramcrypt VALUES ('1', 2, 0, '301');


--
-- TOC entry 3728 (class 0 OID 507524)
-- Dependencies: 224
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles VALUES ('dg', 'Administrateur', 1);


--
-- TOC entry 3854 (class 0 OID 507709)
-- Dependencies: 350
-- Data for Name: userhomepage; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3855 (class 0 OID 507714)
-- Dependencies: 351
-- Data for Name: usermenu; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3724 (class 0 OID 507281)
-- Dependencies: 217
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.utilisateur VALUES (301, 'Admin', 'eoeo', 'Administrateur', 'DIR000002', '0346147052', 'dg');


--
-- TOC entry 3864 (class 0 OID 0)
-- Dependencies: 225
-- Name: seq_absence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_absence', 3, true);


--
-- TOC entry 3865 (class 0 OID 0)
-- Dependencies: 226
-- Name: seq_article; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_article', 1220, true);


--
-- TOC entry 3866 (class 0 OID 0)
-- Dependencies: 227
-- Name: seq_branche; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_branche', 26, true);


--
-- TOC entry 3867 (class 0 OID 0)
-- Dependencies: 228
-- Name: seq_caisse; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_caisse', 520, true);


--
-- TOC entry 3868 (class 0 OID 0)
-- Dependencies: 229
-- Name: seq_categorie; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_categorie', 100, true);


--
-- TOC entry 3869 (class 0 OID 0)
-- Dependencies: 230
-- Name: seq_categorieavoirfc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_categorieavoirfc', 1, false);


--
-- TOC entry 3870 (class 0 OID 0)
-- Dependencies: 231
-- Name: seq_categoriecaisse; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_categoriecaisse', 1, false);


--
-- TOC entry 3871 (class 0 OID 0)
-- Dependencies: 232
-- Name: seq_classe; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_classe', 40, true);


--
-- TOC entry 3872 (class 0 OID 0)
-- Dependencies: 233
-- Name: seq_conception_pm; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_conception_pm', 60, true);


--
-- TOC entry 3873 (class 0 OID 0)
-- Dependencies: 234
-- Name: seq_configuration; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_configuration', 1, false);


--
-- TOC entry 3874 (class 0 OID 0)
-- Dependencies: 235
-- Name: seq_connexion; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_connexion', 3, true);


--
-- TOC entry 3875 (class 0 OID 0)
-- Dependencies: 236
-- Name: seq_couleurcombinaison; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_couleurcombinaison', 1500, true);


--
-- TOC entry 3876 (class 0 OID 0)
-- Dependencies: 237
-- Name: seq_couleurprimaire; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_couleurprimaire', 200, true);


--
-- TOC entry 3877 (class 0 OID 0)
-- Dependencies: 238
-- Name: seq_couleurprimairecombinaison; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_couleurprimairecombinaison', 1, false);


--
-- TOC entry 3878 (class 0 OID 0)
-- Dependencies: 239
-- Name: seq_deploiement; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_deploiement', 32, true);


--
-- TOC entry 3879 (class 0 OID 0)
-- Dependencies: 240
-- Name: seq_enregistrementprdtfille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_enregistrementprdtfille', 1400, true);


--
-- TOC entry 3880 (class 0 OID 0)
-- Dependencies: 241
-- Name: seq_enregistrementproduit; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_enregistrementproduit', 1520, true);


--
-- TOC entry 3881 (class 0 OID 0)
-- Dependencies: 242
-- Name: seq_entitescript; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_entitescript', 1, false);


--
-- TOC entry 3882 (class 0 OID 0)
-- Dependencies: 243
-- Name: seq_genre; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_genre', 20, true);


--
-- TOC entry 3883 (class 0 OID 0)
-- Dependencies: 244
-- Name: seq_historiqueprix; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_historiqueprix', 500, true);


--
-- TOC entry 3884 (class 0 OID 0)
-- Dependencies: 245
-- Name: seq_jourrepos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_jourrepos', 1, false);


--
-- TOC entry 3885 (class 0 OID 0)
-- Dependencies: 246
-- Name: seq_metierfille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_metierfille', 20, true);


--
-- TOC entry 3886 (class 0 OID 0)
-- Dependencies: 247
-- Name: seq_modele; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_modele', 1480, true);


--
-- TOC entry 3887 (class 0 OID 0)
-- Dependencies: 248
-- Name: seq_modeledispo; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_modeledispo', 1300, true);


--
-- TOC entry 3888 (class 0 OID 0)
-- Dependencies: 249
-- Name: seq_motifavoirfc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_motifavoirfc', 1, false);


--
-- TOC entry 3889 (class 0 OID 0)
-- Dependencies: 250
-- Name: seq_mouvementcaisse; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_mouvementcaisse', 920, true);


--
-- TOC entry 3890 (class 0 OID 0)
-- Dependencies: 251
-- Name: seq_notification; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_notification', 7789, true);


--
-- TOC entry 3891 (class 0 OID 0)
-- Dependencies: 252
-- Name: seq_notificationsignal; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_notificationsignal', 8, true);


--
-- TOC entry 3892 (class 0 OID 0)
-- Dependencies: 253
-- Name: seq_paiement; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_paiement', 44, true);


--
-- TOC entry 3893 (class 0 OID 0)
-- Dependencies: 254
-- Name: seq_reportcaisse; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_reportcaisse', 920, true);


--
-- TOC entry 3894 (class 0 OID 0)
-- Dependencies: 255
-- Name: seq_roles; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_roles', 5, true);


--
-- TOC entry 3895 (class 0 OID 0)
-- Dependencies: 256
-- Name: seq_script; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_script', 900, true);


--
-- TOC entry 3896 (class 0 OID 0)
-- Dependencies: 257
-- Name: seq_scriptversionning; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_scriptversionning', 980, true);


--
-- TOC entry 3897 (class 0 OID 0)
-- Dependencies: 258
-- Name: seq_tache; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_tache', 184, true);


--
-- TOC entry 3898 (class 0 OID 0)
-- Dependencies: 259
-- Name: seq_taille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_taille', 220, true);


--
-- TOC entry 3899 (class 0 OID 0)
-- Dependencies: 260
-- Name: seq_taillegenre; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_taillegenre', 920, true);


--
-- TOC entry 3900 (class 0 OID 0)
-- Dependencies: 261
-- Name: seq_tempstravail; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_tempstravail', 1, false);


--
-- TOC entry 3901 (class 0 OID 0)
-- Dependencies: 262
-- Name: seq_typeactionmetier; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_typeactionmetier', 20, true);


--
-- TOC entry 3902 (class 0 OID 0)
-- Dependencies: 263
-- Name: seq_typecaisse; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_typecaisse', 1, false);


--
-- TOC entry 3903 (class 0 OID 0)
-- Dependencies: 264
-- Name: seq_typescript; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_typescript', 40, true);


--
-- TOC entry 3904 (class 0 OID 0)
-- Dependencies: 265
-- Name: seq_userhomepage; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_userhomepage', 1, false);


--
-- TOC entry 3905 (class 0 OID 0)
-- Dependencies: 266
-- Name: seq_virementintracaisse; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_virementintracaisse', 160, true);


--
-- TOC entry 3906 (class 0 OID 0)
-- Dependencies: 267
-- Name: seqaction; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqaction', 1, false);


--
-- TOC entry 3907 (class 0 OID 0)
-- Dependencies: 268
-- Name: seqactiontache; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqactiontache', 1, false);


--
-- TOC entry 3908 (class 0 OID 0)
-- Dependencies: 269
-- Name: seqarchitecture; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqarchitecture', 5, true);


--
-- TOC entry 3909 (class 0 OID 0)
-- Dependencies: 270
-- Name: seqas_bondecommandeclient; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqas_bondecommandeclient', 30, true);


--
-- TOC entry 3910 (class 0 OID 0)
-- Dependencies: 271
-- Name: seqas_bondecommandeclient_fille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqas_bondecommandeclient_fille', 1, false);


--
-- TOC entry 3911 (class 0 OID 0)
-- Dependencies: 272
-- Name: seqas_bondelivraisonclientclient; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqas_bondelivraisonclientclient', 34, true);


--
-- TOC entry 3912 (class 0 OID 0)
-- Dependencies: 273
-- Name: seqas_bondelivraisonclientclient_fille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqas_bondelivraisonclientclient_fille', 34, true);


--
-- TOC entry 3913 (class 0 OID 0)
-- Dependencies: 274
-- Name: seqattacher_fichier; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqattacher_fichier', 45, true);


--
-- TOC entry 3914 (class 0 OID 0)
-- Dependencies: 275
-- Name: seqavoirfc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqavoirfc', 28, true);


--
-- TOC entry 3915 (class 0 OID 0)
-- Dependencies: 276
-- Name: seqavoirfcfille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqavoirfcfille', 38, true);


--
-- TOC entry 3916 (class 0 OID 0)
-- Dependencies: 277
-- Name: seqbase; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqbase', 20, true);


--
-- TOC entry 3917 (class 0 OID 0)
-- Dependencies: 278
-- Name: seqbaserelation; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqbaserelation', 18, true);


--
-- TOC entry 3918 (class 0 OID 0)
-- Dependencies: 279
-- Name: seqboncommande; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqboncommande', 20, true);


--
-- TOC entry 3919 (class 0 OID 0)
-- Dependencies: 280
-- Name: seqbondecommandefille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqbondecommandefille', 21, true);


--
-- TOC entry 3920 (class 0 OID 0)
-- Dependencies: 281
-- Name: seqbondelivraison; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqbondelivraison', 14, true);


--
-- TOC entry 3921 (class 0 OID 0)
-- Dependencies: 282
-- Name: seqbondelivraisonfille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqbondelivraisonfille', 15, true);


--
-- TOC entry 3922 (class 0 OID 0)
-- Dependencies: 283
-- Name: seqbranche; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqbranche', 1, false);


--
-- TOC entry 3923 (class 0 OID 0)
-- Dependencies: 284
-- Name: seqcategorie; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqcategorie', 1, false);


--
-- TOC entry 3924 (class 0 OID 0)
-- Dependencies: 285
-- Name: seqcategorieniveau; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqcategorieniveau', 1, false);


--
-- TOC entry 3925 (class 0 OID 0)
-- Dependencies: 286
-- Name: seqclient; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqclient', 21, true);


--
-- TOC entry 3926 (class 0 OID 0)
-- Dependencies: 287
-- Name: seqcloturecaisse; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqcloturecaisse', 14, true);


--
-- TOC entry 3927 (class 0 OID 0)
-- Dependencies: 288
-- Name: seqcnapsuser; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqcnapsuser', 46, true);


--
-- TOC entry 3928 (class 0 OID 0)
-- Dependencies: 289
-- Name: seqcote; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqcote', 80, true);


--
-- TOC entry 3929 (class 0 OID 0)
-- Dependencies: 290
-- Name: seqcreation_projet; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqcreation_projet', 1500, true);


--
-- TOC entry 3930 (class 0 OID 0)
-- Dependencies: 291
-- Name: seqdevise; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqdevise', 1, false);


--
-- TOC entry 3931 (class 0 OID 0)
-- Dependencies: 292
-- Name: seqentite; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqentite', 2303, true);


--
-- TOC entry 3932 (class 0 OID 0)
-- Dependencies: 293
-- Name: seqexecution_script; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqexecution_script', 7, true);


--
-- TOC entry 3933 (class 0 OID 0)
-- Dependencies: 294
-- Name: seqexecution_scriptfille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqexecution_scriptfille', 7, true);


--
-- TOC entry 3934 (class 0 OID 0)
-- Dependencies: 295
-- Name: seqfactureclient; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqfactureclient', 30, true);


--
-- TOC entry 3935 (class 0 OID 0)
-- Dependencies: 296
-- Name: seqfactureclientfille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqfactureclientfille', 41, true);


--
-- TOC entry 3936 (class 0 OID 0)
-- Dependencies: 297
-- Name: seqfacturefournisseur; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqfacturefournisseur', 40, true);


--
-- TOC entry 3937 (class 0 OID 0)
-- Dependencies: 298
-- Name: seqfacturefournisseurfille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqfacturefournisseurfille', 45, true);


--
-- TOC entry 3938 (class 0 OID 0)
-- Dependencies: 299
-- Name: seqfonctionnalite; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqfonctionnalite', 237, true);


--
-- TOC entry 3939 (class 0 OID 0)
-- Dependencies: 300
-- Name: seqhistorique; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqhistorique', 1464740, true);


--
-- TOC entry 3940 (class 0 OID 0)
-- Dependencies: 301
-- Name: seqhistovaleur; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqhistovaleur', 7160, true);


--
-- TOC entry 3941 (class 0 OID 0)
-- Dependencies: 302
-- Name: seqinventaire; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqinventaire', 33, true);


--
-- TOC entry 3942 (class 0 OID 0)
-- Dependencies: 303
-- Name: seqinventairefille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqinventairefille', 25, true);


--
-- TOC entry 3943 (class 0 OID 0)
-- Dependencies: 304
-- Name: seqjauge; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqjauge', 1, false);


--
-- TOC entry 3944 (class 0 OID 0)
-- Dependencies: 305
-- Name: seqmagasin; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqmagasin', 1, false);


--
-- TOC entry 3945 (class 0 OID 0)
-- Dependencies: 306
-- Name: seqmailcc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqmailcc', 1, false);


--
-- TOC entry 3946 (class 0 OID 0)
-- Dependencies: 307
-- Name: seqmetier; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqmetier', 665, true);


--
-- TOC entry 3947 (class 0 OID 0)
-- Dependencies: 308
-- Name: seqmetierrelation; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqmetierrelation', 1, true);


--
-- TOC entry 3948 (class 0 OID 0)
-- Dependencies: 309
-- Name: seqmodepaiement; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqmodepaiement', 1, false);


--
-- TOC entry 3949 (class 0 OID 0)
-- Dependencies: 310
-- Name: seqmvtstock; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqmvtstock', 92, true);


--
-- TOC entry 3950 (class 0 OID 0)
-- Dependencies: 311
-- Name: seqmvtstockfille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqmvtstockfille', 107, true);


--
-- TOC entry 3951 (class 0 OID 0)
-- Dependencies: 312
-- Name: seqniveau; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqniveau', 1, false);


--
-- TOC entry 3952 (class 0 OID 0)
-- Dependencies: 313
-- Name: seqnotificationaction; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqnotificationaction', 1, false);


--
-- TOC entry 3953 (class 0 OID 0)
-- Dependencies: 314
-- Name: seqpage; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqpage', 5414, true);


--
-- TOC entry 3954 (class 0 OID 0)
-- Dependencies: 315
-- Name: seqpagerelation; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqpagerelation', 1, false);


--
-- TOC entry 3955 (class 0 OID 0)
-- Dependencies: 316
-- Name: seqpaiementfacturef; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqpaiementfacturef', 1, false);


--
-- TOC entry 3956 (class 0 OID 0)
-- Dependencies: 317
-- Name: seqparamcrypt; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqparamcrypt', 5, true);


--
-- TOC entry 3957 (class 0 OID 0)
-- Dependencies: 318
-- Name: seqpiecejointe; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqpiecejointe', 9, true);


--
-- TOC entry 3958 (class 0 OID 0)
-- Dependencies: 319
-- Name: seqpoint; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqpoint', 1, false);


--
-- TOC entry 3959 (class 0 OID 0)
-- Dependencies: 320
-- Name: seqproduit; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqproduit', 1, false);


--
-- TOC entry 3960 (class 0 OID 0)
-- Dependencies: 321
-- Name: seqprojet; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqprojet', 1, true);


--
-- TOC entry 3961 (class 0 OID 0)
-- Dependencies: 322
-- Name: seqretourbl; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqretourbl', 11, true);


--
-- TOC entry 3962 (class 0 OID 0)
-- Dependencies: 323
-- Name: seqretourblfille; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqretourblfille', 10, true);


--
-- TOC entry 3963 (class 0 OID 0)
-- Dependencies: 324
-- Name: seqscript_projet; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqscript_projet', 84, true);


--
-- TOC entry 3964 (class 0 OID 0)
-- Dependencies: 325
-- Name: seqsource; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqsource', 1, false);


--
-- TOC entry 3965 (class 0 OID 0)
-- Dependencies: 326
-- Name: seqsouscategorie; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqsouscategorie', 1, false);


--
-- TOC entry 3966 (class 0 OID 0)
-- Dependencies: 327
-- Name: seqtache; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtache', 200619, true);


--
-- TOC entry 3967 (class 0 OID 0)
-- Dependencies: 328
-- Name: seqtachemere; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtachemere', 11892, true);


--
-- TOC entry 3968 (class 0 OID 0)
-- Dependencies: 329
-- Name: seqtiers; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtiers', 1, true);


--
-- TOC entry 3969 (class 0 OID 0)
-- Dependencies: 330
-- Name: seqtransfertstock; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtransfertstock', 1, true);


--
-- TOC entry 3970 (class 0 OID 0)
-- Dependencies: 331
-- Name: seqtransfertstockdetails; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtransfertstockdetails', 1, false);


--
-- TOC entry 3971 (class 0 OID 0)
-- Dependencies: 332
-- Name: seqtype; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtype', 80, true);


--
-- TOC entry 3972 (class 0 OID 0)
-- Dependencies: 333
-- Name: seqtype_produit; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtype_produit', 1, false);


--
-- TOC entry 3973 (class 0 OID 0)
-- Dependencies: 334
-- Name: seqtypeabsence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtypeabsence', 1, false);


--
-- TOC entry 3974 (class 0 OID 0)
-- Dependencies: 335
-- Name: seqtypeaction; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtypeaction', 1, false);


--
-- TOC entry 3975 (class 0 OID 0)
-- Dependencies: 336
-- Name: seqtypebase; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtypebase', 2, true);


--
-- TOC entry 3976 (class 0 OID 0)
-- Dependencies: 337
-- Name: seqtypefichier; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtypefichier', 1, false);


--
-- TOC entry 3977 (class 0 OID 0)
-- Dependencies: 338
-- Name: seqtypemagasin; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtypemagasin', 1, false);


--
-- TOC entry 3978 (class 0 OID 0)
-- Dependencies: 339
-- Name: seqtypemetier; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtypemetier', 2, true);


--
-- TOC entry 3979 (class 0 OID 0)
-- Dependencies: 340
-- Name: seqtypemvtstock; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtypemvtstock', 2, true);


--
-- TOC entry 3980 (class 0 OID 0)
-- Dependencies: 341
-- Name: seqtypepage; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtypepage', 4, true);


--
-- TOC entry 3981 (class 0 OID 0)
-- Dependencies: 342
-- Name: seqtyperemise; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtyperemise', 2, true);


--
-- TOC entry 3982 (class 0 OID 0)
-- Dependencies: 343
-- Name: seqtyperepos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtyperepos', 1, false);


--
-- TOC entry 3983 (class 0 OID 0)
-- Dependencies: 344
-- Name: seqtypetiers; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqtypetiers', 2, true);


--
-- TOC entry 3984 (class 0 OID 0)
-- Dependencies: 345
-- Name: sequnite; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sequnite', 1, false);


--
-- TOC entry 3985 (class 0 OID 0)
-- Dependencies: 346
-- Name: sequsermenu; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sequsermenu', 1, false);


--
-- TOC entry 3986 (class 0 OID 0)
-- Dependencies: 347
-- Name: sequtilisateur; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sequtilisateur', 380, true);


--
-- TOC entry 3987 (class 0 OID 0)
-- Dependencies: 348
-- Name: seqvente; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqvente', 1, false);


--
-- TOC entry 3988 (class 0 OID 0)
-- Dependencies: 349
-- Name: seqvente_details; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seqvente_details', 1, false);


--
-- TOC entry 3554 (class 2606 OID 507838)
-- Name: direction direction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direction
    ADD CONSTRAINT direction_pkey PRIMARY KEY (id);


--
-- TOC entry 3556 (class 2606 OID 507854)
-- Name: historique historique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique
    ADD CONSTRAINT historique_pkey PRIMARY KEY (idhistorique);


--
-- TOC entry 3562 (class 2606 OID 507888)
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- TOC entry 3564 (class 2606 OID 507894)
-- Name: paramcrypt paramcrypt_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paramcrypt
    ADD CONSTRAINT paramcrypt_pk PRIMARY KEY (id);


--
-- TOC entry 3560 (class 2606 OID 507900)
-- Name: menudynamique pkmenud; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menudynamique
    ADD CONSTRAINT pkmenud PRIMARY KEY (id);


--
-- TOC entry 3566 (class 2606 OID 507938)
-- Name: userhomepage userhomepage_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userhomepage
    ADD CONSTRAINT userhomepage_pk PRIMARY KEY (id);


--
-- TOC entry 3568 (class 2606 OID 507940)
-- Name: usermenu usermenu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usermenu
    ADD CONSTRAINT usermenu_pkey PRIMARY KEY (id);


--
-- TOC entry 3558 (class 2606 OID 507942)
-- Name: utilisateur utilisateur_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pk PRIMARY KEY (refuser);


--
-- TOC entry 3863 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-09-02 17:13:04 EAT

--
-- PostgreSQL database dump complete
--

