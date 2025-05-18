// Archivo para el segundo tablero de CQL:

// Recomendaciones para la Relación: (m:Movie)-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)

// Centralidad:
WITH $neodash_movie_title AS ParamTITLE
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WITH ParamTITLE, m2 ORDER BY m2.closenessSameCategory DESC
WITH ParamTITLE, collect(m2)[0] AS m_closeness

WITH ParamTITLE, m_closeness
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_closeness.title
WITH ParamTITLE, m_closeness, m2 ORDER BY m2.betweennessSameCategory DESC
WITH ParamTITLE, m_closeness, collect(m2)[0] AS m_between

WITH ParamTITLE, m_closeness, m_between
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_closeness.title AND m2.title <> m_between.title
WITH m_closeness, m_between, m2 ORDER BY m2.pagerankSameCategory DESC
WITH m_closeness, m_between, collect(m2)[0] AS m_pagerank

WITH [
  {
    title: m_closeness.title,
    Parametro: "closenessSameCategory"
  },
  {
    title: m_between.title,
    Parametro: "betweennessSameCategory"
  },
  {
    title: m_pagerank.title,
    Parametro: "pagerankSameCategory"
  }
] AS recomendaciones

UNWIND recomendaciones AS rec
RETURN rec.title AS title,
    rec.Parametro AS Parametro;


// Comunidad
WITH $neodash_movie_title AS ParamTITLE
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m.communityWCCSameCategory = m2.communityWCCSameCategory
WITH ParamTITLE, m2 ORDER BY m2.trianglesSameCategory DESC
WITH ParamTITLE, collect(m2)[0] AS m_trianglesWCC

WITH ParamTITLE, m_trianglesWCC
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_trianglesWCC.title AND m.louvainSameCategory = m2.louvainSameCategory
WITH ParamTITLE, m_trianglesWCC, m2 ORDER BY m2.trianglesSameCategory DESC
WITH ParamTITLE, m_trianglesWCC, collect(m2)[0] AS m_louvainTriangle

WITH ParamTITLE, m_trianglesWCC, m_louvainTriangle
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_trianglesWCC.title AND m2.title <> m_louvainTriangle.title 
    AND m.labelPropagationSameCategory = m2.labelPropagationSameCategory
WITH m_trianglesWCC, m_louvainTriangle, m2 ORDER BY m2.trianglesSameCategory DESC
WITH m_trianglesWCC, m_louvainTriangle, collect(m2)[0] AS m_labeltriangles

WITH [
  {
    title: m_trianglesWCC.title,
    Parametro: "CommunitySameCategory"
  },
  {
    title: m_louvainTriangle.title,
    Parametro: "CommunitySameCategory"
  },
  {
    title: m_labeltriangles.title,
    Parametro: "CommunitySameCategory"
  }
] AS recomendaciones

UNWIND recomendaciones AS rec
RETURN rec.title AS title,
    rec.Parametro AS Parametro;

// Similaridad:
MATCH (m:Movie{title:$neodash_movie_title})-[r:SIMILAR_CATEGORY]->(m2:Movie)
ORDER BY r.score DESC
LIMIT 3
RETURN m2.title AS title,
    "SimilarSameCategory" AS Parametro;


// Recomendaciones para la Relación: (m:Movie)-[r:WATCH_TOG_SAME_COUNTRY]->(m2:Movie)

// Centralidad:
WITH $neodash_movie_title AS ParamTITLE
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WITH ParamTITLE, m2 ORDER BY m2.closenessSameCountry DESC
WITH ParamTITLE, collect(m2)[0] AS m_closeness

WITH ParamTITLE, m_closeness
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_closeness.title
WITH ParamTITLE, m_closeness, m2 ORDER BY m2.betweennessSameCountry DESC
WITH ParamTITLE, m_closeness, collect(m2)[0] AS m_between

WITH ParamTITLE, m_closeness, m_between
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_closeness.title AND m2.title <> m_between.title
WITH m_closeness, m_between, m2 ORDER BY m2.pagerankSameCountry DESC
WITH m_closeness, m_between, collect(m2)[0] AS m_pagerank

WITH [
  {
    title: m_closeness.title,
    Parametro: "closenessSameCountry"
  },
  {
    title: m_between.title,
    Parametro: "betweennessSameCountry"
  },
  {
    title: m_pagerank.title,
    Parametro: "pagerankSameCountry"
  }
] AS recomendaciones

UNWIND recomendaciones AS rec
RETURN rec.title AS title,
    rec.Parametro AS Parametro;


// Comunidad
WITH $neodash_movie_title AS ParamTITLE
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m.communityWCCSameCountry = m2.communityWCCSameCountry
WITH ParamTITLE, m2 ORDER BY m2.trianglesSameCountry DESC
WITH ParamTITLE, collect(m2)[0] AS m_trianglesWCC

WITH ParamTITLE, m_trianglesWCC
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_trianglesWCC.title AND m.louvainSameCountry = m2.louvainSameCountry
WITH ParamTITLE, m_trianglesWCC, m2 ORDER BY m2.trianglesSameCountry DESC
WITH ParamTITLE, m_trianglesWCC, collect(m2)[0] AS m_louvainTriangle

WITH ParamTITLE, m_trianglesWCC, m_louvainTriangle
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_trianglesWCC.title AND m2.title <> m_louvainTriangle.title 
    AND m.labelPropagationSameCountry = m2.labelPropagationSameCountry
WITH m_trianglesWCC, m_louvainTriangle, m2 ORDER BY m2.trianglesSameCountry DESC
WITH m_trianglesWCC, m_louvainTriangle, collect(m2)[0] AS m_labeltriangles

WITH [
  {
    title: m_trianglesWCC.title,
    Parametro: "CommunitySameCountry"
  },
  {
    title: m_louvainTriangle.title,
    Parametro: "CommunitySameCountry"
  },
  {
    title: m_labeltriangles.title,
    Parametro: "CommunitySameCountry"
  }
] AS recomendaciones

UNWIND recomendaciones AS rec
RETURN rec.title AS title,
    rec.Parametro AS Parametro;

// Similaridad:
MATCH (m:Movie{title:$neodash_movie_title})-[r:SIMILAR_COUNTRY]->(m2:Movie)
ORDER BY r.score DESC
LIMIT 3
RETURN m2.title AS title,
    "SimilarSameCountry" AS Parametro;



// Recomendaciones para la Relación: (m:Movie)-[r:WATCH_TOG_SAME_ACTOR]->(m2:Movie)

// Centralidad:
WITH $neodash_movie_title AS ParamTITLE
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WITH ParamTITLE, m2 ORDER BY m2.closenessSameActor DESC
WITH ParamTITLE, collect(m2)[0] AS m_closeness

WITH ParamTITLE, m_closeness
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_closeness.title
WITH ParamTITLE, m_closeness, m2 ORDER BY m2.betweennessSameActor DESC
WITH ParamTITLE, m_closeness, collect(m2)[0] AS m_between

WITH ParamTITLE, m_closeness, m_between
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_closeness.title AND m2.title <> m_between.title
WITH m_closeness, m_between, m2 ORDER BY m2.pagerankSameActor DESC
WITH m_closeness, m_between, collect(m2)[0] AS m_pagerank

WITH [
  {
    title: m_closeness.title,
    Parametro: "closenessSameActor"
  },
  {
    title: m_between.title,
    Parametro: "betweennessSameActor"
  },
  {
    title: m_pagerank.title,
    Parametro: "pagerankSameActor"
  }
] AS recomendaciones

UNWIND recomendaciones AS rec
RETURN rec.title AS title,
    rec.Parametro AS Parametro;


// Comunidad
WITH $neodash_movie_title AS ParamTITLE
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m.communityWCCSameActor = m2.communityWCCSameActor
WITH ParamTITLE, m2 ORDER BY m2.trianglesSameActor DESC
WITH ParamTITLE, collect(m2)[0] AS m_trianglesWCC

WITH ParamTITLE, m_trianglesWCC
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_trianglesWCC.title AND m.louvainSameActor = m2.louvainSameActor
WITH ParamTITLE, m_trianglesWCC, m2 ORDER BY m2.trianglesSameActor DESC
WITH ParamTITLE, m_trianglesWCC, collect(m2)[0] AS m_louvainTriangle

WITH ParamTITLE, m_trianglesWCC, m_louvainTriangle
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_trianglesWCC.title AND m2.title <> m_louvainTriangle.title 
    AND m.labelPropagationSameActor = m2.labelPropagationSameActor
WITH m_trianglesWCC, m_louvainTriangle, m2 ORDER BY m2.trianglesSameActor DESC
WITH m_trianglesWCC, m_louvainTriangle, collect(m2)[0] AS m_labeltriangles

WITH [
  {
    title: m_trianglesWCC.title,
    Parametro: "CommunitySameActor"
  },
  {
    title: m_louvainTriangle.title,
    Parametro: "CommunitySameActor"
  },
  {
    title: m_labeltriangles.title,
    Parametro: "CommunitySameActor"
  }
] AS recomendaciones

UNWIND recomendaciones AS rec
RETURN rec.title AS title,
    rec.Parametro AS Parametro;

// Similaridad:
MATCH (m:Movie{title:$neodash_movie_title})-[r:SIMILAR_ACTOR]->(m2:Movie)
ORDER BY r.score DESC
LIMIT 3
RETURN m2.title AS title,
    "SimilarSameActor" AS Parametro;


// Recomendaciones para la Relación: (m:Movie)-[r:WATCH_TOG_SAME_DIRECTOR]->(m2:Movie)

// Centralidad:
WITH $neodash_movie_title AS ParamTITLE
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WITH ParamTITLE, m2 ORDER BY m2.closenessSameDirector DESC
WITH ParamTITLE, collect(m2)[0] AS m_closeness

WITH ParamTITLE, m_closeness
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_closeness.title
WITH ParamTITLE, m_closeness, m2 ORDER BY m2.betweennessSameDirector DESC
WITH ParamTITLE, m_closeness, collect(m2)[0] AS m_between

WITH ParamTITLE, m_closeness, m_between
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_closeness.title AND m2.title <> m_between.title
WITH m_closeness, m_between, m2 ORDER BY m2.pagerankSameDirector DESC
WITH m_closeness, m_between, collect(m2)[0] AS m_pagerank

WITH [
  {
    title: m_closeness.title,
    Parametro: "closenessSameDirector"
  },
  {
    title: m_between.title,
    Parametro: "betweennessSameDirector"
  },
  {
    title: m_pagerank.title,
    Parametro: "pagerankSameDirector"
  }
] AS recomendaciones

UNWIND recomendaciones AS rec
RETURN rec.title AS title,
    rec.Parametro AS Parametro;


// Comunidad
WITH $neodash_movie_title AS ParamTITLE
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m.communityWCCSameDirector = m2.communityWCCSameDirector
WITH ParamTITLE, m2 ORDER BY m2.trianglesSameDirector DESC
WITH ParamTITLE, collect(m2)[0] AS m_trianglesWCC

WITH ParamTITLE, m_trianglesWCC
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_trianglesWCC.title AND m.louvainSameDirector = m2.louvainSameDirector
WITH ParamTITLE, m_trianglesWCC, m2 ORDER BY m2.trianglesSameDirector DESC
WITH ParamTITLE, m_trianglesWCC, collect(m2)[0] AS m_louvainTriangle

WITH ParamTITLE, m_trianglesWCC, m_louvainTriangle
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_trianglesWCC.title AND m2.title <> m_louvainTriangle.title 
    AND m.labelPropagationSameDirector = m2.labelPropagationSameDirector
WITH m_trianglesWCC, m_louvainTriangle, m2 ORDER BY m2.trianglesSameDirector DESC
WITH m_trianglesWCC, m_louvainTriangle, collect(m2)[0] AS m_labeltriangles

WITH [
  {
    title: m_trianglesWCC.title,
    Parametro: "CommunitySameDirector"
  },
  {
    title: m_louvainTriangle.title,
    Parametro: "CommunitySameDirector"
  },
  {
    title: m_labeltriangles.title,
    Parametro: "CommunitySameDirector"
  }
] AS recomendaciones

UNWIND recomendaciones AS rec
RETURN rec.title AS title,
    rec.Parametro AS Parametro;

// Similaridad:
MATCH (m:Movie{title:$neodash_movie_title})-[r:SIMILAR_DIRECTOR]->(m2:Movie)
ORDER BY r.score DESC
LIMIT 3
RETURN m2.title AS title,
    "SimilarSameDirector" AS Parametro;


// Recomendaciones para la Relación: (m:Movie)-[r:WATCH_TOG_SAME_RELEASE_YEAR]->(m2:Movie)

// Centralidad:
WITH $neodash_movie_title AS ParamTITLE
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WITH ParamTITLE, m2 ORDER BY m2.closenessSameReleaseYear DESC
WITH ParamTITLE, collect(m2)[0] AS m_closeness

WITH ParamTITLE, m_closeness
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_closeness.title
WITH ParamTITLE, m_closeness, m2 ORDER BY m2.betweennessSameReleaseYear DESC
WITH ParamTITLE, m_closeness, collect(m2)[0] AS m_between

WITH ParamTITLE, m_closeness, m_between
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_closeness.title AND m2.title <> m_between.title
WITH m_closeness, m_between, m2 ORDER BY m2.pagerankSameReleaseYear DESC
WITH m_closeness, m_between, collect(m2)[0] AS m_pagerank

WITH [
  {
    title: m_closeness.title,
    Parametro: "closenessSameReleaseYear"
  },
  {
    title: m_between.title,
    Parametro: "betweennessSameReleaseYear"
  },
  {
    title: m_pagerank.title,
    Parametro: "pagerankSameReleaseYear"
  }
] AS recomendaciones

UNWIND recomendaciones AS rec
RETURN rec.title AS title,
    rec.Parametro AS Parametro;

// Comunidad
WITH $neodash_movie_title AS ParamTITLE
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m.communityWCCSameReleaseYear = m2.communityWCCSameReleaseYear
WITH ParamTITLE, m2 ORDER BY m2.trianglesSameReleaseYear DESC
WITH ParamTITLE, collect(m2)[0] AS m_trianglesWCC

WITH ParamTITLE, m_trianglesWCC
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_trianglesWCC.title AND m.louvainSameReleaseYear = m2.louvainSameReleaseYear
WITH ParamTITLE, m_trianglesWCC, m2 ORDER BY m2.trianglesSameReleaseYear DESC
WITH ParamTITLE, m_trianglesWCC, collect(m2)[0] AS m_louvainTriangle

WITH ParamTITLE, m_trianglesWCC, m_louvainTriangle
WHERE ParamTITLE <> ""
MATCH (m:Movie {title: ParamTITLE})-[r:WATCH_TOG_SAME_CATEGORY]->(m2:Movie)
WHERE m2.title <> m_trianglesWCC.title AND m2.title <> m_louvainTriangle.title 
    AND m.labelPropagationSameReleaseYear = m2.labelPropagationSameReleaseYear
WITH m_trianglesWCC, m_louvainTriangle, m2 ORDER BY m2.trianglesSameReleaseYear DESC
WITH m_trianglesWCC, m_louvainTriangle, collect(m2)[0] AS m_labeltriangles

WITH [
  {
    title: m_trianglesWCC.title,
    Parametro: "CommunitySameReleaseYear"
  },
  {
    title: m_louvainTriangle.title,
    Parametro: "CommunitySameReleaseYear"
  },
  {
    title: m_labeltriangles.title,
    Parametro: "CommunitySameReleaseYear"
  }
] AS recomendaciones

UNWIND recomendaciones AS rec
RETURN rec.title AS title,
    rec.Parametro AS Parametro;

// Similaridad:
MATCH (m:Movie{title:$neodash_movie_title})-[r:SIMILAR_RELEASE_YEAR]->(m2:Movie)
ORDER BY r.score DESC
LIMIT 3
RETURN m2.title AS title,
    "SimilarSameReleaseYear" AS Parametro;



// Recomendación General:

MATCH (m:Movie{title:$neodash_movie_title})-[r:SIMILAR_ALL]->(m2:Movie)
ORDER BY r.score DESC
LIMIT 3
RETURN m2.title AS title,
    "Similar_ALL" AS Parametro;


