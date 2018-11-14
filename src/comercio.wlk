import remeras.*

object comercio {
	const sucursales = #{}

	method pedidos() = sucursales.flatMap { sucursal => sucursal.pedidos() }
	method talles() = new Range(32, 48).asList().asSet()
	
	// Punto C2
	method totalFacturado() = self.pedidos().sum { pedido => pedido.precio() }

	// Punto C4
	method cantPedidosDeColor(color) =
		self.pedidos().count { pedido => pedido.modeloRemera().color() == color }

	// Punto C5
	method pedidoMasCaro() = self.pedidos().max { pedido => pedido.precio() }

	// Punto C6
	method tallesQueNoHuboPedidos() = 
		self.talles().filter { talle => not self.huboPedidoDeTalle(talle) } 

	method huboPedidoDeTalle(talle) = 
		self.pedidos().any { pedido => pedido.modeloRemera().talle() == talle }

	// Punto C7
	method sucursalQueMasFacturo() =
		sucursales.max({ sucursal => sucursal.totalFacturado() })

	// Punto C8
	method sucursalesQueVendieronRemerasDeTodosTalles() =
		sucursales.filter { sucursal => sucursal.vendioTodosLosTalles(self.talles()) } 

}

class Sucursal {

	const property pedidosRecibidos = #{}
	const property cantMinimaRemeras

	// Punto C1	
	method registrarPedido(pedido) {
		pedido.sucursal(self)
		pedidosRecibidos.add(pedido)
	}

	// Punto C3	
	method totalFacturado() = pedidosRecibidos.sum { pedido => pedido.precio() }

	method vendioTodosLosTalles(talles) = 
		talles.all { talle => self.vendioTalle(talle) }
	
	method vendioTalle(talle) = 
		pedidosRecibidos.any { pedido => pedido.modeloRemera().talle() == talle }
}

class Pedido {

	const property modeloRemera
	const property cantRemeras = 0
	var property sucursal = null // La sucursal se auto-asigna cuando le registro el pedido.

	method precioBase() {
		return modeloRemera.costo() * cantRemeras
	}

	method precio() {
		if (self.aplicaDescuento()) {
			return self.precioBase() - self.descuento()
		} else {
			return self.precioBase()
		}
	}

	method descuento() {
		return self.precioBase() * (modeloRemera.porcentajeDeDescuento() / 100)
	}

	method aplicaDescuento() {
		return cantRemeras >= sucursal.cantMinimaRemeras()
	}

}

