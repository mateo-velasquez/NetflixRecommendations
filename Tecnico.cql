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
// Pusimos 43000 iteraciones, pero algunas se repitieron entonces contemos:
MATCH (p:Profile)-[r:ADD]->(m:Movie)
RETURN COUNT(r) AS Total_Relaciones_ADD; // Nos dio 42283

// TOP
"Control Z"

s28,
s33,
s34,
s83,
s312,
s339,
s391,
s452,
s575,
s602,
s779,
s6201,
s1996,
s1139,
s1333,
s1386,
s1449,
s1571,
s1617,
s2011






// Algoritmos de centralidad



