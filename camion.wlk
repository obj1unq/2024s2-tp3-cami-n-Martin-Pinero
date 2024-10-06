import cosas.*
import almacen.*

object camion {
	const property cosas = #{}
	const pesoTara = 1000
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
		unaCosa.consecuenciaDeLaCarga()
	}	

	method descargar(cosa){
		cosas.remove(cosa)
	}

	method todoPesoPar(){
        return cosas.all({cosa => self.esPesoPar(cosa)})
	}

	method esPesoPar(cosa){
		return cosa.peso().even() 
	}

	method hayAlgunoQuePesa(peso){
		return cosas.any({cosa => cosa.peso() == peso}) // esto podria ser una subtarea para evitar el calculo en el bloque.
	}

	method elDeNivel(nivel){
		return cosas.find({cosa => cosa.nivelPeligrosidad() == nivel}) 
	}

	method pesoTotal(){
		return pesoTara + self.pesoDeCarga()
	}

	method pesoDeCarga() {
		return cosas.sum({cosa => cosa.peso()})
	}

	method excedidoDePeso(){
		return self.pesoTotal() > 2500
	}

	method objetosQueSuperanPeligrosidad(nivel){
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > nivel})
	}

	method objetosMasPeligrososQue(cosa){
		return self.objetosQueSuperanPeligrosidad(cosa.nivelPeligrosidad())
	}

	method puedeCircularEnRuta(nivelMaximoPeligrosidad) {
		return not self.excedidoDePeso() and not cosas.any({cosa => cosa.nivelPeligrosidad() > nivelMaximoPeligrosidad})
	}

	method tieneAlgoQuePesaEntre(min, max) {
		return cosas.any({cosa => cosa.peso() > min}) and cosas.any({cosa => cosa.peso() < max}) //corregir, no es correcto
	}

	method cosaMasPesada(){
		return cosas.max({cosa => cosa.peso()})
	}

	method pesos(){
		return cosas.map({cosa => cosa.peso()})
	}

	method totalBultos(){
		return cosas.sum({cosa => cosa.bultosQueRepresenta()})
	}

	method transportar(destino, camino){
		self.checkPeso()
		camino.checkCamino()
		destino.depositar(self) // el check de la capacidad del almacen, está en el mismo.
	
	}
	method checkPeso(){
		if (not self.excedidoDePeso()){
			self.error("el camion está excedido de peso")
		}
	}
}





object ruta9{
	const property peligrosidad = 11

	method checkCamino(){
		if (not camion.puedeCircularEnRuta(peligrosidad)) {
			self.error("No puede circular, exceso de peligrosidad")
		}

	}

}

object caminosVecinales{
	var property pesoQueSoporta = 2300

	method checkCamino(){
		if (not camion.pesoTotal() > pesoQueSoporta){
			self.error("el camion pesa mas de lo que soporta el camino vecinal")
		}


	}

}

