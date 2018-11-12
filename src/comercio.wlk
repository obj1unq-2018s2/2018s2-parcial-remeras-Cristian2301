import remeras.*

object comercio {
	const sucursales = #{}
	
	
	method totalFacturado(){
		// TODO Acá falta MUCHO delegar y dividir en subtareas.
		// No es lo que pide el enunciado
		return sucursales.sum({sucursal => sucursal.pedidosRecibidos().sum({pedido => pedido.modeloRemera().costo() * pedido.cantRemeras()})})
	}
	
	method pedidoMasCaro(){
		// TODO Acá falta MUCHO delegar y dividir en subtareas. Y además repite el código anterior.
		// No es lo que pide el enunciado
		// TODO map no hace lo que vos necesitás.
		return sucursales.map({sucursal => sucursal.pedidosRecibidos().max({pedido => pedido.modeloRemera().costo()})}).max({pedido => pedido.modeloRemera().costo()})
	}
	
	method tallesQueNoHuboPedidos(){
		// TODO Delegar, dividir en subtareas.
		return new Range(32, 48).difference(sucursales.map({sucursal => sucursal.pedidosRecibidos().map({pedido => pedido.modeloRemera().talle()})}).flatten())
	}
	
	method sucursalQueMasFacturo(){
		// TODO ¿Por qué no usás el mensaje totalFacturado más arriba?
		return sucursales.max({sucursal => sucursal.totalFacturado()})
	}
	
	method sucursalesQueVendieronRemerasDeTodosTalles(){
		sucursales.filter({sucursal => sucursal}) // TODO Incompleto, supongo.
	}
}


class Sucursal{
	const property pedidosRecibidos = #{}
	const property cantMinimaRemeras = 0
	
	method registrarPedido(pedido){
		pedidosRecibidos.add(pedido)
	}
	
	method totalFacturado(){
		// TODO ¿Por qué no le preguntás AL PEDIDO su costo?
		return pedidosRecibidos.sum({pedido => pedido.modeloRemera().costo() * pedido.cantRemeras()})
	}
	
	method cantPedidosDeRemera(color){
		return pedidosRecibidos.count({pedido => pedido.modeloRemera().color() == color})
	}
}


class Pedido{
	const property modeloRemera 
	const property cantRemeras = 0
	const sucursal
	
	method precioBase(){
		return modeloRemera.costo() * cantRemeras
	}
	
	method precio(){
		if(self.aplicaDescuento()){
			return self.precioBase() - self.descuento()
		}
		else{
			return self.precioBase()
		}
	}
	
	method descuento(){
		return self.precioBase() * (modeloRemera.porcentajeDeDescuento() / 100)
	}
	
	method aplicaDescuento(){
		return cantRemeras >= sucursal.cantMinimaRemeras()
	}
}


