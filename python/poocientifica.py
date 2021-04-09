from math import e ,pi ,sqrt ,exp ,log , cos, sin, tan, atan, asin ,acos
class caculadora:
	def __init__(self,expresion):
		self.expresion = expresion
	def calcular(self):
		entrada=eval(self.expresion)
		return entrada
calculadora = caculadora(input("entre algo para calcular\n"))
r = calculadora.calcular()
print(r)


