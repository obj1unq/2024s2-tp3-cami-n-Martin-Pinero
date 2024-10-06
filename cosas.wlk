object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }

	method bultosQueRepresenta(){
		return 1
	}

	method consecuenciaDeLaCarga(){
		//no hace nada
	}
}


object bumblebee {
    var forma = auto
    
	method peso(){
		 return 800 
	}

	method nivelPeligrosidad(){
		return forma.nivelPeligrosidad()
	}

	method forma(_forma){
		forma = _forma
	}

	method bultosQueRepresenta(){
		return 2
	}

	method consecuenciaDeLaCarga(){
		forma.transformarABumblebee()
	}
	
}

object auto {
	const peligrosidad = 15

	method nivelPeligrosidad(){
		return peligrosidad
	}

	method transformarABumblebee(){
		bumblebee.forma(robot)
	}
}

object robot {
	const peligrosidad = 30

	method nivelPeligrosidad(){
		return peligrosidad
	}

	method transformarABumblebee(){
		bumblebee.forma(auto)
	}
}

object paqueteDeLadrillos {
	var cantidadDeLadrillos = 0
	const pesoPorLadrillo = 2
	const peligrosidad = 2

	method cantidadDeLadrillos(_cantidadDeLadrillos){
		cantidadDeLadrillos = _cantidadDeLadrillos
	}

	method peso(){
		return pesoPorLadrillo * cantidadDeLadrillos

	}

	method nivelPeligrosidad(){
		return peligrosidad
	}

	method bultosQueRepresenta(){
		return if (cantidadDeLadrillos <= 100) 1 
		       else if (cantidadDeLadrillos <= 300) 2 
			   else 3
	}

	method consecuenciaDeLaCarga(){
		cantidadDeLadrillos += 12
	}
}



object arenaAGranel{
	var property peso = 0
	const peligrosidad = 1

	method nivelPeligrosidad(){
		return peligrosidad
	}

	method bultosQueRepresenta(){
		return 1
	}

	method consecuenciaDeLaCarga(){
		peso += 20
	}


}

object bateriaAntiaerea {
	const pesoBase = 200
	const peligrosidadBase = 0
	var   tieneMisilesCargados = false
	const bultosBase = 1
    
	method peso(){
		return pesoBase + self.pesoDeMisiles()
	}

	method pesoDeMisiles(){
		return  if (tieneMisilesCargados) misiles.peso() else 0
				
	}

	method nivelPeligrosidad(){
		return peligrosidadBase + self.peligrosidadDeMisiles()
	}

	method peligrosidadDeMisiles(){
		return  if (tieneMisilesCargados) misiles.nivelPeligrosidad() else 0
				
	
	}

	method bultosQueRepresenta(){
		return bultosBase + self.bultosDeMisiles()
	}

	method bultosDeMisiles(){
		return if(tieneMisilesCargados) 1 else 0
	}

	method consecuenciaDeLaCarga(){
		tieneMisilesCargados = true
	}
}

object misiles {


	method peso(){ //magic number, para no escribir un const
		return 100
	}

	method nivelPeligrosidad(){ //idem
		return 100
	}


}
object contenedorPortuario{
	const cosas =[]	
	const pesoBase = 100
	const peligrosidadBase= 0
	const bultosBase = 1

	method agregar(cosa){
		cosas.add(cosa)
	}

	method peso(){
		return pesoBase + self.pesoDeLaCarga()
	}

	method pesoDeLaCarga(){
		return cosas.sum({cosa => cosa.peso()})
	}

	method nivelPeligrosidad(){
		return peligrosidadBase + self.peligrosidadMaximaDeLaCarga()
	}

	method peligrosidadMaximaDeLaCarga(){
		return cosas.max({cosa => cosa.nivelPeligrosidad()}).nivelPeligrosidad()
	}

	method bultosQueRepresenta(){
		return bultosBase + cosas.sum({cosa => cosa.bultosQueRepresenta()})
	}

	method consecuenciaDeLaCarga(){
		cosas.forEach({cosa => cosa.consecuenciaDeLaCarga()})
	}

	
}

object residuosRadioactivos{
	var property peso = 0
	const peligrosidad = 200

	method nivelPeligrosidad(){
		return peligrosidad
	}
	method bultosQueRepresenta(){
		return 1
	}

	method consecuenciaDeLaCarga(){
		peso += 15
	}
}

object embalaje {
	var contenido = residuosRadioactivos
	
	method envolver(cosa){
		contenido = cosa
	}

	method peso(){
		return contenido.peso()
	}

	method nivelPeigrosidad(){
		return contenido.nivelPeligrosidad() / 2
	}

	method bultosQueRepresenta(){
		return 2
	}

	method consecuenciaDeLaCarga(){
		// no hace nada
	}


	
}