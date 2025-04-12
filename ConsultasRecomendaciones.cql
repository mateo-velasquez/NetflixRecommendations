// Archivo para crear consultas de requerimientos del proyecto
// -------------------------------------- Consultas Recomendaciones ---------------------------------

// Mostrar el top 5 de recomendaciones basadas en categoría
MATCH (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

// Mostrar el top 5 de recomendaciones basadas en país
MATCH (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY]->(m2:Movie)-[]->(c:Country)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

// Mostrar el top 5 de recomendaciones basadas en un actor de tu elección: Tom Holland
MATCH (m:Movie)-[r:WATCH_TOG_SAME_ACTOR_TOM_HOLLAND]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

// Mostrar el top 5 de recomendaciones basadas en un director de tu elección: Martin Scorsese
MATCH (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR_MARTIN_SCORSESE]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

// Mostrar el top 5 de recomendaciones basadas en un año de lanzamiento de tu elección: 2019
MATCH (m:Movie)-[r:WATCH_TOG_SAME_YEAR_2019]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;