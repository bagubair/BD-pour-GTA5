CREATE FUNCTION do_m(VARCHAR,INT) --nom de CHARACTER
    RETURNS void
    LANGUAGE PLPGSQL
    AS $$
DECLARE

    id_c int = 0 ;
BEGIN
    SELECT id_character INTO id_c
    FROM character
    where nom_character = $1 ;

    INSERT INTO char_concerne_miss VALUES (id_c,$2);

END;
$$;
