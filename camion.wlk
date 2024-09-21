import cosas.*

object camion {
	const property cosas = #{}
	const pesoTara = 1000
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
	}	

	method descargar(unaCosa){
		cosas.remove(unaCosa)
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

	




}
