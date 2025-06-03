--- PREGUNTAS A CONTESTAR --- 
--- PREGUNTA 1  ¿Cuántos pasajeros sobrevivieron y cuántos no? --- 

SELECT 
    CASE 
        WHEN sobrevivio = true THEN 'Vivo'
        WHEN sobrevivio = false THEN 'Muerto'
    END AS estado_supervivencia,
    COUNT(*) AS cantidad_pasajeros
FROM 
    pasajeros
GROUP BY 
    sobrevivio
ORDER BY 
    cantidad_pasajeros DESC;


---PREGUNTA 2 ¿Cuál fue el porcentaje de supervivencia?--
SELECT 
    COUNT(CASE WHEN sobrevivio = true THEN 1 END) AS sobrevivientes,
    COUNT(*) AS total_pasajeros,
    ROUND(
        (COUNT(CASE WHEN sobrevivio = true THEN 1 END) * 100.0 / 
        COUNT(*)), 
    2) AS porcentaje
FROM 
    pasajeros;


----PREGUNTA 3 ¿Qué clase tuvo la mayor tasa de supervivencia?---
SELECT 
    c.clase AS clase_pasajero,
    COUNT(p.id_pasajero) AS total_pasajeros,
    COUNT(CASE WHEN p.sobrevivio = true THEN 1 END) AS sobrevivientes,
    ROUND(
        (COUNT(CASE WHEN p.sobrevivio = true THEN 1 END) * 100.0 / 
        COUNT(p.id_pasajero)), 
    2) AS porcentaje_supervivencia
FROM 
    public.pasajeros p
JOIN 
    public.clase c ON p.id_clase = c.id_clase
GROUP BY 
    c.clase
ORDER BY 
    porcentaje_supervivencia DESC
LIMIT 1;


----PREGUNTA 4 ¿Qué porcentaje de mujeres sobrevivió en comparación con los hombres?---
SELECT 
    g.genero,
    COUNT(p.id_pasajero) AS total_pasajeros,
    COUNT(CASE WHEN p.sobrevivio = true THEN 1 END) AS sobrevivientes,
    ROUND(
        (COUNT(CASE WHEN p.sobrevivio = true THEN 1 END) * 100.0 / 
        COUNT(p.id_pasajero)), 
    2) AS porcentaje_supervivencia
FROM 
    public.pasajeros p
JOIN 
    public.genero g ON p.id_genero = g.id_genero
GROUP BY 
    g.genero
ORDER BY 
    porcentaje_supervivencia DESC;


---PREGUNTA 5 ¿Sobrevivieron más niños que adultos? Si y No (agregar cantidad de niños y adultos)---
WITH clasificacion_edad AS (
    SELECT 
        id_pasajero,
        nombre,
        sobrevivio,
        edad,
        CASE 
            WHEN edad < 18 THEN 'Niño'
            ELSE 'Adulto'
        END AS grupo_edad
    FROM 
        public.pasajeros
    WHERE 
        edad IS NOT NULL  -- Excluimos pasajeros sin edad registrada
)

SELECT 
    grupo_edad,
    COUNT(*) AS total_pasajeros,
    COUNT(CASE WHEN sobrevivio = true THEN 1 END) AS sobrevivientes,
    ROUND(
        COUNT(CASE WHEN sobrevivio = true THEN 1 END) * 100.0 / COUNT(*), 
        2
    ) AS porcentaje_supervivencia
FROM 
    clasificacion_edad
GROUP BY 
    grupo_edad
ORDER BY 
    porcentaje_supervivencia DESC;


--- PREGUNTA 6 ¿Cuál boleto fue el más caro?---
SELECT 
    p.id_pasajero,
    p.nombre,
    c.clase AS clase_pasajero,
    p.ticket AS numero_ticket,
    p.precio AS precio_boleto
FROM 
    public.pasajeros p
JOIN 
    public.clase c ON p.id_clase = c.id_clase
WHERE 
    p.precio IS NOT NULL
ORDER BY 
    p.precio DESC
LIMIT 5;


---PREGUNTA 7 ¿Cuántos pasajeros viajaban solos?---
SELECT 
    COUNT(*) AS pasajeros_viajando_solos
FROM 
    public.pasajeros
WHERE 
    (parientes = 0 OR parientes IS NULL) 
    AND (padres = '0' OR padres IS NULL);



----PREGUNTA 8 ¿Desde qué puerto embarcaron más pasajeros? (Embarked)----
SELECT 
    e.puerto_embarque,
    COUNT(p.id_pasajero) AS total_pasajeros,
    ROUND(COUNT(p.id_pasajero) * 100.0 / (SELECT COUNT(*) FROM public.pasajeros), 2) AS porcentaje_total
FROM 
    public.pasajeros p
JOIN 
    public.embarque e ON p.id_embarque = e.id_embarque
WHERE 
    e.puerto_embarque IS NOT NULL
GROUP BY 
    e.puerto_embarque
ORDER BY 
    total_pasajeros DESC;




----PREGUNTA 9 ¿Cuántas personas de cada puerto sobrevivieron?
SELECT 
    e.puerto_embarque,
    c.clase,
    g.genero,
    COUNT(p.id_pasajero) AS total_pasajeros,
    COUNT(CASE WHEN p.sobrevivio = true THEN 1 END) AS total_sobrevivientes
FROM 
    public.pasajeros p
JOIN 
    public.embarque e ON p.id_embarque = e.id_embarque
JOIN 
    public.clase c ON p.id_clase = c.id_clase
JOIN 
    public.genero g ON p.id_genero = g.id_genero
GROUP BY 
    e.puerto_embarque, c.clase, g.genero
ORDER BY 
    e.puerto_embarque, total_sobrevivientes DESC;







