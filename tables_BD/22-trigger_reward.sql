    CREATE FUNCTION gagner_reward()
        RETURNS TRIGGER
        LANGUAGE PLPGSQL
        AS $$
    DECLARE
        xp int = 0;
        argent int = 0;
        ors int = 0 ;
        niveau int = 0 ;

    BEGIN
        IF NEW.id_mission NOT IN (SELECT id_mission FROM gagner) THEN
            RETURN NULL ;
        END IF;

        IF (SELECT id_reward FROM reward WHERE type_reward = 'argent' ) IN (SELECT id_reward FROM gagner) THEN
            SELECT quantité
            FROM gagner
            WHERE id_mission = NEW.id_mission AND id_reward = (SELECT id_reward
                                                            FROM reward
                                                            WHERE type_reward = 'argent')
            INTO argent;
        END IF ;

        IF (SELECT id_reward FROM reward WHERE type_reward = 'xp' ) IN (SELECT id_reward FROM gagner) THEN
            SELECT quantité
            FROM gagner
            WHERE id_mission = NEW.id_mission AND id_reward = (SELECT id_reward
                                                            FROM reward
                                                            WHERE type_reward = 'xp')
            INTO xp;
        END IF ;

        IF (SELECT id_reward FROM reward WHERE type_reward = 'or' ) IN (SELECT id_reward FROM gagner) THEN
            SELECT quantité
            FROM gagner
            WHERE id_mission = NEW.id_mission AND id_reward = (SELECT id_reward
                                                            FROM reward
                                                            WHERE type_reward = 'or')
            INTO ors;

        ELSE SELECT 0  INTO ors;

        END IF ;

        IF (SELECT id_reward FROM reward WHERE type_reward = 'niveau' ) IN (SELECT id_reward FROM gagner) THEN
            SELECT quantité
            FROM gagner
            WHERE id_mission = NEW.id_mission AND id_reward = (SELECT id_reward
                                                                FROM reward
                                                                WHERE type_reward = 'niveau')
            INTO niveau;
        END IF ;


        UPDATE possède_t
        SET quantité = quantité + argent
        WHERE id_character = NEW.id_character and id_trésor = (SELECT id_trésor
                                                                FROM trésor
                                                                WHERE type_trésor ='argent');

        UPDATE possède_t
        SET quantité = quantité + ors
        WHERE id_character = NEW.id_character and id_trésor = (SELECT id_trésor
                                                                FROM trésor
                                                                WHERE type_trésor ='or');

        UPDATE character
        SET xp_character = xp_character + xp
        WHERE id_character = NEW.id_character;



        UPDATE character
        SET niveau_character = niveau_character +niveau
        WHERE id_character = NEW.id_character;


        RETURN OLD;
    END;
    $$;

    CREATE TRIGGER gagner_reward
        AFTER INSERT OR UPDATE ON char_concerne_miss
        FOR EACH ROW
        EXECUTE FUNCTION gagner_reward();
