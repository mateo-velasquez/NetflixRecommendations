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
MATCH (pe:Person)-[:ACTED_IN]->(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)<-[:ACTED_IN]-(pe2:Person)
WHERE m.id <> m2.id AND pe.name = pe2.name AND pe.name = "Tom Holland"
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_ACTOR_TOM_HOLLAND{quantity:qty}]->(m2);

//7. (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR]->(m2:Movie)
MATCH (pe:Person)-[:DIRECTED]->(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)<-[:DIRECTED]-(pe2:Person)
WHERE m.id <> m2.id AND pe.name = pe2.name
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_DIRECTOR{quantity:qty}]->(m2);

//8. (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR_MARTIN_SCORSESE]->(m2:Movie)
MATCH (pe:Person)-[:DIRECTED]->(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)<-[:DIRECTED]-(pe2:Person)
WHERE m.id <> m2.id AND pe.name = pe2.name AND pe.name = "Martin Scorsese"
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_DIRECTOR_MARTIN_SCORSESE{quantity:qty}]->(m2);

//9. (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR]->(m2:Movie)
MATCH (m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)
WHERE m.id <> m2.id AND m.releaseYear = m2.releaseYear
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_RELEASE_YEAR{quantity:qty}]->(m2);

//10. (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR_2019]->(m2:Movie)
MATCH (m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)
WHERE m.id <> m2.id AND m.releaseYear = m2.releaseYear AND m.releaseYear = 2019
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_RELEASE_YEAR_2019{quantity:qty}]->(m2);

//11. (m:Movie)-[r:WATCH_TOG_SAME_ACTOR_COUNTRY]->(m2:Movie)
MATCH (co:Country)<-[:IS_CITIZEN_OF]-(pe:Person)-[:ACTED_IN]->(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)<-[:ACTED_IN]-(pe2:Person)-[:IS_CITIZEN_OF]->(co2:Country)
WHERE m.id <> m2.id AND co.name = co2.name
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_ACTOR_COUNTRY{quantity:qty}]->(m2);

//12. (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR_COUNTRY]->(m2:Movie)
MATCH (co:Country)<-[:IS_CITIZEN_OF]-(pe:Person)-[:DIRECTED]->(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)<-[:DIRECTED]-(pe2:Person)-[:IS_CITIZEN_OF]->(co2:Country)
WHERE m.id <> m2.id AND co.name = co2.name
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_DIRECTOR_COUNTRY{quantity:qty}]->(m2);

//13. (m:Movie)-[r:WATCH_TOG_SAME_ACTOR_MOVIE_COUNTRY]->(m2:Movie)
MATCH (co:Country)<-[:IS_CITIZEN_OF]-(pe:Person)-[:ACTED_IN]->(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)<-[:ACTED_IN]-(pe2:Person)-[:IS_CITIZEN_OF]->(co2:Country),
      (c3:Country)<-[:FROM]-(m),
      (m2)-[:FROM]->(c4:Country)
WHERE m.id <> m2.id AND co.name = co2.name AND c3.name = c4.name
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_ACTOR_MOVIE_COUNTRY{quantity:qty}]->(m2);

//14. (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR_MOVIE_COUNTRY]->(m2:Movie)
MATCH (co:Country)<-[:IS_CITIZEN_OF]-(pe:Person)-[:DIRECTED]->(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)<-[:DIRECTED]-(pe2:Person)-[:IS_CITIZEN_OF]->(co2:Country),
      (c3:Country)<-[:FROM]-(m),
      (m2)-[:FROM]->(c4:Country)
WHERE m.id <> m2.id AND co.name = co2.name AND c3.name = c4.name
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_DIRECTOR_MOVIE_COUNTRY{quantity:qty}]->(m2);

//15. (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY_COUNTRY]->(m2:Movie)
MATCH (c:Category)<-[:LISTED_IN]-(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)-[:LISTED_IN]->(c2:Category),
      (c3:Country)<-[:FROM]-(m),
      (m2)-[:FROM]->(c4:Country)
WHERE m.id <> m2.id AND c.name = c2.name AND c3.name = c4.name
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_CATEGORY_COUNTRY{quantity:qty}]->(m2);

//16. (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR_CATEGORY]->(m2:Movie)
MATCH (pe:Person)-[:DIRECTED]->(m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)<-[:DIRECTED]-(pe2:Person),
      (c:Category)<-[:LISTED_IN]-(m),
      (m2)-[:LISTED_IN]->(c2:Category)
WHERE m.id <> m2.id AND pe.name = pe2.name AND c.name = c2.name
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_DIRECTOR_CATEGORY{quantity:qty}]->(m2);
