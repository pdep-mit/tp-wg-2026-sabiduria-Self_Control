import movimientos.*

/*object caja {
    var property position = game.at(3,4)
    
    method image() = "caja.png"
}*/

object perro {
    var property position = game.at(6,6)
    var estaDormido = true

    method image() {
        if(estaDormido) {
            return "perroDormido.png"
        } else {
            return "perroDespierto.png"
        }
    }

    method interactuarCon(unGatito) {
        estaDormido = false
        unGatito.perderVida()
        game.schedule(2000, { estaDormido = true }) // El perro se vuelve a dormir después de 2 segundos
    }
}

object parteTraseraPerro {
    var property position = game.at(7, 6) //a la derecha del perro 

    method image() = "imagenInvisible.png"

    method interactuarCon(unGatito) {
        perro.interactuarCon(unGatito)
    }
}


class Ovillo {
    var property position 
    var estaDeshecho = false

    method image() {
        if (estaDeshecho) {
            return "ovilloDeshecho.png"
        } else {
            return "ovillo.png" 
        }
    }

    method interactuarCon(unGatito) {
        if(!estaDeshecho) {
            unGatito.jugar("ovillo")
            estaDeshecho = true
        }
    }
}

class PlatoDeComida {
    var property position //game.at(10,4)
    var estaVacio = false

    method image() {
        if (estaVacio) {
            return "platoDeComidaVacio.png"
        } else {
            return "platoDeComida.png" 
        }
    }
    method interactuarCon(unGatito) {
        unGatito.comer()
        estaVacio = true
    }
}

object patioDeJuego {
    var property position = game.at(13,10)

    method image() = "patioDeJuego.png"
    method interactuarCon(unGatito){
        unGatito.jugar("patio")
        unGatito.jugar("patio")
    }
}

class Llave {
    var property position = game.at(1, 1)

    method image() = "llave.png"

    method interactuarCon(unGatito) {
        unGatito.agarrarLlave() 
        game.removeVisual(self)        
    }
}

object puerta {
    var property position = game.at(5, 11)

    method image() = "puerta.png"

    method interactuarCon(unGatito) {
        if (unGatito.tieneLlave()) {
            unGatito.ganarJuego("Ganaste! el siguiente nivel te espera")
        } else {
            game.say(unGatito, "¡Está cerrada! Necesito encontrar la llave.")
        }
    }
}

class HitboxPuerta {
    var property position 

    method image() = "imagenInvisible.png"

    method interactuarCon(unGatito) {
        puerta.interactuarCon(unGatito) 
    }
}