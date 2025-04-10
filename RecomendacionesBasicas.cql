-------------------------------------- Recomendaciones con la BD ---------------------------------
// TIPOS RECOMENDACIONES

// 1. Basada en coincidencia de vista conjunta en una mismo perfil
// Movie WATCH_TOGETHER Movie2

MATCH (m:Movie)<-[:ADD]-(p:Profile)-[:ADD]->(m2:Movie)
WITH m, m2, COUNT(p.id) AS qty   
WHERE m.id <> m2.id
MERGE (m)-[:WATCH_TOGETHER{quantity:qty}]->(m2);

// 2. Basada en coincidencia de vista conjunta en una mismo perfil y que sean de la misma categoría
// Movie WATCH_CON Movie2 de la misma categoría

MATCH (c:Category)<-[]-(m:Movie)<-[]-(o:Profile)-[]->(m2:Movie)-[]->(c2:Category)
WHERE m<>m2 AND (c:Category)<-[]-(m2)
WITH m, m2, COUNT(o.orderID) AS qty
MERGE (m)-[:WATCH_TOG_SAME_CATEGORY{quantity:qty}]->(m2);

// ver top 10
MATCH (m)-[r:WATCH_TOG_SAME_CATEGORY]->(m2)
RETURN m.title, COUNT(r) as count
ORDER BY count desc

// 3. Basada en coincidencia de vista conjunta en una mismo perfil y que sean del mismo país
// Movie WATCH_CON Movie2 de la mismo país

MATCH (c:Country)-[]->(m:Movie)<-[]-(p:Profile)-[]->(m2:Movie)<-[]-(c2:Country)
WHERE m<>m2 AND (c:Country)-[]->(m2)
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_COUNTRY{quantity:qty}]->(m2);

// 4. Basada en coincidencia de vista conjunta en una mismo perfil y que sean del mismo actor Tom Holland
// Movie WATCH_CON Movie2 de la mismo actor Tom Holland
MATCH (pe:Person)-[]->(m:Movie)<-[]-(p:Profile)-[]->(m2:Movie)<-[]-(pe)
WHERE m<>m2 AND (pe:Person)-[]->(m2) AND pe.name = 'Tom Holland'
WITH m, m2, COUNT(p.id) AS qty
MERGE (m)-[:WATCH_TOG_SAME_ACTOR_TOM_HOLLAND{quantity:qty}]->(m2);

// 5. Basada en coincidencia de vista conjunta en una mismo perfil y que sean del mismo director 
// Movie WATCH_CON Movie2 de la mismo director


// 6. Basada en coincidencia de vista conjunta en una mismo perfil y que sean del mismo año de lanzamiento 2019 
// Movie WATCH_CON Movie2 de la mismo año de lanzamiento 2019

// -------------------------------- CONSULTAS PARA CONTEXTO ------------------------------
// ver actor con mas peliculas
MATCH (p:Person)-[r:ACTED_IN]->(m:Movie)
RETURN p.name, count(r) as count
ORDER BY count DESC

// Samuel L. Jackson

// ver directores con mas peliculas
MATCH (p:Person)-[r:DIRECTED]->(m:Movie)
RETURN p.name, count(r) as count
ORDER BY count DESC

// Samuel L. Jackson

//Martin Scorsese

// ver años con mas peliculas
MATCH (m:Movie)
RETURN m.releaseYear as year, count(m) as count
ORDER BY count DESC

MATCH (m:Movie)
RETURN m.releaseYear as year, count(m) as count
ORDER BY year asc