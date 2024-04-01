CREATE FUNCTION check_mission_action_vehicule()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS $$
DECLARE
    id_v int = 0;


BEGIN
    select id_vehicule into id_v
    from mission  NATURAL JOIN action
    where id_mission = NEW.id_mission ;


    IF id_v not in (select id_vehicule
                        from possède_v) THEN
            raise notice 'YOU DONT HAVE THE CAR THAT THIS ACTION NEED id_vehicule %',id_v;
            RETURN NULL;

    END IF;
    RETURN NEW;


END;
$$;

CREATE TRIGGER check_mission_action_vehicule
    BEFORE INSERT OR UPDATE ON char_concerne_miss
    FOR EACH ROW
    EXECUTE FUNCTION check_mission_action_vehicule();
