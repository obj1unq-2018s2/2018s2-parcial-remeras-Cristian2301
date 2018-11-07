import remeras.*

object comercio {
	const sucursales = #{}
	
	
	method totalFacturado(){
		return sucursales.sum({sucursal => sucursal.pedidosRecibidos().sum({pedido => pedido.modeloRemera().costo() * pedido.cantRemeras()})})
	}
	
	method pedidoMasCaro(){
		return sucursales.map({sucursal => sucursal.pedidosRecibidos().max({pedido => pedido.modeloRemera().costo()})}).max({pedido => pedido.modeloRemera().costo()})
	}
	
	method tallesQueNoHuboPedidos(){
		return new Range(32, 48).filter({})
	}
	
	method sucursalQueMasFacturo(){
		return sucursales.max({sucursal => sucursal.totalFacturado()})
	}
	
	method sucursalesQueVendieronRemerasDeTodosTalles(){
		sucursales.filter({sucursal => sucursal})
	}
}


class Sucursal{
	const property pedidosRecibidos = #{}
	const property cantMinimaRemeras = 0
	
	method registrarPedido(pedido){
		pedidosRecibidos.add(pedido)
	}
	
	method totalFacturado(){
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


