// Archivo Técnico para presentar en el proyecto 2 de Minería de Grafos

// Agregamos los Profiles creados en el CSV 'nombres_con_apellidos.csv'
LOAD CSV WITH HEADERS FROM 'file:///nombres_con_apellidos.csv' AS row
CREATE (:Profile{
    id: toInteger(row.id_profile),
    name: row.nombre_completo
});

// Ahora generamos las relaciones (p:Profile)-[r:ADD]->(m:Movie)
// EJECUTAMOS ADDGenerator.py
// Pusimos 37000 iteraciones, pero algunas se repitieron entonces contemos:
MATCH (p:Profile)-[r:ADD]->(m:Movie)
RETURN COUNT(r) AS Total_Relaciones_ADD; // Nos dio 36814


