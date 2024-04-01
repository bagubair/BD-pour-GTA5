CREATE FUNCTION change_status_mission()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS $$
DECLARE



BEGIN
    update mission set status_mission = 'complet'
    WHERE id_mission = NEW.id_mission ;

    update mission set status_mission = 'ouvert'
    WHERE id_mission = NEW.id_mission+1 ;



    RETURN NEW ;
END;
$$;

CREATE TRIGGER change_status_mission
    AFTER INSERT OR UPDATE ON char_concerne_miss
    FOR EACH ROW
    EXECUTE FUNCTION change_status_mission();
