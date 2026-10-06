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
    method interactuarCon(unGatito){
        unGatito.jugar()
        unGatito.jugar()
    }
}

object puerta {
    var property position = game.at(5, 11)

    method image() = "puerta.png"

    method interactuarCon(unGatito) {
        unGatito.ganarJuego("GANO! EL SIGUIENTE NIVEL LO ESPERA")
       //game.removeVisual(unGatito) //el gatito pasa al siguiente nivel 
    }
}

object puerta2{
    var property position = game.at(6.3, 11)

    method image() = "puertainvisible.png"

    method interactuarCon(unGatito) {
        unGatito.ganarJuego("GANO! EL SIGUIENTE NIVEL LO ESPERA")
       //game.removeVisual(unGatito) //el gatito pasa al siguiente nivel 
    }

}