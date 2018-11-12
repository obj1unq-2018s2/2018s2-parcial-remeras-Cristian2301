class RemerasLisas {
	const talle = 32
	const property color
	
	method costo(){
		if(32 >= talle <= 40 and self.esDeColorBasico()){        // esto esta mal lo iba a arreglar pero no tuve tiempo
			return 80
		}
		else if(32 >= talle <= 40){
			return 80 + (80 * 10) / 100
		}
		if(41 >= talle <= 48 and self.esDeColorBasico()){
			return 100
		}
		else if(41 >= talle <= 48){
			return 100 + (100 * 10) / 100
		}
	}
	
	method esDeColorBasico(){
		return color == "blanco" or color =="negro" or color =="gris" // TODO Mejor sería usar una colección.
	}
	
	method porcentajeDeDescuento(){
		return 10
	}
	
	
}





class Bordadas inherits RemerasLisas{
	const cantColoresBordado = 0
	
	override method costo(){
		return super() + self.costoBordado()
	}
	
	method costoBordado(){
		if(cantColoresBordado == 1){
			return 20
		}
		else{
			return 10 * cantColoresBordado
		}
	}
	
	override method porcentajeDeDescuento(){
		return 2
	}
}





class Sublimadas inherits RemerasLisas {
	const altoDelDibujo = 0
	const anchoDelDibujo = 0
	
	override method costo(){
		return super() + self.costoSublimado()
	}
	
	method costoSublimado(){
		return 0.50 * (altoDelDibujo * anchoDelDibujo)
	}
	
}





class SublimadasPropiedadDeEmpresa inherits Sublimadas {
	const property empresaDueniaDibujo
	
	override method costoSublimado(){
		return super() + empresaDueniaDibujo.derechosDeAutor()
	}
	
	override method porcentajeDeDescuento(){
		if(empresaDueniaDibujo)
	}
	
}



class Empresa {
	const dibujo
	const property derechosDeAutor
	
}


// TODO Esto no hereda de Empresa? No tiene derechos de autor? Parece inconsistente.
class EmpresaConConvenio {
	const dibujo
	
}





