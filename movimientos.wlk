import gameConfiguration.*

object movimiento {
	method mover(personajeLibre, direccion){
		const nuevaPosicion = direccion.posicionSiguiente(personajeLibre.position())
		personajeLibre.position(nuevaPosicion)
	}
}

object haciaArriba {
	method posicionSiguiente(posicion) { 
        if (posicion.y() == config.alturaMaxima()-1 || posicion.y()==config.alturaLimiteSuperior()){
            return posicion
        }else {
            return posicion.up(1)
            console.println(posicion)
        }
    }
}

object haciaAbajo {
	//Limite en eje vertical restringido,no puede bajar más allá del y = 0
	method posicionSiguiente(posicion) {
		 if(posicion.y()==0 || config.alturaMaxima()-16==posicion.y()){
			return posicion
			} else {
				return posicion.down(1)
			}
}
}

object haciaLaDerecha {
	method posicionSiguiente(posicion) {
        if (posicion.x() == config.anchoMaximo()-1 || config.anchoMaximo()-2==posicion.x()){
            return posicion
        }
        else {
            return posicion.right(1)
        }
    }
}

object haciaLaIzquierda {
	method posicionSiguiente(posicion) {
        if (posicion.x() == 0 || config.anchoMaximo()-16==posicion.x()){
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


