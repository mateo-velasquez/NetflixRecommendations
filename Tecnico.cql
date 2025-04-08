// Archivo Técnico para presentar en el proyecto 2 de Minería de Grafos

// Agregamos los Profiles creados en el CSV 'nombres_con_apellidos.csv'
LOAD CSV WITH HEADERS FROM 'file:///nombres_con_apellidos.csv' AS row
CREATE (:Profile{
    id: row.id_profile,
    name: row.nombre_completo
});

