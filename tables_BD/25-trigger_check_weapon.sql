CREATE FUNCTION check_mission_action_weapon()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS $$
DECLARE
     id_w int = 0 ;

BEGIN

    select id_weapon into id_w
    from mission NATURAL JOIN action
    where id_mission = NEW.id_mission ;

    IF id_w not in (select id_weapon
                        from possède_w) THEN
            raise notice 'YOU DONT HAVE THE weapon THAT THIS ACTION NEED id_weapon %',id_w;
            RETURN NULL;

    END IF;
    RETURN NEW;


END;
$$;

CREATE TRIGGER check_mission_action_weapon
    BEFORE INSERT OR UPDATE ON char_concerne_miss
    FOR EACH ROW
    EXECUTE FUNCTION check_mission_action_weapon();
