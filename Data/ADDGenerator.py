from neo4j import GraphDatabase
import random
from dotenv import load_dotenv # Nos va a permitir leer las variables de entorno
import os

# Comado del PipInstall:
# python -m pip install neo4j

# Cargar las variables de entorno
load_dotenv()

# Aca simplemente pasamos los datos de las variables de entorno
uri = os.getenv('uri')
username = os.getenv('usernameNeo4j')
password = os.getenv('password')
driver = GraphDatabase.driver(uri, auth=(username, password))

# Definir los IDs de los perfiles y de las películas
perfil_ids = range(1,416) # El id de los perfiles va desde el 1 al 415 inclusive
pelicula_ids = [f's{num}' for num in range(1, 8808)] # El id de las películas va desde el 1 al 8807 inclusive

# Crear relaciones entre perfiles y películas
def crear_relaciones(session, perfil_ids, pelicula_ids, max_relaciones):
    contador = 0  # Inicializamos el contador
    
    while contador < max_relaciones:
        # Seleccionamos un perfil y una película aleatoriamente
        perfil_id = random.choice(perfil_ids)
        pelicula_id = random.choice(pelicula_ids)
        
        # Creamos la consulta para la relación entre perfil y película
        query = (
            f"MERGE (p:Profile {{id:'{perfil_id}'}}) "
            f"MERGE (m:Movie {{id:'{pelicula_id}'}}) "
            "MERGE (p)-[:ADD]->(m)"
        )
        
        # Ejecutamos la consulta
        # print(f"Creando perfil {perfil_id} relación :ADD y película {pelicula_id}")
        session.run(query)
        
        # Incrementamos el contador
        contador += 1

# Ejecutar el bucle para crear relaciones
with driver.session() as session:
    crear_relaciones(session, perfil_ids, pelicula_ids, 37000)

# Cerrar la conexión al terminar
driver.close()
