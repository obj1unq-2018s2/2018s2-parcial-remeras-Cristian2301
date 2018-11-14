object listaDePrecios {
	var property precioTalleChico = 80
	var property precioTalleGrande = 100
}

class RemeraLisa {

	const property talle = 32
	const property color
	const precioTalleChico = listaDePrecios.precioTalleChico()
	const precioTalleGrande = listaDePrecios.precioTalleGrande()

	method costo() {
		const costoSegunTalle = 
			if (self.esTalleChico()) precioTalleChico else precioTalleGrande
		
		if (self.esDeColorBasico()) {
			return costoSegunTalle
		} else {
			return costoSegunTalle + (costoSegunTalle * 10) / 100
		}
	}

	method esTalleChico() = talle.between(32, 40)
	
	method esDeColorBasico() {
		return [ "blanco", "negro", "gris" ].contains(color)
	}

	method porcentajeDeDescuento() = 10

}

class Bordada inherits RemeraLisa {
	const cantColoresBordado = 0

	override method costo() = super() + self.costoBordado()

	method costoBordado() = 10 * cantColoresBordado.max(2)

	override method porcentajeDeDescuento() = 2
}

class Sublimada inherits RemeraLisa {
	const altoDelDibujo = 0
	const anchoDelDibujo = 0

	override method costo() = super() + self.costoSublimado()

	method costoSublimado() {
		return 0.50 * altoDelDibujo * anchoDelDibujo
	}
}

class SublimadaDeEmpresa inherits Sublimada {
	const property empresaDueniaDibujo

	override method costo() = super() + self.costoDerechosDeAutor()
	
	method costoDerechosDeAutor() = empresaDueniaDibujo.derechosDeAutor()

	override method porcentajeDeDescuento() =
		if (empresaDueniaDibujo.tieneConvenio()) 20 else super()
}

class Empresa {
	const property derechosDeAutor
	const property tieneConvenio = false
}
