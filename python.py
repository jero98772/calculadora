print ("optiones:")
print ("enter'mas' para sumar 2 numeros")
print ("enter'menos' para 2 numeros")
print ("enter'multiplicar' para 2 numeros")
print ("enter'dividir' para 2 numeros")
print ("enter'quitar'el programa")
user_input = input(": ")
 
if user_input == 'quitar':
  sys.exit()
elif user_input == "mas":
  numero1 = float(input("entre un numero"))
  numero2 = float(input("entre otro numero"))
  resultado = str(numero1 + numero2)
  print ("TU RESPUESTA ES " + resultado)
elif user_input == "menos":
  numero1 = float(input("entre un numero"))
  numero2 = float(input("entre otro numero"))
  resultado = str(numero1 - numero2)
  print ("TU RESPUESTA ES " + resultado)
elif user_input == "multiplicar":
  numero1 = float(input("entre un numero"))
  numero2 = float(input("entre otro numero"))
  resultado = str(numero1 * numero2)
  print ("TU RESPUESTA ES " + resultado)
elif user_input == "dividir":
  numero1 = float(input("entre un numero"))
  numero2 = float(input("entre otro numero"))
  resultado = str(numero1 / numero2)
  print ("TU RESPUESTA ES " + resultado)
else:
  print("desconocido")


