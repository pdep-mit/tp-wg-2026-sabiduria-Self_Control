import gameConfiguration.*

object movimiento {
	method mover(personajeLibre, direccion){
		const nuevaPosicion = direccion.posicionSiguiente(personajeLibre.position())
		personajeLibre.position(nuevaPosicion)
	}
}

object haciaArriba {
	// TODO: no se puede subir más arriba del suelo, donde está la casa
	method posicionSiguiente(posicion) { 
        if (posicion.y() == config.alturaMaxima()-1){
            return posicion
        }else {
            return posicion.up(1)
        }
    }
}

object haciaAbajo {
	// TODO: no se puede bajar más allá del y = 0
	
	method posicionSiguiente(posicion) {
		
		 if(posicion.y()==0){
			return posicion
			} else {
				return posicion.down(1)
			}
		 
}
}

object haciaLaDerecha {
	method posicionSiguiente(posicion) {
        if (posicion.x() == config.anchoMaximo()-1){
            return posicion
        }
        else {
            return posicion.right(1)
        }
    }
}

object haciaLaIzquierda {
	method posicionSiguiente(posicion) {
        if (posicion.x() == 0){
            return posicion
        }
        else {
            return posicion.left(1)
        }
    }
}

object movimientoDeLaCaja{
    var moverseALaDerecha = true

    method moverse(caja){
        if(moverseALaDerecha){
            movimiento.mover(caja, haciaLaDerecha)
        } else {
            movimiento.mover(caja, haciaLaIzquierda)
        }

         if (caja.position().x() == config.anchoMaximo() - 1) {
            moverseALaDerecha = false
        }

        if (caja.position().x() == 0) {
            moverseALaDerecha = true
        }
    }
    
}

object seguirAlGato{

    method seguir(perro, gato){
    if(perro.position().y() < gato.position().y()){
        movimiento.mover(perro, haciaArriba)
    }
}
}
