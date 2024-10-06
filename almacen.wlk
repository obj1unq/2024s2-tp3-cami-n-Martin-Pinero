import cosas.*
import camion.*

object almacen{
    const deposito = []
    var capacidadMaxima = 3 //medido en bultos

    method capacidadMaxima(_capacidadMaxima){
        capacidadMaxima = _capacidadMaxima
    }

    method depositar(camion){
        self.checkCapacidad(camion.cosas())
        deposito.addAll(camion.cosas())

    }

    method checkCapacidad(cosas){
        if (not self.puedeDescargar(cosas)){
            self.error("no hay espacio para descargar!")
        }
    }

    method puedeDescargar(cosas){
        return capacidadMaxima - deposito.size() >= cosas.size()
    }
}