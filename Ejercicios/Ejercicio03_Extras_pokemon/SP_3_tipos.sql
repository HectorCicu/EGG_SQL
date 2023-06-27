CREATE DEFINER=`root`@`localhost` PROCEDURE `muestraPokemonBy3Tipos`(p_tipo1 varchar(10), p_tipo2 varchar(10), p_tipo3 varchar(10))
begin
    select nombre
    from pokemon
    where numero_pokedex in (select numero_pokedex
                            from pokemon_tipo pt, tipo t
                            where pt.id_tipo=t.id_tipo and lower(t.nombre)=lower(trim(p_tipo1)))
    and numero_pokedex in (select numero_pokedex
                            from pokemon_tipo pt, tipo t
                            where pt.id_tipo=t.id_tipo and lower(t.nombre)=lower(trim(p_tipo2)))
    and numero_pokedex in (select numero_pokedex
                            from pokemon_tipo pt, tipo t
                            where pt.id_tipo=t.id_tipo and lower(t.nombre)=lower(trim(p_tipo3)));
    
end