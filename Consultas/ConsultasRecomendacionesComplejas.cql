//
:param neodash_movie_title  => 'Black Mirror' 

// top 5 same category con mayor degree
MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WITH m2.degreeSameCategory AS sameCatDegree, m2.title as title
RETURN title, sameCatDegree
ORDER BY sameCatDegree DESC LIMIT 5;

// top 5 same category con mayor betweenes
MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WITH m2.betweennessSameCategory AS sameCatBetweeness, m2.title as title
RETURN title, sameCatBetweeness
ORDER BY sameCatBetweeness DESC LIMIT 5;

// top 5 same category con mayor closeness
MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WITH m2.closenessSameCategory AS sameCatCloseness, m2.title as title
RETURN title, sameCatCloseness
ORDER BY sameCatCloseness DESC LIMIT 5;

// top 5 same category con mayor page rank
MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WITH m2.pagerankSameCategory AS sameCatPageRank, m2.title as title
RETURN title, sameCatPageRank
ORDER BY sameCatPageRank DESC LIMIT 5;

// top 5 same category con mayor triangle count
MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WITH m2.trianglesSameCategory AS sameCatTriangle, m2.title as title
RETURN title, sameCatTriangle
ORDER BY sameCatTriangle DESC LIMIT 5;

// top 5 same category con mayor clustering coefficient

MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WITH m2.clusteringCoefficientSameCategory AS sameCatClusCoeff, m2.title as title
RETURN title, sameCatClusCoeff
ORDER BY sameCatClusCoeff DESC LIMIT 5;

// top 5 same category con mismo louvain y mayor degree

MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WHERE m2.louvainSameCategory = m.louvainSameCategory
WITH m2.degreeSameCategory AS sameCatDegree, m2.title as title
RETURN title
ORDER BY sameCatDegree DESC LIMIT 5;

// top 5 same category con mismo louvain y mayor betweennes

MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WHERE m2.louvainSameCategory = m.louvainSameCategory
WITH m2.betweennessSameCategory AS sameCatBetweeness, m2.title as title
RETURN title
ORDER BY sameCatBetweeness DESC LIMIT 5;

// top 5 same category con misma comunidad WCC y mayor clustering coefficient

MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WHERE m2.communityWCCSameCategory = m.communityWCCSameCategory
WITH m2.clusteringCoefficientSameCategory AS sameCatClusCoeff, m2.title as title
RETURN title
ORDER BY sameCatClusCoeff DESC LIMIT 5;

// top 5 same category con misma comunidad WCC y mayor triangle count

MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WHERE m2.communityWCCSameCategory = m.communityWCCSameCategory
WITH m2.trianglesSameCategory AS sameCatTriangle, m2.title as title
RETURN title
ORDER BY sameCatTriangle DESC LIMIT 5;

// top 5 same category con misma labelPropagation y mayor page rank

MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WHERE m2.labelPropagationSameCategory = m.labelPropagationSameCategory
WITH m2.pagerankSameCategory AS sameCatPageRank, m2.title as title
RETURN title
ORDER BY sameCatPageRank DESC LIMIT 5;

// top 5 same category con misma labelPropagation y mayor closeness

MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WHERE m2.labelPropagationSameCategory = m.labelPropagationSameCategory
WITH m2.closenessSameCategory AS sameCatCloseness, m2.title as title
RETURN title
ORDER BY sameCatCloseness DESC LIMIT 5;

// top 5 same category con misma labelPropagation y Louvain por degree

MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WHERE m2.labelPropagationSameCategory = m.labelPropagationSameCategory
AND m2.louvainSameCategory = m.louvainSameCategory
WITH m2.degreeSameCategory AS sameCatDegree, m2.title as title
RETURN title
ORDER BY sameCatDegree DESC LIMIT 5;

// top 5 same category con misma comuniadWCC y Louvain por betweenes

MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WHERE m2.communityWCCSameCategory = m.communityWCCSameCategory
AND m2.louvainSameCategory = m.louvainSameCategory
WITH m2.betweennessSameCategory AS sameCatBetweeness, m2.title as title
RETURN title
ORDER BY sameCatBetweeness DESC LIMIT 5;

// top 5 same category con misma comuniadWCC y labelPropagation por clustering coeff

MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WHERE m2.labelPropagationSameCategory = m.labelPropagationSameCategory
AND m2.communityWCCSameCategory = m.communityWCCSameCategory
WITH m2.clusteringCoefficientSameCategory AS sameCatClusCoeff, m2.title as title
RETURN title
ORDER BY sameCatClusCoeff DESC LIMIT 5;

// top 5 same category con misma louvain, comuniadWCC y labelPropagation por page rank

MATCH (m: Movie) 
WHERE m.title = $neodash_movie_title 
MATCH (m) -[r:WATCH_TOG_SAME_CATEGORY]-> (m2: Movie)
WHERE m2.labelPropagationSameCategory = m.labelPropagationSameCategory
AND m2.communityWCCSameCategory = m.communityWCCSameCategory
AND m2.louvainSameCategory = m.louvainSameCategory
WITH m2.pagerankSameCategory AS sameCatPageRank, m2.title as title
RETURN title
ORDER BY sameCatPageRank DESC LIMIT 5;