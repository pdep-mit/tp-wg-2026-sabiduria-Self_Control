import movimientos.*

/*object caja {
    var property position = game.at(3,4)
    
    method image() = "caja.png"
}*/

object perro {
    var property position = game.at(6,6)

    method image() = "perroEjemplo.png"

    method interactuarCon(unGatito) {
        unGatito.perderVida()
    }
}

object ovillo {
    var property position = game.at(2,2) 

    method image() = "ovillo.png"

    method interactuarCon(unGatito) {
        unGatito.jugar()
    }
}

object platoDeComida {
    var property position = game.at(5,5)

    method image() = "platoDeComida.png"

    // Comportamiento polimórfico al chocar
    method interactuarCon(unGatito) {
        unGatito.comer()
        game.removeVisual(self) // El plato desaparece de la pantalla
    }
}

object patioDeJuego {
    var property position = game.at(13,10)

    method image() = "patioDeJuego.png"
}