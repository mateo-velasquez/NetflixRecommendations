import csv
import random

# Lista de apellidos
apellidos = ['Pérez', 'González', 'Rodríguez', 'López', 'Martínez', 'Hernández', 'García', 'Fernández', 'Díaz', 'Moreno',
             'Velásquez', 'Contreras', 'Gómez', 'Lannister', 'Méndez', 'Rojas', 'Rojo', 'Messi', 'Schmitt', 'Nicolás',
             'Borda', 'Quival', 'Quinteros', 'Quiroga', 'Vásquez', 'Ortega', 'Sedano', 'Arnaudo', 'Perotti','Palacios',
             'Riera', 'Zitto', 'Morán', 'Zarate', 'Luque', 'Russo', 'Camolotto', 'Micolini', 'Mercado', 'Esperanza',
             'Reyna', 'Lépore', 'Anziani', 'Magni', 'Stoffel', 'Munguia', 'Del Valle', 'Sad', 'Grey', 'Nardón']


# Función para agregar apellidos aleatorios a los nombres
def agregar_apellido(csv_file):
    # Leer el archivo CSV con los nombres
    with open(csv_file, mode='r', newline='', encoding='utf-8') as file:
        reader = csv.reader(file)
        filas = list(reader)
    
    # Si el archivo CSV contiene una cabecera, la podemos omitir con `next(reader)`
    # reader = csv.reader(file)
    # next(reader)  # Para omitir la cabecera si es necesario
    
    # Agregar el apellido al nombre en la segunda columna de cada fila
    for fila in filas:
        if len(fila) > 1:  # Verificar que haya al menos dos columnas (nombre y apellido)
            nombre = fila[1]  # Suponiendo que el nombre está en la segunda columna
            apellido = random.choice(apellidos)  # Selecciona un apellido aleatorio
            fila[1] = f"{nombre} {apellido}"  # Concatenar nombre con apellido

    # Escribir el archivo con los nombres y apellidos modificados
    with open('profiles.csv', mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerows(filas)


# Función para verificar que los IDs estén correctamente secuenciados
def verificar_ids(csv_file):
    # Leer el archivo CSV con los datos
    with open(csv_file, mode='r', newline='', encoding='utf-8') as file:
        reader = csv.reader(file)
        filas = list(reader)
    
    # Verificar que los IDs estén en la primera columna (índice 0)
    for i, fila in enumerate(filas):
        if len(fila) > 0:  # Verificar que haya al menos una columna
            id_actual = int(fila[0])  # Convertir el ID a un entero
            if id_actual != i + 1:  # Verificar si el ID coincide con la posición esperada
                print(f"Error en la fila {i+1}: El ID debería ser {i+1}, pero es {id_actual}")
            else:
                print(f"Fila {i+1}: El ID {id_actual} está correcto.")
        else:
            print(f"Fila {i+1}: No hay ID en esta fila.")
    
# Llamamos para verificar los IDs en el CSV
verificar_ids('CSV-for-Help/profiles_sin_apellido.csv')

# Llamamos para cargar los apellidos
agregar_apellido('CSV-for-Help/profiles_sin_apellido.csv')

# ACLARACIÓN: ESTE ARCHIVO SE USÓ ANTES DE PONER LOS HEADERS