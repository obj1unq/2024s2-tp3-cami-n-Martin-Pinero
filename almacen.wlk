import cosas.*
import camion.*

object almacen{
    const deposito = []
    var capacidadMaxima = 3 //medido en bultos

    method capacidadMaxima(_capacidadMaxima){
        capacidadMaxima = _capacidadMaxima
    }

    method depositar(cosas){
        self.checkCapacidad(cosas)
        deposito.addAll(cosas)

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