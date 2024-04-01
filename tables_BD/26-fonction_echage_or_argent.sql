CREATE FUNCTION echager_or_to_argent(VARCHAR,int) --nom de CHARACTER
    RETURNS void
    LANGUAGE PLPGSQL
    AS $$
DECLARE
    id_ors int = 0;
    id_argent int = 0;
    id_c int = 0 ;
BEGIN

    SELECT id_trésor INTO id_ors
    FROM character NATURAL JOIN possède_t NATURAL JOIN trésor
    where nom_character = $1 and type_trésor = 'or' ;


    SELECT id_character INTO id_c
    FROM character NATURAL JOIN possède_t NATURAL JOIN trésor
    where nom_character = $1 and type_trésor = 'or'
    ;

    SELECT id_trésor
    FROM character NATURAL JOIN possède_t NATURAL JOIN trésor
    where nom_character = $1 and type_trésor = 'argent'

    INTO id_argent;

    update possède_t
    set quantité = quantité - $2
    WHERE id_character = id_c  and id_trésor = id_ors  ;
    raise notice 'valeur %',id_c  ;
    raise notice 'valeur %', id_ors ;
    raise notice 'valeur %', id_argent ;


    update possède_t
    set quantité = quantité + ($2*100000)
    WHERE id_character = id_c  and id_trésor =id_argent ;



END;
$$;
