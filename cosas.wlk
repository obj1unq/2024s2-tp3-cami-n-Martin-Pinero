object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
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
	
}

object auto {
	const peligrosidad = 15

	method nivelPeligrosidad(){
		return peligrosidad
	}
}

object robot {
	const peligrosidad = 30

	method nivelPeligrosidad(){
		return peligrosidad
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
}



object arenaAGranel{
	var property peso = 0
	const peligrosidad = 1

	method nivelPeligrosidad(){
		return peligrosidad
	}


}

/*Batería antiaérea : el peso es 300 kilos si está con los misiles o 200 en otro caso. 
En cuanto a la peligrosidad es 100 si está con los misiles y 0 en otro caso.*/

object bateriaAntiaerea {
	const pesoBase = 200
	const peligrosidadBase = 0
	var tieneMisilesCargados = false
    
	method peso(){
		return pesoBase + self.pesoDeMisiles()
	}

	method pesoDeMisiles(){
		return  if (tieneMisilesCargados){
			       misiles.peso()
		           } else {0
				}
	}

	method nivelPeligrosidad(){
		return peligrosidadBase + self.peligrosidadDeMisiles()
	}

	method peligrosidadDeMisiles(){
		return  if (tieneMisilesCargados){
			       misiles.nivelPeligrosidad()
		           } else {0
				}
	
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
/*Contenedor portuario: un contenedor puede tener otras cosas adentro. El peso es 100 + la suma de todas las 
osas que estén adentro. 
Es tan peligroso como el objeto más peligroso que contiene. Si está vacío, su peligrosidad es 0.*/
object contenedorPortuario{
	const cosas =[]	
	const pesoBase = 100
	const peligrosidadBase= 0

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
	
}

object residuosRadioactivos{
	var property peso = 0
	const peligrosidad = 200

	method nivelPeligrosidad(){
		return peligrosidad
	}
}

object embalaje {
	const contenido = []
	
	method envolver(cosa){
		contenido.add(cosa)
	}

	method peso(){
		return contenido.sum({cosa => cosa.peso()})
	}

	method nivelPeigrosidad(){
		return contenido.sum({cosa => cosa.nivelPeligrosidad()}) / 2
	}


	
}