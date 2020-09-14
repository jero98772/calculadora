from math import gcd
def root(x,p,root):
	respuesta = x**(p/root)
	return respuesta
def sumaM(a,b,mod):
	respuesta = (a+b)%mod
	return respuesta
def productoM(a,b,mod):
	respuesta = (a*b)%mod
	return respuesta
def poteciaM(base,a,mod):
	respuesta = (base**a)%mod
	return respuesta
def inv(num):
	respuesta = 1/num
	return respuesta
def invM(a,mod):
	if gcd(a,mod) != 1:
		return "no se pudo encontrar el inverso"
	else:
		return a**(mod-2)
def divisionM(a,b,mod):
	a = a % mod
	inver = invM(b,mod) 
	if inver == "no se pudo encontrar el inverso": 
		return "no se pudo encontrar el inverso"
	else: 
		return (inver*a) % mod
def raizCuadradaM(a,mod):
	e = 2
	respuesta = (a**e) % (mod**e)
	return respuesta
def raizM(a,e,mod):
	respuesta = (a**e) % (mod**e)
	return respuesta
def cuadradosPerfectoM(a,mod):
	e = 2
	for i in range(13):
		if  ((i**2) % mod) == a:
			msg = str(a)+"tiene cuadrado perfecto en mod "+str(mod)+" por que "+str(i)+"² mod "+str(mod)+" = "+str(a)
			break
		else:
			msg = "no se pudo encontrar"
	return msg
