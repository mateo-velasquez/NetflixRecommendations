import csv
import random

# Lista de Nombres:
nombres = [
    "Agustín", "Agustina", "Alejandro", "Alejandra", "Alfredo", "Alicia", "Alan", "Alma", "Andrés", "Andrea",
    "Antonio", "Ana", "Axel", "Abril", "Ariel", "Ariana", "Alberto", "Antonella", "Abel", "Ailén",
    "Alonso", "Aitana", "Amador", "Amalia", "Adriel", "Amanda", "Aarón", "Anahí", "Américo", "Ayelén",
    "Asier", "Aurora", "Arón", "Abigail", "Arnaldo", "Anastasia", "Aldo", "Araceli", "Adrián", "Alina",
    "Benjamín", "Brenda", "Bruno", "Bianca", "Bautista", "Belén", "Braian", "Bárbara", "Boris", "Beatriz",
    "Blas", "Brisa", "Bastián", "Berenice", "Baltasar", "Betsabé", "Bernardo", "Bernarda", "Bladimir", "Bonnie",
    "Basilio", "Bettina", "Braulio", "Brigitte", "Bayron", "Betania", "Benicio", "Bellatrix", "Bartolomé", "Bricia",
    "Beltrán", "Bilha", "Branko", "Blanda", "Benilda", "Bismarck", "Bibiana", "Boanerges", "Baya", "Bashir",
    "Camila", "Carlos", "Carla", "Cristian", "Catalina", "César", "Celeste", "Claudio", "Clara", "Ciro",
    "Cecilia", "Cristóbal", "Carmen", "Caleb", "Constanza", "Conrado", "Cintia", "Cirilo", "Claribel", "Cornelio",
    "Coral", "Cipriano", "Chloe", "Crisanto", "Candela", "Casandra", "Cayetano", "Carlota", "Candelaria", "Cloe",
    "Diego", "Daniela", "David", "Delfina", "Darío", "Dana", "Damián", "Diana", "Denis", "Daiana",
    "Dante", "Dulce", "Dylan", "Deborah", "Dilan", "Damaris", "Domingo", "Doris", "Darian", "Dominika",
    "Demian", "Dunia", "Denzel", "Dalma", "Donovan", "Dasha", "Desiderio", "Dafne", "Donato", "Dalila",
    "Elías", "Elena", "Emanuel", "Estefanía", "Eduardo", "Emilia", "Ezequiel", "Eva", "Erik", "Ema",
    "Esteban", "Eloísa", "Enzo", "Esmeralda", "Edgar", "Eugenia", "Efraín", "Elvira", "Emiliano", "Elsa",
    "Federico", "Florencia", "Facundo", "Fátima", "Fernando", "Fiorella", "Fabio", "Fernanda", "Flavio", "Fabiana",
    "Félix", "Francisca", "Fabián", "Frida", "Faustino", "Gabriel", "Gabriela", "Guillermo", "Guillermina", "Germán",
    "Graciela", "Genaro", "Gloria", "Gastón", "Georgina", "Gonzalo", "Gema", "Gervasio", "Giuliana", "Gregorio",
    "Héctor", "Helena", "Hugo", "Hortensia", "Horacio", "Haydée", "Hernán", "Helena", "Hermes", "Harmony",
    "Ignacio", "Isabel", "Iván", "Ingrid", "Ian", "Irina", "Iker", "Ileana", "Ismael", "Ivana",
    "Imanol", "Iris", "Isaías", "Indira", "Italo", "Juan", "Julieta", "Joaquín", "Jimena", "Jorge",
    "Jazmín", "Jeremías", "Juliana", "Javier", "Johanna", "Josué", "Josefina", "Julián", "Juana", "Jael",
    "Kevin", "Karen", "Katherina", "Kenia", "Khalil", "Luis", "Laura", "Leonardo", "Lucia", "Lorenzo",
    "Lara", "Lucas", "Lourdes", "Leandro", "Liliana", "Lázaro", "Lola", "Luciano", "Lía", "Luisana",
    "Leonardo", "Lila", "Lionel", "Leticia", "Lucas", "Lorenza", "Lisandro", "Leila", "Lucho", "Libia",
    "Lino", "Laurana", "Luisa", "Lázara", "Luisito", "María", "Mateo", "Martín", "Mariana", "Mara",
    "Micaela", "Mario", "Marcela", "Mauricio", "Melissa", "Melanie", "Maxima", "Manuel", "Margarita", "Milton",
    "Mirella", "Marcos", "Mónica", "Miguel", "Marisol", "Matías", "Melisa", "Moisés", "Mila", "Mauro",
    "Nicolás", "Noelia", "Néstor", "Natalia", "Nacho", "Norma", "Nahuel", "Nadia", "Nicanor", "Nina",
    "Omar", "Oliver", "Oscar", "Olivia", "Oriana", "Octavio", "Onelia", "Osvaldo", "Otilia", "Orlando",
    "Pablo", "Patricia", "Pedro", "Paula", "Piero", "Pilar", "Paloma", "Priscila", "Pascual", "Penélope",
    "Patricio", "Pabla", "Pablo", "Plácido", "Paola", "Pompeyo", "Pía", "Pablina", "Prudencia", "Primo",
    "Pancho", "Pilar", "Placidia", "Pancracio", "Paolo", "Quiana", "Quentin", "Quetzal", "Queralt", "Quirina",
    "Roberto", "Raquel", "Ricardo", "Rosa", "Ramiro", "Renata", "Rafael", "Regina", "Rodrigo", "Rocío",
    "Rocco", "Raúl", "Rubén", "Remedios", "Renzo", "Rita", "Rolando", "Rebeca", "Romeo", "Rosaura",
    "Sebastián", "Sofía", "Samuel", "Sabrina", "Sergio", "Silvia", "Santiago", "Sara", "Salvatore", "Selene",
    "Simón", "Susana", "Sebastián", "Stella", "Santos", "Sonia", "Saúl", "Sol", "Santiago", "Sarah",
    "Tomás", "Teresa", "Thiago", "Tatiana", "Tadeo", "Tania", "Tobías", "Tamara", "Teodoro", "Trini",
    "Ulises", "Úrsula", "Ubaldo", "Uriel", "Uma", "Vicente", "Valeria", "Víctor", "Vanessa", "Valentino",
    "Violeta", "Verónica", "Valentín", "Virginia", "Vladimiro", "William", "Wendy", "Walter", "Waldo", "Ximena",
    "Yasmín", "Yago", "Yolanda", "Zoe", "Zacarías"
]

# Lista de apellidos
apellidos = [
    'Almeida', 'Anziani', 'Arnaudo', 'Ayala', 'Barrionuevo', 'Benítez', 'Bermúdez', 'Bonelli', 'Borda', 'Cabral',
    'Cáceres', 'Calderón', 'Camolotto', 'Cantero', 'Cardozo', 'Carrizo', 'Castillo', 'Castro', 'Cerda', 'Cervantes',
    'Chávez', 'Cisneros', 'Contreras', 'Cornejo', 'Crespo', 'Cuevas', 'Del Valle', 'Delgado', 'Díaz', 'Domínguez',
    'Escobar', 'Esperanza', 'Espinosa', 'Figueroa', 'Fonseca', 'Franco', 'Gaitán', 'Gallardo', 'Galván', 'García',
    'Gómez', 'González', 'Godoy', 'Grey', 'Gutiérrez', 'Hernández', 'Ibarra', 'Iñíguez', 'Juárez', 'Lagos',
    'Lannister', 'Lara', 'Ledesma', 'Leiva', 'Lencina', 'Lépore', 'Lopez', 'Luque', 'Luna', 'Maciel',
    'Magni', 'Malvarez', 'Marín', 'Martínez', 'Maturana', 'Medina', 'Méndez', 'Mercado', 'Messi', 'Micolini',
    'Molina', 'Monzón', 'Montenegro', 'Morán', 'Moreno', 'Munguia', 'Nardón', 'Nieto', 'Nicolás', 'Ojeda',
    'Oliva', 'Ortega', 'Ortiz', 'Palacios', 'Paniagua', 'Parra', 'Peñalosa', 'Perotti', 'Pérez', 'Pizarro',
    'Quinteros', 'Quival', 'Quiroga', 'Ramírez', 'Ramos', 'Reyna', 'Reynoso', 'Rico', 'Riera', 'Rivero',
    'Rodríguez', 'Rojas', 'Rojo', 'Russo', 'Sad', 'Salazar', 'Salinas', 'Sánchez', 'Santamaría', 'Santos',
    'Schmitt', 'Sedano', 'Silva', 'Stoffel', 'Suárez', 'Tapia', 'Toledo', 'Torres', 'Trejo', 'Valdez',
    'Valenzuela', 'Vásquez', 'Vega', 'Velásquez', 'Vera', 'Vergara', 'Villalba', 'Zambrano', 'Zarate', 'Zitto',
    'Acosta', 'Aguilar', 'Alarcón', 'Alfaro', 'Amador', 'Amaya', 'Andrada', 'Aparicio', 'Arce', 'Arias',
    'Avendaño', 'Azcurra', 'Báez', 'Becerra', 'Bello', 'Blanco', 'Bogado', 'Borja', 'Brizuela', 'Bustos',
    'Caballero', 'Campos', 'Cano', 'Carballo', 'Carrera', 'Carvajal', 'Casas', 'Catalán', 'Cazares', 'Celis',
    'Centeno', 'Cervini', 'Chacón', 'Chaparro', 'Chirino', 'Colina', 'Colombo', 'Comas', 'Concha', 'Cordero',
    'Coria', 'Cornejo', 'Cortés', 'Cuello', 'Cuevas', 'Curcio', 'Dávalos', 'De la Fuente', 'De la Vega', 'Delgado',
    'Díaz', 'Duarte', 'Durán', 'Enríquez', 'Escalante', 'Esquivel', 'Estévez', 'Farías', 'Fernández', 'Ferreyra',
    'Figueroa', 'Flores', 'Fuentes', 'Gallego', 'Gallo', 'Gálvez', 'García', 'Garnica', 'Giménez', 'Gómez',
    'Gonzaga', 'González', 'Guerrero', 'Guillén', 'Guzmán', 'Hernández', 'Herrera', 'Ibáñez', 'Infante', 'Insaurralde',
    'Iribarren', 'Jaimes', 'Jara', 'Jofré', 'Lagos', 'Lamadrid', 'Lara', 'León', 'Llamas', 'Lobo',
    'Lozano', 'Lucero', 'Luján', 'Macías', 'Maldonado', 'Manríquez', 'Marchese', 'Martel', 'Martínez', 'Massa',
    'Matías', 'Medrano', 'Mejía', 'Melgarejo', 'Merino', 'Miranda', 'Molina', 'Monje', 'Morales', 'Moreira',
    'Moyano', 'Muñoz', 'Mussi', 'Navarrete', 'Navarro', 'Núñez', 'Obando', 'Obregón', 'Olguín', 'Olivera',
    'Orellana', 'Orlando', 'Ortíz', 'Otero', 'Pacheco', 'Padilla', 'Páez', 'Palma', 'Pardo', 'Paredes',
    'Parodi', 'Pastor', 'Peña', 'Perales', 'Pérez', 'Pineda', 'Portillo', 'Posadas', 'Prieto', 'Puente',
    'Puga', 'Quevedo', 'Quiñones', 'Ramos', 'Rangel', 'Ravelo', 'Redondo', 'Reyes', 'Riquelme', 'Rivera',
    'Robledo', 'Roca', 'Rodríguez', 'Roldán', 'Romero', 'Rosas', 'Ruiz', 'Salguero', 'Salinas', 'Salvatierra',
    'Sánchez', 'Sandoval', 'Sanhueza', 'Santana', 'Santi', 'Santos', 'Saravia', 'Saucedo', 'Serrano', 'Sibila',
    'Silva', 'Solano', 'Sosa', 'Suárez', 'Taborda', 'Tapia', 'Tejada', 'Toledo', 'Torrico', 'Torres',
    'Trejo', 'Trujillo', 'Ulloa', 'Valdés', 'Valencia', 'Valiente', 'Varela', 'Vargas', 'Vázquez', 'Vega',
    'Velázquez', 'Vera', 'Vergara', 'Vidal', 'Villagra', 'Villalba', 'Villanueva', 'Villarreal', 'Vives', 'Zalazar'
]



# Generar CSV con 2000 perfiles
def generar_csv_con_nombres_y_apellidos(output_file, cantidad):
    with open(output_file, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(['id_profile', 'nombre_completo'])  # Encabezados

        for i in range(1, cantidad + 1):
            nombre = random.choice(nombres)
            apellido = random.choice(apellidos)
            nombre_completo = f"{nombre} {apellido}"
            writer.writerow([i, nombre_completo])

    print(f"Archivo generado exitosamente con {cantidad} perfiles.")

# Ejecutar la función
generar_csv_con_nombres_y_apellidos('profiles.csv', 5000)
