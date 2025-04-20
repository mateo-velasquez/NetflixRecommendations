//-------------------------------------- Algoritmos de Comunidades ------------------------------------------------


// RELACIONES ELEGIDAS:
// (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_ACTOR]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR]->(m2:Movie)



// RELACION (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)

// TRIANGLE COUNT
// PASO 1: Creamos el subgrafo:
CALL gds.graph.project(
    'myGraphTr',
    'Movie',
    {WATCH_TOG_SAME_CATEGORY:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.triangleCount.write.estimate(
    'myGraphTr', {writeProperty: 'trianglesSameCategory'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.triangleCount.stream('myGraphTr')
YIELD nodeId, triangleCount
RETURN gds.util.asNode(nodeId).name AS name, triangleCount
ORDER BY triangleCount DESC, name ASC;

// PASO 4: veamos que nodos pertenecen a un triangulo
CALL gds.triangleCount.write('myGraphTr', {
        writeProperty: 'trianglesSameCategory'
    }
)
YIELD globalTriangleCount, nodeCount;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.id AS ID,
    m.trianglesSameCategory as numero_de_triagulos
ORDER BY numero_de_triagulos DESC;


// LOCAL CLUSTERING COEFFICIENT
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphLCC',
  'Movie',
  {WATCH_TOG_SAME_CATEGORY:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.localClusteringCoefficient.write.estimate('myGraphLCC', {
  writeProperty: 'clusteringCoefficientSameCategory'
})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.localClusteringCoefficient.stream('myGraphLCC')
YIELD nodeId, localClusteringCoefficient
RETURN gds.util.asNode(nodeId).name AS name, localClusteringCoefficient
ORDER BY localClusteringCoefficient DESC, name;

// PASO 4: escribir atributo
CALL gds.localClusteringCoefficient.write(
    'myGraphLCC', 
    {
        writeProperty: 'clusteringCoefficientSameCategory'
    }
)
YIELD nodeCount, nodePropertiesWritten;

// PASO 5: comprobar el atributo clusteringCoeficient con el mayor y sus vecinos
MATCH (m:Movie)
ORDER BY m.clusteringCoefficientSameCategory
MATCH (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY]-(v:Movie)-[r2:WATCH_TOG_SAME_CATEGORY]-(v2:Movie)
RETURN m, r, v, r2, v2;


// WEAKLY CONNECTED COMPONENTS
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphWCC',
  'Movie',
  {WATCH_TOG_SAME_CATEGORY:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.wcc.write.estimate('myGraphWCC', { writeProperty: 'communityWCCSameCategory' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.wcc.stream('myGraphWCC')
YIELD nodeId, componentId
RETURN gds.util.asNode(nodeId).name AS name, componentId
ORDER BY componentId, name;

// PASO 4: escribir atributo
CALL gds.wcc.write('myGraphWCC', {writeProperty: 'communityWCCSameCategory'})
YIELD componentCount, componentDistribution;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.communityWCCSameCategory as numero_de_WCC,
    COUNT(m.title) AS Miembros
ORDER BY Miembros DESC;


// LABEL PROPAGATION (General)
// PASO 1: subgrafo
CALL gds.graph.project(
    'myGraphLP',
    'Movie',
    {WATCH_TOG_SAME_CATEGORY:
        {
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.labelPropagation.write.estimate('myGraphLP', { writeProperty: 'labelPropagationSameCategory' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.labelPropagation.stream('myGraphLP')
YIELD nodeId, communityId AS Community
RETURN gds.util.asNode(nodeId).name AS Name, Community
ORDER BY Community, Name;

// PASO 4: escribir atributo
CALL gds.labelPropagation.write('myGraphLP', {writeProperty: 'labelPropagationSameCategory'})
YIELD communityCount, ranIterations, didConverge;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.labelPropagationSameCategory as numero_de_comunidad,
    COLLECT(m.title) AS Miembros
ORDER BY numero_de_comunidad DESC;


// LOUVAIN MODULARITY
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphLM',
  'Movie',
  {WATCH_TOG_SAME_CATEGORY:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.louvain.write.estimate('myGraphLM', { writeProperty: 'louvainSameCategory' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.louvain.stream('myGraphLM')
YIELD nodeId, communityId, intermediateCommunityIds
RETURN gds.util.asNode(nodeId).name AS name, communityId
ORDER BY name ASC;

// PASO 4: escribir atributo
CALL gds.louvain.write('myGraphLM', {writeProperty: 'louvainSameCategory'})
YIELD communityCount, modularity, modularities;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.louvainSameCategory as numero_de_comunidad,
    COLLECT(m.title) AS Miembros
ORDER BY numero_de_comunidad DESC;


// Borramos los subgrafos
CALL gds.graph.drop('myGraphTr');
CALL gds.graph.drop('myGraphLCC');
CALL gds.graph.drop('myGraphWCC');
CALL gds.graph.drop('myGraphLP');
CALL gds.graph.drop('myGraphLM');





// RELACION (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY]->(m2:Movie)

// TRIANGLE COUNT
// PASO 1: Creamos el subgrafo:
CALL gds.graph.project(
    'myGraphTr',
    'Movie',
    {WATCH_TOG_SAME_COUNTRY:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.triangleCount.write.estimate(
    'myGraphTr', {writeProperty: 'trianglesSameCountry'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.triangleCount.stream('myGraphTr')
YIELD nodeId, triangleCount
RETURN gds.util.asNode(nodeId).name AS name, triangleCount
ORDER BY triangleCount DESC, name ASC;

// PASO 4: veamos que nodos pertenecen a un triangulo
CALL gds.triangleCount.write('myGraphTr', {
        writeProperty: 'trianglesSameCountry'
    }
)
YIELD globalTriangleCount, nodeCount;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.id AS ID,
    m.trianglesSameCountry as numero_de_triagulos
ORDER BY numero_de_triagulos DESC;


// LOCAL CLUSTERING COEFFICIENT
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphLCC',
  'Movie',
  {WATCH_TOG_SAME_COUNTRY:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.localClusteringCoefficient.write.estimate('myGraphLCC', {
  writeProperty: 'clusteringCoefficientSameCountry'
})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.localClusteringCoefficient.stream('myGraphLCC')
YIELD nodeId, localClusteringCoefficient
RETURN gds.util.asNode(nodeId).name AS name, localClusteringCoefficient
ORDER BY localClusteringCoefficient DESC, name;

// PASO 4: escribir atributo
CALL gds.localClusteringCoefficient.write(
    'myGraphLCC', 
    {
        writeProperty: 'clusteringCoefficientSameCountry'
    }
)
YIELD nodeCount, nodePropertiesWritten;

// PASO 5: comprobar el atributo clusteringCoeficient con el mayor y sus vecinos
MATCH (m:Movie)
ORDER BY m.clusteringCoefficientSameCountry
MATCH (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY]-(v:Movie)-[r2:WATCH_TOG_SAME_COUNTRY]-(v2:Movie)
RETURN m, r, v, r2, v2;


// WEAKLY CONNECTED COMPONENTS
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphWCC',
  'Movie',
  {WATCH_TOG_SAME_COUNTRY:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.wcc.write.estimate('myGraphWCC', { writeProperty: 'communityWCCSameCountry' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.wcc.stream('myGraphWCC')
YIELD nodeId, componentId
RETURN gds.util.asNode(nodeId).name AS name, componentId
ORDER BY componentId, name;

// PASO 4: escribir atributo
CALL gds.wcc.write('myGraphWCC', {writeProperty: 'communityWCCSameCountry'})
YIELD componentCount, componentDistribution;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.communityWCCSameCountry as numero_de_WCC,
    COUNT(m.title) AS Miembros
ORDER BY Miembros DESC;


// LABEL PROPAGATION (General)
// PASO 1: subgrafo
CALL gds.graph.project(
    'myGraphLP',
    'Movie',
    {WATCH_TOG_SAME_COUNTRY:
        {
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.labelPropagation.write.estimate('myGraphLP', { writeProperty: 'labelPropagationSameCountry' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.labelPropagation.stream('myGraphLP')
YIELD nodeId, communityId AS Community
RETURN gds.util.asNode(nodeId).name AS Name, Community
ORDER BY Community, Name;

// PASO 4: escribir atributo
CALL gds.labelPropagation.write('myGraphLP', {writeProperty: 'labelPropagationSameCountry'})
YIELD communityCount, ranIterations, didConverge;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.labelPropagationSameCountry as numero_de_comunidad,
    COLLECT(m.title) AS Miembros
ORDER BY numero_de_comunidad DESC;


// LOUVAIN MODULARITY
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphLM',
  'Movie',
  {WATCH_TOG_SAME_COUNTRY:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.louvain.write.estimate('myGraphLM', { writeProperty: 'louvainSameCountry' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.louvain.stream('myGraphLM')
YIELD nodeId, communityId, intermediateCommunityIds
RETURN gds.util.asNode(nodeId).name AS name, communityId
ORDER BY name ASC;

// PASO 4: escribir atributo
CALL gds.louvain.write('myGraphLM', {writeProperty: 'louvainSameCountry'})
YIELD communityCount, modularity, modularities;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.louvainSameCountry as numero_de_comunidad,
    COLLECT(m.title) AS Miembros
ORDER BY numero_de_comunidad DESC;


// Borramos los subgrafos
CALL gds.graph.drop('myGraphTr');
CALL gds.graph.drop('myGraphLCC');
CALL gds.graph.drop('myGraphWCC');
CALL gds.graph.drop('myGraphLP');
CALL gds.graph.drop('myGraphLM');





// RELACION (m:Movie)-[r:WATCH_TOG_SAME_ACTOR]->(m2:Movie)

// TRIANGLE COUNT
// PASO 1: Creamos el subgrafo:
CALL gds.graph.project(
    'myGraphTr',
    'Movie',
    {WATCH_TOG_SAME_ACTOR:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.triangleCount.write.estimate(
    'myGraphTr', {writeProperty: 'trianglesSameActor'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.triangleCount.stream('myGraphTr')
YIELD nodeId, triangleCount
RETURN gds.util.asNode(nodeId).name AS name, triangleCount
ORDER BY triangleCount DESC, name ASC;

// PASO 4: veamos que nodos pertenecen a un triangulo
CALL gds.triangleCount.write('myGraphTr', {
        writeProperty: 'trianglesSameActor'
    }
)
YIELD globalTriangleCount, nodeCount;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.id AS ID,
    m.trianglesSameActor as numero_de_triagulos
ORDER BY numero_de_triagulos DESC;


// LOCAL CLUSTERING COEFFICIENT
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphLCC',
  'Movie',
  {WATCH_TOG_SAME_ACTOR:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.localClusteringCoefficient.write.estimate('myGraphLCC', {
  writeProperty: 'clusteringCoefficientSameActor'
})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.localClusteringCoefficient.stream('myGraphLCC')
YIELD nodeId, localClusteringCoefficient
RETURN gds.util.asNode(nodeId).name AS name, localClusteringCoefficient
ORDER BY localClusteringCoefficient DESC, name;

// PASO 4: escribir atributo
CALL gds.localClusteringCoefficient.write(
    'myGraphLCC', 
    {
        writeProperty: 'clusteringCoefficientSameActor'
    }
)
YIELD nodeCount, nodePropertiesWritten;

// PASO 5: comprobar el atributo clusteringCoeficient con el mayor y sus vecinos
MATCH (m:Movie)
ORDER BY m.clusteringCoefficientSameActor
MATCH (m:Movie)-[r:WATCH_TOG_SAME_ACTOR]-(v:Movie)-[r2:WATCH_TOG_SAME_ACTOR]-(v2:Movie)
RETURN m, r, v, r2, v2;


// WEAKLY CONNECTED COMPONENTS
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphWCC',
  'Movie',
  {WATCH_TOG_SAME_ACTOR:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.wcc.write.estimate('myGraphWCC', { writeProperty: 'communityWCCSameActor' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.wcc.stream('myGraphWCC')
YIELD nodeId, componentId
RETURN gds.util.asNode(nodeId).name AS name, componentId
ORDER BY componentId, name;

// PASO 4: escribir atributo
CALL gds.wcc.write('myGraphWCC', {writeProperty: 'communityWCCSameActor'})
YIELD componentCount, componentDistribution;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.communityWCCSameActor as numero_de_WCC,
    COUNT(m.title) AS Miembros
ORDER BY Miembros DESC;


// LABEL PROPAGATION (General)
// PASO 1: subgrafo
CALL gds.graph.project(
    'myGraphLP',
    'Movie',
    {WATCH_TOG_SAME_ACTOR:
        {
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.labelPropagation.write.estimate('myGraphLP', { writeProperty: 'labelPropagationSameActor' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.labelPropagation.stream('myGraphLP')
YIELD nodeId, communityId AS Community
RETURN gds.util.asNode(nodeId).name AS Name, Community
ORDER BY Community, Name;

// PASO 4: escribir atributo
CALL gds.labelPropagation.write('myGraphLP', {writeProperty: 'labelPropagationSameActor'})
YIELD communityCount, ranIterations, didConverge;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.labelPropagationSameActor as numero_de_comunidad,
    COLLECT(m.title) AS Miembros
ORDER BY numero_de_comunidad DESC;


// LOUVAIN MODULARITY
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphLM',
  'Movie',
  {WATCH_TOG_SAME_ACTOR:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.louvain.write.estimate('myGraphLM', { writeProperty: 'louvainSameActor' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.louvain.stream('myGraphLM')
YIELD nodeId, communityId, intermediateCommunityIds
RETURN gds.util.asNode(nodeId).name AS name, communityId
ORDER BY name ASC;

// PASO 4: escribir atributo
CALL gds.louvain.write('myGraphLM', {writeProperty: 'louvainSameActor'})
YIELD communityCount, modularity, modularities;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.louvainSameActor as numero_de_comunidad,
    COLLECT(m.title) AS Miembros
ORDER BY numero_de_comunidad DESC;


// Borramos los subgrafos
CALL gds.graph.drop('myGraphTr');
CALL gds.graph.drop('myGraphLCC');
CALL gds.graph.drop('myGraphWCC');
CALL gds.graph.drop('myGraphLP');
CALL gds.graph.drop('myGraphLM');





// RELACION (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR]->(m2:Movie)

// TRIANGLE COUNT
// PASO 1: Creamos el subgrafo:
CALL gds.graph.project(
    'myGraphTr',
    'Movie',
    {WATCH_TOG_SAME_DIRECTOR:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.triangleCount.write.estimate(
    'myGraphTr', {writeProperty: 'trianglesSameDirector'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.triangleCount.stream('myGraphTr')
YIELD nodeId, triangleCount
RETURN gds.util.asNode(nodeId).name AS name, triangleCount
ORDER BY triangleCount DESC, name ASC;

// PASO 4: veamos que nodos pertenecen a un triangulo
CALL gds.triangleCount.write('myGraphTr', {
        writeProperty: 'trianglesSameDirector'
    }
)
YIELD globalTriangleCount, nodeCount;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.id AS ID,
    m.trianglesSameDirector as numero_de_triagulos
ORDER BY numero_de_triagulos DESC;


// LOCAL CLUSTERING COEFFICIENT
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphLCC',
  'Movie',
  {WATCH_TOG_SAME_DIRECTOR:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.localClusteringCoefficient.write.estimate('myGraphLCC', {
  writeProperty: 'clusteringCoefficientSameDirector'
})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.localClusteringCoefficient.stream('myGraphLCC')
YIELD nodeId, localClusteringCoefficient
RETURN gds.util.asNode(nodeId).name AS name, localClusteringCoefficient
ORDER BY localClusteringCoefficient DESC, name;

// PASO 4: escribir atributo
CALL gds.localClusteringCoefficient.write(
    'myGraphLCC', 
    {
        writeProperty: 'clusteringCoefficientSameDirector'
    }
)
YIELD nodeCount, nodePropertiesWritten;

// PASO 5: comprobar el atributo clusteringCoeficient con el mayor y sus vecinos
MATCH (m:Movie)
ORDER BY m.clusteringCoefficientSameDirector
MATCH (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR]-(v:Movie)-[r2:WATCH_TOG_SAME_DIRECTOR]-(v2:Movie)
RETURN m, r, v, r2, v2;


// WEAKLY CONNECTED COMPONENTS
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphWCC',
  'Movie',
  {WATCH_TOG_SAME_DIRECTOR:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.wcc.write.estimate('myGraphWCC', { writeProperty: 'communityWCCSameDirector' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.wcc.stream('myGraphWCC')
YIELD nodeId, componentId
RETURN gds.util.asNode(nodeId).name AS name, componentId
ORDER BY componentId, name;

// PASO 4: escribir atributo
CALL gds.wcc.write('myGraphWCC', {writeProperty: 'communityWCCSameDirector'})
YIELD componentCount, componentDistribution;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.communityWCCSameDirector as numero_de_WCC,
    COUNT(m.title) AS Miembros
ORDER BY Miembros DESC;


// LABEL PROPAGATION (General)
// PASO 1: subgrafo
CALL gds.graph.project(
    'myGraphLP',
    'Movie',
    {WATCH_TOG_SAME_DIRECTOR:
        {
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.labelPropagation.write.estimate('myGraphLP', { writeProperty: 'labelPropagationSameDirector' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.labelPropagation.stream('myGraphLP')
YIELD nodeId, communityId AS Community
RETURN gds.util.asNode(nodeId).name AS Name, Community
ORDER BY Community, Name;

// PASO 4: escribir atributo
CALL gds.labelPropagation.write('myGraphLP', {writeProperty: 'labelPropagationSameDirector'})
YIELD communityCount, ranIterations, didConverge;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.labelPropagationSameDirector as numero_de_comunidad,
    COLLECT(m.title) AS Miembros
ORDER BY numero_de_comunidad DESC;


// LOUVAIN MODULARITY
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphLM',
  'Movie',
  {WATCH_TOG_SAME_DIRECTOR:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.louvain.write.estimate('myGraphLM', { writeProperty: 'louvainSameDirector' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.louvain.stream('myGraphLM')
YIELD nodeId, communityId, intermediateCommunityIds
RETURN gds.util.asNode(nodeId).name AS name, communityId
ORDER BY name ASC;

// PASO 4: escribir atributo
CALL gds.louvain.write('myGraphLM', {writeProperty: 'louvainSameDirector'})
YIELD communityCount, modularity, modularities;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.louvainSameDirector as numero_de_comunidad,
    COLLECT(m.title) AS Miembros
ORDER BY numero_de_comunidad DESC;


// Borramos los subgrafos
CALL gds.graph.drop('myGraphTr');
CALL gds.graph.drop('myGraphLCC');
CALL gds.graph.drop('myGraphWCC');
CALL gds.graph.drop('myGraphLP');
CALL gds.graph.drop('myGraphLM');




// RELACION (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR]->(m2:Movie)

// TRIANGLE COUNT
// PASO 1: Creamos el subgrafo:
CALL gds.graph.project(
    'myGraphTr',
    'Movie',
    {WATCH_TOG_SAME_RELEASE_YEAR:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.triangleCount.write.estimate(
    'myGraphTr', {writeProperty: 'trianglesSameReleaseYear'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.triangleCount.stream('myGraphTr')
YIELD nodeId, triangleCount
RETURN gds.util.asNode(nodeId).name AS name, triangleCount
ORDER BY triangleCount DESC, name ASC;

// PASO 4: veamos que nodos pertenecen a un triangulo
CALL gds.triangleCount.write('myGraphTr', {
        writeProperty: 'trianglesSameReleaseYear'
    }
)
YIELD globalTriangleCount, nodeCount;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.id AS ID,
    m.trianglesSameReleaseYear as numero_de_triagulos
ORDER BY numero_de_triagulos DESC;


// LOCAL CLUSTERING COEFFICIENT
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphLCC',
  'Movie',
  {WATCH_TOG_SAME_RELEASE_YEAR:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.localClusteringCoefficient.write.estimate('myGraphLCC', {
  writeProperty: 'clusteringCoefficientSameReleaseYear'
})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.localClusteringCoefficient.stream('myGraphLCC')
YIELD nodeId, localClusteringCoefficient
RETURN gds.util.asNode(nodeId).name AS name, localClusteringCoefficient
ORDER BY localClusteringCoefficient DESC, name;

// PASO 4: escribir atributo
CALL gds.localClusteringCoefficient.write(
    'myGraphLCC', 
    {
        writeProperty: 'clusteringCoefficientSameReleaseYear'
    }
)
YIELD nodeCount, nodePropertiesWritten;

// PASO 5: comprobar el atributo clusteringCoeficient con el mayor y sus vecinos
MATCH (m:Movie)
ORDER BY m.clusteringCoefficientSameReleaseYear
MATCH (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR]-(v:Movie)-[r2:WATCH_TOG_SAME_RELEASE_YEAR]-(v2:Movie)
RETURN m, r, v, r2, v2;


// WEAKLY CONNECTED COMPONENTS
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphWCC',
  'Movie',
  {WATCH_TOG_SAME_RELEASE_YEAR:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.wcc.write.estimate('myGraphWCC', { writeProperty: 'communityWCCSameReleaseYear' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.wcc.stream('myGraphWCC')
YIELD nodeId, componentId
RETURN gds.util.asNode(nodeId).name AS name, componentId
ORDER BY componentId, name;

// PASO 4: escribir atributo
CALL gds.wcc.write('myGraphWCC', {writeProperty: 'communityWCCSameReleaseYear'})
YIELD componentCount, componentDistribution;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.communityWCCSameReleaseYear as numero_de_WCC,
    COUNT(m.title) AS Miembros
ORDER BY Miembros DESC;


// LABEL PROPAGATION (General)
// PASO 1: subgrafo
CALL gds.graph.project(
    'myGraphLP',
    'Movie',
    {WATCH_TOG_SAME_RELEASE_YEAR:
        {
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.labelPropagation.write.estimate('myGraphLP', { writeProperty: 'labelPropagationSameReleaseYear' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.labelPropagation.stream('myGraphLP')
YIELD nodeId, communityId AS Community
RETURN gds.util.asNode(nodeId).name AS Name, Community
ORDER BY Community, Name;

// PASO 4: escribir atributo
CALL gds.labelPropagation.write('myGraphLP', {writeProperty: 'labelPropagationSameReleaseYear'})
YIELD communityCount, ranIterations, didConverge;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.labelPropagationSameReleaseYear as numero_de_comunidad,
    COLLECT(m.title) AS Miembros
ORDER BY numero_de_comunidad DESC;


// LOUVAIN MODULARITY
// PASO 1: subgrafo
CALL gds.graph.project(
  'myGraphLM',
  'Movie',
  {WATCH_TOG_SAME_RELEASE_YEAR:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// PASO 2: calcular la memoria
CALL gds.louvain.write.estimate('myGraphLM', { writeProperty: 'louvainSameReleaseYear' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.louvain.stream('myGraphLM')
YIELD nodeId, communityId, intermediateCommunityIds
RETURN gds.util.asNode(nodeId).name AS name, communityId
ORDER BY name ASC;

// PASO 4: escribir atributo
CALL gds.louvain.write('myGraphLM', {writeProperty: 'louvainSameReleaseYear'})
YIELD communityCount, modularity, modularities;

// PASO 5: comprobar el atributo
MATCH (m:Movie)
RETURN m.louvainSameReleaseYear as numero_de_comunidad,
    COLLECT(m.title) AS Miembros
ORDER BY numero_de_comunidad DESC;
