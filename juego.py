import random

def selecciona_opcion():
    opciones = ["piedra", "papel", "tijera"]
    seleccion_usuario = input("Ingresa una opcion (piedra, papel, tijera): ").lower()
    if seleccion_usuario not in opciones:
        print("Opción no váli. Por favor ingresar una opción correcta.")
        return None, None
    else:
        print(f"La selección del usuario fue: {seleccion_usuario}")

    seleccion_computadora = random.choice(opciones)
    print(f"La selección de la computadora fue: {seleccion_computadora}")
    return seleccion_usuario, seleccion_computadora

def reglas(seleccion_usuario, seleccion_computadora, gana_usuario, gana_computadora):
    if seleccion_usuario == seleccion_computadora:
        print("Empate!")
    elif seleccion_usuario == "piedra":
        if seleccion_computadora == "tijera":
            print("Piedra gana a tijera!!!")
            print("Usario gana!")
            gana_usuario += 1
        else:
            print("Papel gana a piedra!!!")
            print("Computadora gana!")
            gana_computadora += 1
    
    elif seleccion_usuario == "papel":
        if seleccion_computadora == "piedra":
            print("Papel gana a piedra!!!")
            print("Usuario gana!")
            gana_usuario += 1
        else:
            print("Tijera gana a papel!!!")
            print("Computadora gana!")
            gana_computadora += 1
    
    elif seleccion_usuario == "tijera":
        if seleccion_computadora == "papel":
            print("Tijera gana a papel!!!")
            print("Usuario gana!")
            gana_usuario += 1
        else:
            print("Piedra gana a tijera!!!")
            print("Computadora gana!")
            gana_computadora += 1
    
    return gana_usuario, gana_computadora

def juego():
    gana_usuario = 0
    gana_computadora = 0
    round = 1

    while True:
        print("*" * 10)
        print(f"Round {round}")
        print("*" * 10)

        print(f"Puntaje Usuario: {gana_usuario}")
        print(f"Puntaje Computadora: {gana_computadora}")
        round += 1

        seleccion_usuario, seleccion_computadora = selecciona_opcion()
        gana_usuario, gana_computadora = reglas(seleccion_usuario, seleccion_computadora, gana_usuario, gana_computadora)

        if gana_computadora == 2:
            print("La computadora gana el juego!!")
            break
        elif gana_usuario == 2:
            print("El usuario gana el juego!!")
            break   
        
juego()