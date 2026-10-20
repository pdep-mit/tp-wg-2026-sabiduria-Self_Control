import gameConfiguration.*
import gatitos.*

object movimiento {
	method mover(personajeLibre, direccion){
        if(gatito.puedeMoverse()){
            if(not personajeLibre.estaJugando()){
            const nuevaPosicion = direccion.posicionSiguiente(personajeLibre.position())
            personajeLibre.position(nuevaPosicion)
            }
        }
        
	}
}

object haciaArriba {
	// TODO: no se puede subir más arriba del suelo
	method posicionSiguiente(posicion) { 
        if (posicion.y() == nivelUno.alturaMaxima()-4){
            return posicion
        }else {
            return posicion.up(1)
        }
    }
}

object haciaAbajo {
	// TODO: no se puede bajar más allá del y = 1 para no colisionar con las paredes 
    
	
	method posicionSiguiente(posicion) {
		
		 if(posicion.y()==1){
			return posicion
			} else {
				return posicion.down(1)
			}
		 
}
}

object haciaLaDerecha {
    //ponemos en -2 para evitar la colision con las paredes
	method posicionSiguiente(posicion) {
        if (posicion.x() == nivelUno.anchoMaximo()-2){
            return posicion
        }
        else {
            return posicion.right(1)
        }
    }
}

object haciaLaIzquierda {
    ////ponemos en 1 para evitar la colision con las paredes
	method posicionSiguiente(posicion) {
        if (posicion.x() == 1){
            return posicion
        }
        else {
            return posicion.left(1)
        }
    }
}

object perseguir{
    
    method seguir(alguien, gato){
        alguien.despertar()
    if(alguien.position().y() < gato.position().y()){
        alguien.mirarHacia("arriba")
        movimiento.mover(alguien, haciaArriba)
    }
    else if(alguien.position().y() > gato.position().y()){
        alguien.mirarHacia("abajo")
        movimiento.mover(alguien, haciaAbajo)
    }
    else if(alguien.position().x() < gato.position().x()){
        alguien.mirarHacia("derecha")
        movimiento.mover(alguien, haciaLaDerecha)
    } 
    else if(alguien.position().x() > gato.position().x()){
        alguien.mirarHacia("izquierda")
        movimiento.mover(alguien, haciaLaIzquierda)
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

         if (caja.position().x() == nivelUno.anchoMaximo() - 2) {
            moverseALaDerecha = false
        }

        if (caja.position().x() == 1) {
            moverseALaDerecha = true
        }
    }
    
}


