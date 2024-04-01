CREATE FUNCTION acheter_vehicule()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS $$
DECLARE
    prix_w int = 0;
    argent int = 0;

BEGIN
    SELECT prix_vehicule
    FROM vehicule
    WHERE id_vehicule = NEW.id_vehicule
    INTO prix_w;

    SELECT quantité
    FROM possède_t,trésor
    WHERE possède_t.id_trésor=trésor.id_trésor and id_character = NEW.id_character and type_trésor ='argent'
    INTO argent;

    IF argent < prix_w THEN
         raise notice 'YOU DONT HAVE ENOUGH MONEY FOR BUY THE vehicule .';
        RETURN NULL ;
    END IF;

    UPDATE possède_t
    SET quantité = quantité- prix_w
    WHERE id_character = NEW.id_character and id_trésor = (SELECT id_trésor
                                                            FROM trésor
                                                            WHERE type_trésor ='argent');
    RETURN NEW;
END;
$$;

CREATE TRIGGER acheter_vehicule
    BEFORE INSERT OR UPDATE ON possède_v
    FOR EACH ROW
    EXECUTE FUNCTION acheter_vehicule();
