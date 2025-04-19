// Archivo para crear las relaciones de las consultas de requerimientos del proyecto
// -------------------------------------- Crear Relaciones para Consultas Recomendaciones ---------------------------------


// relaciones a crear:
// 1. (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
MATCH (c:Category)<-[:LISTED_IN]-(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)-[:LISTED_IN]->(c2:Category)
WHERE m.id <> m2.id AND c.name = c2.name
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_CATEGORY{quantity:qty}]->(m2);

//2. (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY_DRAMAS]->(m2:Movie)
MATCH (c:Category)<-[:LISTED_IN]-(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)-[:LISTED_IN]->(c2:Category)
WHERE m.id <> m2.id AND c.name = c2.name AND c.name = "Dramas"
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_CATEGORY_DRAMAS{quantity:qty}]->(m2);

//3. (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY]->(m2:Movie)
MATCH (c:Country)<-[:FROM]-(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)-[:FROM]->(c2:Country)
WHERE m.id <> m2.id AND c.name = c2.name
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_COUNTRY{quantity:qty}]->(m2);

//4. (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY_MEXICO]->(m2:Movie)
MATCH (c:Country)<-[:FROM]-(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)-[:FROM]->(c2:Country)
WHERE m.id <> m2.id AND c.name = c2.name AND c.name = "Mexico"
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_COUNTRY_MEXICO{quantity:qty}]->(m2);

//5. (m:Movie)-[r:WATCH_TOG_SAME_ACTOR]->(m2:Movie)
MATCH (pe:Person)-[:ACTED_IN]->(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)<-[:ACTED_IN]-(pe2:Person)
WHERE m.id <> m2.id AND pe.name = pe2.name
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_ACTOR{quantity:qty}]->(m2);

//6. (m:Movie)-[r:WATCH_TOG_SAME_ACTOR_TOM_HOLLAND]->(m2:Movie)

//7. (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR]->(m2:Movie)

//8. (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR_MARTIN_SCORSESE]->(m2:Movie)

//9. (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR]->(m2:Movie)

//10. (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR_2019]->(m2:Movie)

//11. (m:Movie)-[r:WATCH_TOG_SAME_ACTOR_COUNTRY]->(m2:Movie)

//12. (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR_COUNTRY]->(m2:Movie)

//13. (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR_MOVIE_COUNTRY]->(m2:Movie)

//14. (m:Movie)-[r:WATCH_TOG_SAME_ACTOR_DIRECTOR_COUNTRY]->(m2:Movie)

//15. (m:Movie)-[r:WATCH_TOG_SAME_ACTOR_DIRECTOR_MOVIE_COUNTRY]->(m2:Movie)

