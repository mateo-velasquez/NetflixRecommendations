// Archivo Técnico para presentar en el proyecto 2 de Minería de Grafos
//NetflixRecommendations:

// Agregamos los Profiles creados en el CSV 'profiles.csv'
LOAD CSV WITH HEADERS FROM 'file:///profiles.csv' AS row
CREATE (:Profile{
    id: row.id_profile,
    name: row.nombre_completo
});

// Ahora generamos las relaciones (p:Profile)-[r:ADD]->(m:Movie)
// EJECUTAMOS ADDGenerator.py
// Pusimos 37000 iteraciones, pero algunas se repitieron entonces contemos:
MATCH (p:Profile)-[r:ADD]->(m:Movie)
RETURN COUNT(r) AS Total_Relaciones_ADD; // Nos dio 42283


