//-------------------------------------- Algoritmos de Similaridad ---------------------------------------

// RELACIONES ELEGIDAS:
// (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_ACTOR]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR]->(m2:Movie)


// FILTERED NODE SIMILARITY

// RELACIÓN (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
  'myGraphSameCategory',
  'Movie',
  {WATCH_TOG_SAME_CATEGORY:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// Paso 2: Calculo la memoria necesaria:
CALL gds.nodeSimilarity.filtered.write.estimate('myGraphSameCategory', {
    writeRelationshipType: 'SIMILAR_CATEGORY',
    writeProperty: 'score',
    sourceNodeFilter:'Movie',
    targetNodeFilter:'Movie'
})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// Paso 3: Aplicamos el algoritmo:
CALL gds.nodeSimilarity.filtered.stream('myGraphSameCategory', {sourceNodeFilter:'Movie' , targetNodeFilter:'Movie' } )
YIELD node1, node2, similarity
RETURN gds.util.asNode(node1).title AS Movie1, gds.util.asNode(node2).title AS Movie2, similarity
ORDER BY similarity DESCENDING, Movie1, Movie2;

// Paso 4: Implementamos
CALL gds.nodeSimilarity.filtered.write('myGraphSameCategory',{
    writeRelationshipType: 'SIMILAR_CATEGORY',
    writeProperty: 'score',
    sourceNodeFilter:'Movie',
    targetNodeFilter:'Movie'
})
YIELD nodesCompared, relationshipsWritten;

// Paso 5: Probamos
MATCH (m:Movie)-[r:SIMILAR_CATEGORY]->(m2:Movie)
RETURN m.title AS Movie1, m2.title AS Movie2, r.score AS SimilarityScore
ORDER BY r.score DESC;


// RELACIÓN (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY]->(m2:Movie)
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
  'myGraphSameCountry',
  'Movie',
  {WATCH_TOG_SAME_COUNTRY:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// Paso 2: Calculo la memoria necesaria:
CALL gds.nodeSimilarity.filtered.write.estimate('myGraphSameCountry', {
    writeRelationshipType: 'SIMILAR_COUNTRY',
    writeProperty: 'score',
    sourceNodeFilter:'Movie',
    targetNodeFilter:'Movie'
})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// Paso 3: Aplicamos el algoritmo:
CALL gds.nodeSimilarity.filtered.stream('myGraphSameCountry', {sourceNodeFilter:'Movie' , targetNodeFilter:'Movie' } )
YIELD node1, node2, similarity
RETURN gds.util.asNode(node1).title AS Movie1, gds.util.asNode(node2).title AS Movie2, similarity
ORDER BY similarity DESCENDING, Movie1, Movie2;

// Paso 4: Implementamos
CALL gds.nodeSimilarity.filtered.write('myGraphSameCountry',{
    writeRelationshipType: 'SIMILAR_COUNTRY',
    writeProperty: 'score',
    sourceNodeFilter:'Movie',
    targetNodeFilter:'Movie'
})
YIELD nodesCompared, relationshipsWritten;

// Paso 5: Probamos
MATCH (m:Movie)-[r:SIMILAR_COUNTRY]->(m2:Movie)
RETURN m.title AS Movie1, m2.title AS Movie2, r.score AS SimilarityScore
ORDER BY r.score DESC;


// RELACIÓN (m:Movie)-[r:WATCH_TOG_SAME_ACTOR]->(m2:Movie)
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
  'myGraphSameActor',
  'Movie',
  {WATCH_TOG_SAME_ACTOR:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// Paso 2: Calculo la memoria necesaria:
CALL gds.nodeSimilarity.filtered.write.estimate('myGraphSameActor', {
    writeRelationshipType: 'SIMILAR_ACTOR',
    writeProperty: 'score',
    sourceNodeFilter:'Movie',
    targetNodeFilter:'Movie'
})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo:
CALL gds.nodeSimilarity.filtered.stream('myGraphSameActor', {sourceNodeFilter:'Movie' , targetNodeFilter:'Movie' } )
YIELD node1, node2, similarity
RETURN gds.util.asNode(node1).title AS Movie1, gds.util.asNode(node2).title AS Movie2, similarity
ORDER BY similarity DESCENDING, Movie1, Movie2;

// Paso 4: Implementamos
CALL gds.nodeSimilarity.filtered.write('myGraphSameActor',{
    writeRelationshipType: 'SIMILAR_ACTOR',
    writeProperty: 'score',
    sourceNodeFilter:'Movie',
    targetNodeFilter:'Movie'
})
YIELD nodesCompared, relationshipsWritten;

// Paso 5: Probamos
MATCH (m:Movie)-[r:SIMILAR_ACTOR]->(m2:Movie)
RETURN m.title AS Movie1, m2.title AS Movie2, r.score AS SimilarityScore
ORDER BY r.score DESC;


// RELACIÓN (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR]->(m2:Movie)
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
  'myGraphSameDirector',
  'Movie',
  {WATCH_TOG_SAME_DIRECTOR:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// Paso 2: Calculo la memoria necesaria:
CALL gds.nodeSimilarity.filtered.write.estimate('myGraphSameDirector', {
    writeRelationshipType: 'SIMILAR_DIRECTOR',
    writeProperty: 'score',
    sourceNodeFilter:'Movie',
    targetNodeFilter:'Movie'
})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// Paso 3: Aplicamos el algoritmo:
CALL gds.nodeSimilarity.filtered.stream('myGraphSameDirector', {sourceNodeFilter:'Movie' , targetNodeFilter:'Movie' } )
YIELD node1, node2, similarity
RETURN gds.util.asNode(node1).title AS Movie1, gds.util.asNode(node2).title AS Movie2, similarity
ORDER BY similarity DESCENDING, Movie1, Movie2;

// Paso 4: Implementamos
CALL gds.nodeSimilarity.filtered.write('myGraphSameDirector',{
    writeRelationshipType: 'SIMILAR_DIRECTOR',
    writeProperty: 'score',
    sourceNodeFilter:'Movie',
    targetNodeFilter:'Movie'
})
YIELD nodesCompared, relationshipsWritten;

// Paso 5: Probamos
MATCH (m:Movie)-[r:SIMILAR_DIRECTOR]->(m2:Movie)
RETURN m.title AS Movie1, m2.title AS Movie2, r.score AS SimilarityScore
ORDER BY r.score DESC;


// RELACIÓN (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR]->(m2:Movie)
// PASO 1: Creamos el subgrafo
CALL gds.graph.project(
  'myGraphSameReleaseYear',
  'Movie',
  {WATCH_TOG_SAME_RELEASE_YEAR:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// Paso 2: Calculo la memoria necesaria:
CALL gds.nodeSimilarity.filtered.write.estimate('myGraphSameReleaseYear', {
    writeRelationshipType: 'SIMILAR_RELEASE_YEAR',
    writeProperty: 'score',
    sourceNodeFilter:'Movie',
    targetNodeFilter:'Movie'
})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// Paso 3: Aplicamos el algoritmo:
CALL gds.nodeSimilarity.filtered.stream('myGraphSameReleaseYear', {sourceNodeFilter:'Movie' , targetNodeFilter:'Movie' } )
YIELD node1, node2, similarity
RETURN gds.util.asNode(node1).title AS Movie1, gds.util.asNode(node2).title AS Movie2, similarity
ORDER BY similarity DESCENDING, Movie1, Movie2;

// Paso 4: Implementamos
CALL gds.nodeSimilarity.filtered.write('myGraphSameReleaseYear',{
    writeRelationshipType: 'SIMILAR_RELEASE_YEAR',
    writeProperty: 'score',
    sourceNodeFilter:'Movie',
    targetNodeFilter:'Movie'
})
YIELD nodesCompared, relationshipsWritten;

// Paso 5: Probamos
MATCH (m:Movie)-[r:SIMILAR_RELEASE_YEAR]->(m2:Movie)
RETURN m.title AS Movie1, m2.title AS Movie2, r.score AS SimilarityScore
ORDER BY r.score DESC;


// COMBINACIÒN DE RELACIONES 
// (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_ACTOR]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR]->(m2:Movie)
// (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR]->(m2:Movie)

CALL gds.graph.project(
  'myGraphAll',
  'Movie',
  {WATCH_TOG_SAME_CATEGORY:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        },
    WATCH_TOG_SAME_COUNTRY:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        },
    WATCH_TOG_SAME_ACTOR:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        },
    WATCH_TOG_SAME_DIRECTOR:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        },
    WATCH_TOG_SAME_RELEASE_YEAR:
        {
            orientation: 'UNDIRECTED',
            Properties: 'quantity'
        }
    }
);

// Paso 2: Calculo la memoria necesaria:
CALL gds.nodeSimilarity.filtered.write.estimate('myGraphAll', {
    writeRelationshipType: 'SIMILAR_ALL',
    writeProperty: 'score',
    sourceNodeFilter:'Movie',
    targetNodeFilter:'Movie'
})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory;

// PASO 3: Aplicamos el algoritmo:
CALL gds.nodeSimilarity.filtered.stream('myGraphAll', {sourceNodeFilter:'Movie' , targetNodeFilter:'Movie' } )
YIELD node1, node2, similarity
RETURN gds.util.asNode(node1).title AS Movie1, gds.util.asNode(node2).title AS Movie2, similarity
ORDER BY similarity DESCENDING, Movie1, Movie2;

// Paso 4: Implementamos
CALL gds.nodeSimilarity.filtered.write('myGraphAll',{
    writeRelationshipType: 'SIMILAR_ALL',
    writeProperty: 'score',
    sourceNodeFilter:'Movie',
    targetNodeFilter:'Movie'
})
YIELD nodesCompared, relationshipsWritten;

// Paso 5: Probamos
MATCH (m:Movie)-[r:SIMILAR_ALL]->(m2:Movie)
RETURN m.title AS Movie1, m2.title AS Movie2, r.score AS SimilarityScore
ORDER BY r.score DESC;