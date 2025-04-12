// Archivo para crear las relaciones a partir de las recomendaciones básicas
// -------------------------------------- Recomendaciones con la BD ---------------------------------
// TIPOS RECOMENDACIONES

// 1. Basada en coincidencia de vista conjunta en una mismo perfil
// Movie WATCH_TOGETHER Movie2
MATCH (m:Movie)<-[:ADD]-(o:Profile)-[:ADD]->(m2:Movie)
WITH m, m2, COUNT(o.id) AS qty   
WHERE m.id <> m2.id
MERGE (m)-[:WATCH_TOGETHER{quantity:qty}]->(m2);

// 2. Basada en coincidencia de vista conjunta en una mismo perfil y que sean de la misma categoría
// Movie WATCH_CON Movie2 de la misma categoría
MATCH (c:Category)<-[]-(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)-[]->(c2:Category)
WHERE m<>m2 AND (c:Category)<-[]-(m2)
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_CATEGORY{quantity:qty}]->(m2);

// 3. Basada en coincidencia de vista conjunta en una mismo perfil y que sean de la misma categoría Dramas
// Movie WATCH_CON Movie2 de la misma categoría Dramas
MATCH (c:Category)<-[]-(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)-[]->(c2:Category)
WHERE m<>m2 AND (c:Category)<-[]-(m2) AND c.name = 'Dramas' 
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_CATEGORY_DRAMAS{quantity:qty}]->(m2);

// 4. Basada en coincidencia de vista conjunta en una mismo perfil y que sean del mismo país
// Movie WATCH_CON Movie2 de la mismo país
MATCH (c:Country)<-[]-(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)-[]->(c2:Country)
WHERE m<>m2 AND (c:Country)<-[]-(m2)
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_COUNTRY{quantity:qty}]->(m2);

// 5. Basada en coincidencia de vista conjunta en una mismo perfil y que sean del mismo país Mexico
// Movie WATCH_CON Movie2 de la mismo país Mexico
MATCH (c:Country)<-[]-(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)-[]->(c2:Country)
WHERE m<>m2 AND (c:Country)<-[]-(m2) AND c.name = 'Mexico'
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_COUNTRY_MEXICO{quantity:qty}]->(m2);

// 6. Basada en coincidencia de vista conjunta en una mismo perfil y que sean del mismo actor
// Movie WATCH_CON Movie2 de la mismo actor
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)<-[:ACTED_IN]-(p2:Person)
WHERE m<>m2 AND (p:Person)-[]->(m2)
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_ACTOR{quantity:qty}]->(m2);

// 7. Basada en coincidencia de vista conjunta en una mismo perfil y que sean del mismo actor Tom Holland
// Movie WATCH_CON Movie2 de la mismo actor Tom Holland
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)<-[:ACTED_IN]-(p2:Person)
WHERE m<>m2 AND (p:Person)-[]->(m2) AND p.name = 'Tom Holland'
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_ACTOR_TOM_HOLLAND{quantity:qty}]->(m2);

// 8. Basada en coincidencia de vista conjunta en una mismo perfil y que sean del mismo director
// Movie WATCH_CON Movie2 de la mismo director
MATCH (p:Person)-[:DIRECTED]->(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)<-[:DIRECTED]-(p2:Person)
WHERE m<>m2 AND (p:Person)-[]->(m2)
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_DIRECTOR{quantity:qty}]->(m2);

// 9. Basada en coincidencia de vista conjunta en una mismo perfil y que sean del mismo director Martin Scorsese
// Movie WATCH_CON Movie2 de la mismo director Martin Scorsese
MATCH (p:Person)-[:DIRECTED]->(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)<-[:DIRECTED]-(p2:Person)
WHERE m<>m2 AND (p:Person)-[]->(m2) AND p.name = 'Martin Scorsese'
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_DIRECTOR_MARTIN_SCORSESE{quantity:qty}]->(m2);

// 10. Basada en coincidencia de vista conjunta en una mismo perfil y que sean del mismo año de lanzamiento
// Movie WATCH_CON Movie2 de la mismo año de lanzamiento
MATCH (m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)
WHERE m<>m2 AND m.releaseYear = m2.releaseYear
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_RELEASE_YEAR{quantity:qty}]->(m2);

// 11. Basada en coincidencia de vista conjunta en una mismo perfil y que sean del mismo año de lanzamiento 2019 
// Movie WATCH_CON Movie2 de la mismo año de lanzamiento 2019
MATCH (m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)
WHERE m<>m2 AND m.releaseYear = 2019 AND m2.releaseYear = 2019
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_RELEASE_YEAR_2019{quantity:qty}]->(m2);

// 12. Basada en coincidencia de vista conjunta en una mismo perfil y que sean actores del mismo país
// Movie WATCH_CON Movie2 actores del mismo país
MATCH (c:Country)<-[]-(p:Person)-[:ACTED_IN]->(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)<-[:ACTED_IN]-(p2:Person)-[]->(c2:Country)
WHERE m<>m2 AND (c:Country)<-[]-(p2)
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_ACTOR_COUNTRY{quantity:qty}]->(m2);

// 13. Basada en coincidencia de vista conjunta en una mismo perfil y que sean directores del mismo país
// Movie WATCH_CON Movie2 directores del mismo país
MATCH (c:Country)<-[]-(p:Person)-[:DIRECTED]->(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)<-[:DIRECTED]-(p2:Person)-[]->(c2:Country)
WHERE m<>m2 AND (c:Country)<-[]-(p2)
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_DIRECTOR_COUNTRY{quantity:qty}]->(m2);

// 14. Basada en coincidencia de vista conjunta en una mismo perfil y que sean directores y peliculas del mismo país
// Movie WATCH_CON Movie2 directores y peliculas del mismo país
MATCH (c:Country)<-[]-(p:Person)-[:DIRECTED]->(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)<-[:DIRECTED]-(p2:Person)-[]->(c2:Country)
WHERE m<>m2 AND (c:Country)<-[]-(p2) AND (c:Country)<-[]-(m2)
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_DIRECTOR_MOVIE_COUNTRY{quantity:qty}]->(m2);

// 15. Basada en coincidencia de vista conjunta en una mismo perfil y que sean actores y directores del mismo país
// Movie WATCH_CON Movie2 actores y directores del mismo país
MATCH (c:Country)<-[]-(p:Person)-[:ACTED_IN]->(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)<-[:DIRECTED]-(p2:Person)-[]->(c2:Country)
WHERE m<>m2 AND (c:Country)<-[]-(p2) AND (c:Country)<-[]-(p)
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_ACTOR_DIRECTOR_COUNTRY{quantity:qty}]->(m2);

// 16. Basada en coincidencia de vista conjunta en una mismo perfil y que sean actores, directores y peliculas del mismo país
// Movie WATCH_CON Movie2 actores, directores y peliculas del mismo país
MATCH (c:Country)<-[]-(p:Person)-[:ACTED_IN]->(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)<-[:DIRECTED]-(p2:Person)-[]->(c2:Country)
WHERE m<>m2 AND (c:Country)<-[]-(p2) AND (c:Country)<-[]-(p) AND (c:Country)<-[]-(m2)
WITH m, m2, COUNT(o.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_ACTOR_DIRECTOR_MOVIE_COUNTRY{quantity:qty}]->(m2);