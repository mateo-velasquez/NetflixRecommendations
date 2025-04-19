//-------------------------------------- Algoritmos de Centralidad ---------------------------------------


// RELACIONES ELEGIDAS:
// (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_ACTOR]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR]->(m2:Movie)



// RELACIÓN (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)

// DEGREE CENTRALITY
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
    'myGraphDEG',
    'Movie',
    {WATCH_TOG_SAME_CATEGORY:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// Paso 2: Calculo la memoria necesaria:
CALL gds.degree.write.estimate(
    'myGraphDEG', {writeProperty: 'degreeSameCategory'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo:
CALL gds.degree.stream(
    'myGraphDEG'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).id AS id, gds.util.asNode(nodeId).name AS Movie, score
ORDER BY score DESC, Movie ASC;

// Paso 4: Implementamos
CALL gds.degree.write('myGraphDEG', { writeProperty: 'degreeSameCategory' })
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimumScore, centralityDistribution.mean AS meanScore,
centralityDistribution.max AS maxScore, nodePropertiesWritten;

// Paso 5: Probamos
MATCH(m:Movie)
RETURN m.name AS producto,
    m.degreeSameCategory AS Grado
ORDER BY Grado DESC;


// CLOSENESS CENTRALITY
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
    'myGraphCC',
    'Movie',
    'WATCH_TOG_SAME_CATEGORY'
);

// PASO 2: calcular la memoria
CALL gds.closeness.write.estimate(
    'myGraphCC', { writeProperty: 'closenessSameCategory' }
)
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.closeness.stream(
    'myGraphCC'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).Name AS Name, score
ORDER BY score DESC, Name ASC;

// PASO 4: añadir el atributo
CALL gds.closeness.write('myGraphCC', {writeProperty: 'closenessSameCategory'})
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimumScore,
        centralityDistribution.max AS maxScore,
        centralityDistribution.mean AS meanScore,
        nodePropertiesWritten;

// PASO 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.closenessSameCategory AS closenessSameCategory
ORDER BY closenessSameCategory DESC;   


// BETWEENNESS CENTRALITY:
// PASO 1:
CALL gds.graph.project(
    'myGraphBC',
    'Movie',
    'WATCH_TOG_SAME_CATEGORY'
);

// PASO 2: calcular la memoria
CALL gds.betweenness.write.estimate(
    'myGraphBC', {writeProperty: 'betweennessSameCategory'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.betweenness.stream('myGraphBC')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).name AS name, score
ORDER BY score DESC, name ASC;

// PASO 4: Escribimos el resultado como un atributo extra en cada nodo
CALL gds.betweenness.write('myGraphBC', {writeProperty: "betweennessSameCategory"})
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimunScore,
        centralityDistribution.mean AS meanScore,
        centralityDistribution.max AS maxScore,
        nodePropertiesWritten;

// PASO 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.betweennessSameCategory AS betweennessSameCategory
ORDER BY betweennessSameCategory DESC;  


// PAGERANK:
//PASO 1: Creamos el subgrafo:
CALL gds.graph.project(
    'myGraphPR',
    'Movie',
    'WATCH_TOG_SAME_CATEGORY'
);

// PASO 2: calcular la memoria
// Aca estamos calculando el pageRank
CALL gds.pageRank.write.estimate(
    'myGraphPR', {
        writeProperty: 'pagerankSameCategory', 
        maxIterations: 20,
        dampingFactor: 0.85}
)
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.pageRank.stream(
    'myGraphPR'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).Name AS Name, score
ORDER BY score DESC, Name ASC;

// PASO 4: añadir el atributo
CALL gds.pageRank.write(
    'myGraphPR',
    {
        maxIterations: 20,
        dampingFactor: 0.85,
        writeProperty: 'pagerankSameCategory'
    }
)
YIELD nodePropertiesWritten, ranIterations;

// Paso 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.pagerankSameCategory AS pageRank
ORDER BY pageRank DESC;  

// Borramos los subgrafos
CALL gds.graph.drop('myGraphDEG');
CALL gds.graph.drop('myGraphCC');
CALL gds.graph.drop('myGraphBC');
CALL gds.graph.drop('myGraphPR');




// RELACIÓN (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY]->(m2:Movie)

// DEGREE CENTRALITY
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
    'myGraphDEG',
    'Movie',
    {WATCH_TOG_SAME_COUNTRY:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// Paso 2: Calculo la memoria necesaria:
CALL gds.degree.write.estimate(
    'myGraphDEG', {writeProperty: 'degreeSameCountry'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo:
CALL gds.degree.stream(
    'myGraphDEG'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).id AS id, gds.util.asNode(nodeId).name AS Movie, score
ORDER BY score DESC, Movie ASC;

// Paso 4: Implementamos
CALL gds.degree.write('myGraphDEG', { writeProperty: 'degreeSameCountry' })
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimumScore, centralityDistribution.mean AS meanScore,
centralityDistribution.max AS maxScore, nodePropertiesWritten;

// Paso 5: Probamos
MATCH(m:Movie)
RETURN m.name AS producto,
    m.degreeSameCountry AS Grado
ORDER BY Grado DESC;


// CLOSENESS CENTRALITY
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
    'myGraphCC',
    'Movie',
    'WATCH_TOG_SAME_COUNTRY'
);

// PASO 2: calcular la memoria
CALL gds.closeness.write.estimate(
    'myGraphCC', { writeProperty: 'closenessSameCountry' }
)
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.closeness.stream(
    'myGraphCC'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).Name AS Name, score
ORDER BY score DESC, Name ASC;

// PASO 4: añadir el atributo
CALL gds.closeness.write('myGraphCC', {writeProperty: 'closenessSameCountry'})
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimumScore,
        centralityDistribution.max AS maxScore,
        centralityDistribution.mean AS meanScore,
        nodePropertiesWritten;

// PASO 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.closenessSameCountry AS closenessSameCountry
ORDER BY closenessSameCountry DESC;   


// BETWEENNESS CENTRALITY:
// PASO 1:
CALL gds.graph.project(
    'myGraphBC',
    'Movie',
    'WATCH_TOG_SAME_COUNTRY'
);

// PASO 2: calcular la memoria
CALL gds.betweenness.write.estimate(
    'myGraphBC', {writeProperty: 'betweennessSameCountry'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.betweenness.stream('myGraphBC')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).name AS name, score
ORDER BY score DESC, name ASC;

// PASO 4: Escribimos el resultado como un atributo extra en cada nodo
CALL gds.betweenness.write('myGraphBC', {writeProperty: "betweennessSameCountry"})
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimunScore,
        centralityDistribution.mean AS meanScore,
        centralityDistribution.max AS maxScore,
        nodePropertiesWritten;

// PASO 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.betweennessSameCountry AS betweennessSameCountry
ORDER BY betweennessSameCountry DESC;  


// PAGERANK:
//PASO 1: Creamos el subgrafo:
CALL gds.graph.project(
    'myGraphPR',
    'Movie',
    'WATCH_TOG_SAME_COUNTRY'
);

// PASO 2: calcular la memoria
// Aca estamos calculando el pageRank
CALL gds.pageRank.write.estimate(
    'myGraphPR', {
        writeProperty: 'pagerankSameCountry', 
        maxIterations: 20,
        dampingFactor: 0.85}
)
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.pageRank.stream(
    'myGraphPR'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).Name AS Name, score
ORDER BY score DESC, Name ASC;

// PASO 4: añadir el atributo
CALL gds.pageRank.write(
    'myGraphPR',
    {
        maxIterations: 20,
        dampingFactor: 0.85,
        writeProperty: 'pagerankSameCountry'
    }
)
YIELD nodePropertiesWritten, ranIterations;

// Paso 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.pagerankSameCountry AS pageRank
ORDER BY pageRank DESC;  

// Borramos los subgrafos
CALL gds.graph.drop('myGraphDEG');
CALL gds.graph.drop('myGraphCC');
CALL gds.graph.drop('myGraphBC');
CALL gds.graph.drop('myGraphPR');




// RELACIÓN (m:Movie)-[r:WATCH_TOG_SAME_ACTOR]->(m2:Movie)

// DEGREE CENTRALITY
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
    'myGraphDEG',
    'Movie',
    {WATCH_TOG_SAME_ACTOR:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// Paso 2: Calculo la memoria necesaria:
CALL gds.degree.write.estimate(
    'myGraphDEG', {writeProperty: 'degreeSameActor'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo:
CALL gds.degree.stream(
    'myGraphDEG'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).id AS id, gds.util.asNode(nodeId).name AS Movie, score
ORDER BY score DESC, Movie ASC;

// Paso 4: Implementamos
CALL gds.degree.write('myGraphDEG', { writeProperty: 'degreeSameActor' })
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimumScore, centralityDistribution.mean AS meanScore,
centralityDistribution.max AS maxScore, nodePropertiesWritten;

// Paso 5: Probamos
MATCH(m:Movie)
RETURN m.name AS producto,
    m.degreeSameActor AS Grado
ORDER BY Grado DESC;


// CLOSENESS CENTRALITY
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
    'myGraphCC',
    'Movie',
    'WATCH_TOG_SAME_ACTOR'
);

// PASO 2: calcular la memoria
CALL gds.closeness.write.estimate(
    'myGraphCC', { writeProperty: 'closenessSameActor' }
)
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.closeness.stream(
    'myGraphCC'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).Name AS Name, score
ORDER BY score DESC, Name ASC;

// PASO 4: añadir el atributo
CALL gds.closeness.write('myGraphCC', {writeProperty: 'closenessSameActor'})
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimumScore,
        centralityDistribution.max AS maxScore,
        centralityDistribution.mean AS meanScore,
        nodePropertiesWritten;

// PASO 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.closenessSameActor AS closenessSameActor
ORDER BY closenessSameActor DESC;   


// BETWEENNESS CENTRALITY:
// PASO 1:
CALL gds.graph.project(
    'myGraphBC',
    'Movie',
    'WATCH_TOG_SAME_ACTOR'
);

// PASO 2: calcular la memoria
CALL gds.betweenness.write.estimate(
    'myGraphBC', {writeProperty: 'betweennessSameActor'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.betweenness.stream('myGraphBC')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).name AS name, score
ORDER BY score DESC, name ASC;

// PASO 4: Escribimos el resultado como un atributo extra en cada nodo
CALL gds.betweenness.write('myGraphBC', {writeProperty: "betweennessSameActor"})
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimunScore,
        centralityDistribution.mean AS meanScore,
        centralityDistribution.max AS maxScore,
        nodePropertiesWritten;

// PASO 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.betweennessSameActor AS betweennessSameActor
ORDER BY betweennessSameActor DESC;  


// PAGERANK:
//PASO 1: Creamos el subgrafo:
CALL gds.graph.project(
    'myGraphPR',
    'Movie',
    'WATCH_TOG_SAME_ACTOR'
);

// PASO 2: calcular la memoria
// Aca estamos calculando el pageRank
CALL gds.pageRank.write.estimate(
    'myGraphPR', {
        writeProperty: 'pagerankSameActor', 
        maxIterations: 20,
        dampingFactor: 0.85}
)
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.pageRank.stream(
    'myGraphPR'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).Name AS Name, score
ORDER BY score DESC, Name ASC;

// PASO 4: añadir el atributo
CALL gds.pageRank.write(
    'myGraphPR',
    {
        maxIterations: 20,
        dampingFactor: 0.85,
        writeProperty: 'pagerankSameActor'
    }
)
YIELD nodePropertiesWritten, ranIterations;

// Paso 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.pagerankSameActor AS pageRank
ORDER BY pageRank DESC;  

// Borramos los subgrafos
CALL gds.graph.drop('myGraphDEG');
CALL gds.graph.drop('myGraphCC');
CALL gds.graph.drop('myGraphBC');
CALL gds.graph.drop('myGraphPR');




// RELACIÓN (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR]->(m2:Movie)

// DEGREE CENTRALITY
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
    'myGraphDEG',
    'Movie',
    {WATCH_TOG_SAME_DIRECTOR:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// Paso 2: Calculo la memoria necesaria:
CALL gds.degree.write.estimate(
    'myGraphDEG', {writeProperty: 'degreeSameDirector'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo:
CALL gds.degree.stream(
    'myGraphDEG'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).id AS id, gds.util.asNode(nodeId).name AS Movie, score
ORDER BY score DESC, Movie ASC;

// Paso 4: Implementamos
CALL gds.degree.write('myGraphDEG', { writeProperty: 'degreeSameDirector' })
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimumScore, centralityDistribution.mean AS meanScore,
centralityDistribution.max AS maxScore, nodePropertiesWritten;

// Paso 5: Probamos
MATCH(m:Movie)
RETURN m.name AS producto,
    m.degreeSameDirector AS Grado
ORDER BY Grado DESC;


// CLOSENESS CENTRALITY
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
    'myGraphCC',
    'Movie',
    'WATCH_TOG_SAME_DIRECTOR'
);

// PASO 2: calcular la memoria
CALL gds.closeness.write.estimate(
    'myGraphCC', { writeProperty: 'closenessSameDirector' }
)
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.closeness.stream(
    'myGraphCC'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).Name AS Name, score
ORDER BY score DESC, Name ASC;

// PASO 4: añadir el atributo
CALL gds.closeness.write('myGraphCC', {writeProperty: 'closenessSameDirector'})
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimumScore,
        centralityDistribution.max AS maxScore,
        centralityDistribution.mean AS meanScore,
        nodePropertiesWritten;

// PASO 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.closenessSameDirector AS closenessSameDirector
ORDER BY closenessSameDirector DESC;   


// BETWEENNESS CENTRALITY:
// PASO 1:
CALL gds.graph.project(
    'myGraphBC',
    'Movie',
    'WATCH_TOG_SAME_DIRECTOR'
);

// PASO 2: calcular la memoria
CALL gds.betweenness.write.estimate(
    'myGraphBC', {writeProperty: 'betweennessSameDirector'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.betweenness.stream('myGraphBC')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).name AS name, score
ORDER BY score DESC, name ASC;

// PASO 4: Escribimos el resultado como un atributo extra en cada nodo
CALL gds.betweenness.write('myGraphBC', {writeProperty: "betweennessSameDirector"})
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimunScore,
        centralityDistribution.mean AS meanScore,
        centralityDistribution.max AS maxScore,
        nodePropertiesWritten;

// PASO 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.betweennessSameDirector AS betweennessSameDirector
ORDER BY betweennessSameDirector DESC;  


// PAGERANK:
//PASO 1: Creamos el subgrafo:
CALL gds.graph.project(
    'myGraphPR',
    'Movie',
    'WATCH_TOG_SAME_DIRECTOR'
);

// PASO 2: calcular la memoria
// Aca estamos calculando el pageRank
CALL gds.pageRank.write.estimate(
    'myGraphPR', {
        writeProperty: 'pagerankSameDirector', 
        maxIterations: 20,
        dampingFactor: 0.85}
)
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.pageRank.stream(
    'myGraphPR'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).Name AS Name, score
ORDER BY score DESC, Name ASC;

// PASO 4: añadir el atributo
CALL gds.pageRank.write(
    'myGraphPR',
    {
        maxIterations: 20,
        dampingFactor: 0.85,
        writeProperty: 'pagerankSameDirector'
    }
)
YIELD nodePropertiesWritten, ranIterations;

// Paso 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.pagerankSameDirector AS pageRank
ORDER BY pageRank DESC;  

// Borramos los subgrafos
CALL gds.graph.drop('myGraphDEG');
CALL gds.graph.drop('myGraphCC');
CALL gds.graph.drop('myGraphBC');
CALL gds.graph.drop('myGraphPR');




// RELACIÓN (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR]->(m2:Movie)

// DEGREE CENTRALITY
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
    'myGraphDEG',
    'Movie',
    {WATCH_TOG_SAME_RELEASE_YEAR:
        {
            orientation: 'UNDIRECTED'
        }
    }
);

// Paso 2: Calculo la memoria necesaria:
CALL gds.degree.write.estimate(
    'myGraphDEG', {writeProperty: 'degreeSameReleaseYear'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo:
CALL gds.degree.stream(
    'myGraphDEG'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).id AS id, gds.util.asNode(nodeId).name AS Movie, score
ORDER BY score DESC, Movie ASC;

// Paso 4: Implementamos
CALL gds.degree.write('myGraphDEG', { writeProperty: 'degreeSameReleaseYear' })
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimumScore, centralityDistribution.mean AS meanScore,
centralityDistribution.max AS maxScore, nodePropertiesWritten;

// Paso 5: Probamos
MATCH(m:Movie)
RETURN m.name AS producto,
    m.degreeSameReleaseYear AS Grado
ORDER BY Grado DESC;


// CLOSENESS CENTRALITY
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
    'myGraphCC',
    'Movie',
    'WATCH_TOG_SAME_RELEASE_YEAR'
);

// PASO 2: calcular la memoria
CALL gds.closeness.write.estimate(
    'myGraphCC', { writeProperty: 'closenessSameReleaseYear' }
)
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.closeness.stream(
    'myGraphCC'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).Name AS Name, score
ORDER BY score DESC, Name ASC;

// PASO 4: añadir el atributo
CALL gds.closeness.write('myGraphCC', {writeProperty: 'closenessSameReleaseYear'})
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimumScore,
        centralityDistribution.max AS maxScore,
        centralityDistribution.mean AS meanScore,
        nodePropertiesWritten;

// PASO 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.closenessSameReleaseYear AS closenessSameReleaseYear
ORDER BY closenessSameReleaseYear DESC;   


// BETWEENNESS CENTRALITY:
// PASO 1:
CALL gds.graph.project(
    'myGraphBC',
    'Movie',
    'WATCH_TOG_SAME_RELEASE_YEAR'
);

// PASO 2: calcular la memoria
CALL gds.betweenness.write.estimate(
    'myGraphBC', {writeProperty: 'betweennessSameReleaseYear'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.betweenness.stream('myGraphBC')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).name AS name, score
ORDER BY score DESC, name ASC;

// PASO 4: Escribimos el resultado como un atributo extra en cada nodo
CALL gds.betweenness.write('myGraphBC', {writeProperty: "betweennessSameReleaseYear"})
YIELD centralityDistribution, nodePropertiesWritten
RETURN centralityDistribution.min AS minimunScore,
        centralityDistribution.mean AS meanScore,
        centralityDistribution.max AS maxScore,
        nodePropertiesWritten;

// PASO 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.betweennessSameReleaseYear AS betweennessSameReleaseYear
ORDER BY betweennessSameReleaseYear DESC;  


// PAGERANK:
//PASO 1: Creamos el subgrafo:
CALL gds.graph.project(
    'myGraphPR',
    'Movie',
    'WATCH_TOG_SAME_RELEASE_YEAR'
);

// PASO 2: calcular la memoria
// Aca estamos calculando el pageRank
CALL gds.pageRank.write.estimate(
    'myGraphPR', {
        writeProperty: 'pagerankSameReleaseYear', 
        maxIterations: 20,
        dampingFactor: 0.85}
)
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo
CALL gds.pageRank.stream(
    'myGraphPR'
)
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).Name AS Name, score
ORDER BY score DESC, Name ASC;

// PASO 4: añadir el atributo
CALL gds.pageRank.write(
    'myGraphPR',
    {
        maxIterations: 20,
        dampingFactor: 0.85,
        writeProperty: 'pagerankSameReleaseYear'
    }
)
YIELD nodePropertiesWritten, ranIterations;

// Paso 5: Verificar
MATCH(m:Movie)
RETURN m.name AS producto,
    m.pagerankSameReleaseYear AS pageRank
ORDER BY pageRank DESC;  



