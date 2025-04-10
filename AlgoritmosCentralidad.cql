-------------------------------------- Alogritmos de Centralidad ---------------------------------

//Degree

	// 1) subgrafo 
	CALL gds.graph.project(
	'degreeGraph',
	'Movie',
	{
		COMPANION:
		{
			orientation: 'UNDIRECTED',
			Properties: 'Weight',
		}
	}
)