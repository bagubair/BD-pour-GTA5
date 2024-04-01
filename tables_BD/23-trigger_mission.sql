CREATE FUNCTION check_mission_ouvert()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS $$
DECLARE


BEGIN
    if (SELECT status_mission FROM mission WHERE id_mission = NEW.id_mission ) = 'fermé' THEN
        raise notice 'This mission is  close you cant do it .';

        RETURN NULL ;


    END IF;
    if (SELECT status_mission FROM mission WHERE id_mission = NEW.id_mission ) = 'complet' THEN
        raise notice 'This mission is  complet you cant do it .';

        RETURN NULL ;


    END IF;

    RETURN NEW;


END;
$$;

CREATE TRIGGER check_mission_ouvert
    BEFORE INSERT OR UPDATE ON char_concerne_miss
    FOR EACH ROW
    EXECUTE FUNCTION check_mission_ouvert();
