// Archivo para crear consultas de requerimientos del proyecto
// -------------------------------------- Consultas Recomendaciones ---------------------------------

//1. Mostrar el top 5 de recomendaciones basadas en categoría
MATCH (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//2. Mostrar el top 5 de recomendaciones basadas en categoría Dramas
MATCH (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY_DRAMAS]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//3. Mostrar el top 5 de recomendaciones basadas en país
MATCH (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY]->(m2:Movie)-[]->(c:Country)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//4. Mostrar el top 5 de recomendaciones basadas en país Mexico
MATCH (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY_MEXICO]->(m2:Movie)-[]->(c:Country)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//5. Mostrar el top 5 de recomendaciones basadas en un actor
MATCH (m:Movie)-[r:WATCH_TOG_SAME_ACTOR]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//6. Mostrar el top 5 de recomendaciones basadas en un actor de tu elección: Tom Holland
MATCH (m:Movie)-[r:WATCH_TOG_SAME_ACTOR_TOM_HOLLAND]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//7. Mostrar el top 5 de recomendaciones basadas en un director
MATCH (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//8. Mostrar el top 5 de recomendaciones basadas en un director de tu elección: Martin Scorsese
MATCH (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR_MARTIN_SCORSESE]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//9. Mostrar el top 5 de recomendaciones basadas en un año de lanzamiento
MATCH (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//10. Mostrar el top 5 de recomendaciones basadas en un año de lanzamiento de tu elección: 2019
MATCH (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR_2019]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//11. Mostrar el top 5 de recomendaciones basadas en actores del mismo país
MATCH (m:Movie)-[r:WATCH_TOG_SAME_ACTOR_COUNTRY]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//12. Mostrar el top 5 de recomendaciones basadas en directores del mismo país
MATCH (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR_COUNTRY]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//13. Mostrar el top 5 de recomendaciones basadas en directores y peliculas del mismo país
MATCH (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR_MOVIE_COUNTRY]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//14. Mostrar el top 5 de recomendaciones basadas en actores y directores del mismo país
MATCH (m:Movie)-[r:WATCH_TOG_SAME_ACTOR_DIRECTOR_COUNTRY]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;

//15. Mostrar el top 5 de recomendaciones basadas en actores y directores y peliculas del mismo país
MATCH (m:Movie)-[r:WATCH_TOG_SAME_ACTOR_DIRECTOR_MOVIE_COUNTRY]->(m2:Movie)
RETURN m.title AS Movie, m2.title AS RecommendedMovie, r.quantity AS RecommendationsCount
ORDER BY RecommendationsCount DESC
LIMIT 5;