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


object ovillo {
    var property position = game.at(2,2) 
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
            unGatito.jugar()
            estaDeshecho = true
        }
    }
}

object platoDeComida {
    var property position = game.at(10,4)

    method image() = "platoDeComida.png"

    method interactuarCon(unGatito) {
        unGatito.comer()
        game.removeVisual(self) // El plato desaparece de la pantalla
    }
}

object patioDeJuego {
    var property position = game.at(13,10)

    method image() = "patioDeJuego.png"
    method interactuarCon(unGatito){
        unGatito.jugar()
        unGatito.jugar()
    }
}