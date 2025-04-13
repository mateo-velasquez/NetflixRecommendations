// En este archivo se responderan a las preguntas del análisis Exploratorio:

// PREGUNTAS:

// 1. ¿Cómo es el esquema general del grafo?
CALL db.schema.visualization;

// 2. ¿Cuáles tipos de nodos existen y qué atributos tienen?
CALL db.schema.nodeTypeProperties;

// 3. ¿Cuántos nodos de tipo Movie existen?
MATCH (m:Movie)
RETURN COUNT(m) AS Total_Nodos_Movie;

// 4. ¿Cuántos nodos de tipo Person existen?
MATCH (p:Person)
RETURN COUNT(p) AS Total_Nodos_Person;

// 5. ¿Cuántos nodos de tipo Profile existen?
MATCH (p:Profile)
RETURN COUNT(p) AS Total_Nodos_Profile;

// 6. ¿Cuántos nodos de tipo Country existen?
MATCH (c:Country)
RETURN COUNT(c) AS Total_Nodos_Country;

// 7. ¿Cuántos nodos de tipo Category existen?
MATCH (c:Category)
RETURN COUNT(c) AS Total_Nodos_Category;

// 8. ¿Cuáles tipos de relaciones existen y qué atributos tienen?
CALL db.schema.relTypeProperties;

// 9. ¿Cuántas relaciones "ACTED_IN" existen?
MATCH ()-[r:ACTED_IN]->()
RETURN COUNT(r) AS Total_Relaciones_ACTED_IN;

// 10. ¿Cuántas relaciones "DIRECTED" existen?
MATCH ()-[r:DIRECTED]->()
RETURN COUNT(r) AS Total_Relaciones_DIRECTED;

// 11. ¿Cuántas relaciones "IS_CITIZEN_OF" existen?
MATCH ()-[r:IS_CITIZEN_OF]->()
RETURN COUNT(r) AS Total_Relaciones_IS_CITIZEN_OF;

// 12. ¿Cuántas relaciones "FROM" existen?
MATCH ()-[r:FROM]->()
RETURN COUNT(r) AS Total_Relaciones_FROM;

// 13. ¿Cuántas relaciones "LISTED_IN" existen?
MATCH ()-[r:LISTED_IN]->()
RETURN COUNT(r) AS Total_Relaciones_LISTED_IN;

// 14. ¿Cuántas relaciones "ADD" existen?
MATCH ()-[r:ADD]->()
RETURN COUNT(r) AS Total_Relaciones_ADD;

// 15. ¿Cuál es el diámetro del grafo?
// Gephi

// 16. ¿Cuál es la densidad del grafo?
// Gephi

// 17. ¿Cuáles son las 50 películas más añadidas a los perfiles?
MATCH ()-[r:ADD]->(m:Movie)
RETURN m.id AS IDMovie,
    m.title AS Nombre_SerieOPelicula,
    COUNT(m.id) AS Total_ADDs
ORDER BY Total_ADDs DESC
LIMIT 50;

// 18. ¿Existen películas que nunca fueron añadidas a los perfiles?
MATCH (m:Movie)
WHERE NOT ( ()-[:ADD]->(m) )
RETURN COUNT(DISTINCT m) AS Total_NO_ADDs;

// 19. ¿Quiénes son los 20 actores más famosos?
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)<-[r:ADD]-(pr:Profile)
WITH p.name AS Nombre_Actor,
    COUNT(r) AS Total_ADDs
RETURN Nombre_Actor, Total_ADDs
ORDER BY Total_ADDs DESC
LIMIT 20;

// 20. ¿Quiénes son los 10 directores a los que más películas han generado un ADD?
MATCH (p:Person)-[:DIRECTED]->(m:Movie)<-[r:ADD]-(pr:Profile)
WITH p.name AS Nombre_Director,
    COUNT(r) AS Total_ADDs
RETURN Nombre_Director, Total_ADDs
ORDER BY Total_ADDs DESC
LIMIT 10;

// 21. ¿Qué 5 países tienen más actores?
MATCH (c:Country)<-[:IS_CITIZEN_OF]-(p:Person)-[:ACTED_IN]->(m:Movie)
RETURN c.name AS Pais,
    COUNT(DISTINCT p.name) AS Total_Actores
ORDER BY Total_Actores DESC
LIMIT 5;

// 22. ¿De qué país son las 50 películas más añadidas?
MATCH ()-[r:ADD]->(m:Movie)-[:FROM]->(c:Country)
RETURN m.id AS IDMovie,
    m.title AS Nombre_SerieOPelicula,
    c.name AS Pais,
    COUNT(m.id) AS Total_ADDs
ORDER BY Total_ADDs DESC
LIMIT 50;

// 23. ¿Existen perfiles que nunca hicieron ADD a una serie/película?
MATCH (p:Profile)
WHERE NOT ( (p)-[:ADD]->() )
RETURN COUNT(DISTINCT p.id) AS Total_NO_ADDs;

// 24. ¿Cuáles son las 5 categorías favoritas de la gente?
MATCH (c:Category)<-[:LISTED_IN]-(m:Movie)<-[r:ADD]-(:Profile)
RETURN c.name AS Category,
    COUNT(r) AS Total_ADDs_Por_Categoria
ORDER BY Total_ADDs_Por_Categoria DESC
LIMIT 5;

// 25. ¿Quiénes son los 10 actores que actuaron en más películas?
MATCH (p:Person)-[:ACTED_IN]->(:Movie)<-[r:ADD]-(:Profile)
RETURN p.name AS Category,
    COUNT(r) AS Total_ADDs_Por_Actor
ORDER BY Total_ADDs_Por_Actor DESC
LIMIT 10;
