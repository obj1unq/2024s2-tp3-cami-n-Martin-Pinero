import cosas.*
import almacen.*

object camion {
	const property cosas = #{}
	const pesoTara = 1000
	var rutaElegida = ruta9
	var lugarDeEntrega = almacen

	method rutaElegida(_rutaElegida){
		rutaElegida = _rutaElegida
	}

	method lugarDeEntrega(_lugarDeEntrega){
		lugarDeEntrega=_lugarDeEntrega
	}
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
		unaCosa.consecuenciaDeLaCarga()
	}	

	method todoPesoPar(){
        return cosas.all({cosa => self.esPesoPar(cosa)})
	}

	method esPesoPar(cosa){
		return cosa.peso() % 2 ==  0 
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
		return cosas.filter ({elemento => elemento.nivelPeligrosidad() > cosa.nivelPeligrosidad()})
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

	method descargar(){
		almacen.depositar(cosas)
		cosas.clear()

	}

	method transportar(destino, camino){
		self.rutaElegida(camino)
		self.lugarDeEntrega(destino)
		self.checkPeso()
		self.checkCamino()
		self.descargar() // el check de la capacidad del almacen, está en el mismo.
	
	}

method checkCamino(){
	if (not lugarDeEntrega.puedeCircularElCamion()){
		self.error("el camino no admite al camion!")
	}
}

	method checkPeso(){
		if(not self.excedidoDePeso()){
			self.error("el camion esta sobrecargado")
		}
	}

}

object ruta9{
	const property peligrosidad = 11

	method puedeCircularElCamion(){
		return camion.puedeCircularEnRuta(peligrosidad)
	}

}

object caminosVecinales{
	var property pesoQueSoporta = 3000

	method puedeCircularElCamion(){
		return camion.pesoTotal() <= pesoQueSoporta
	}

}

