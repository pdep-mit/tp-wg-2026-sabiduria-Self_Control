import movimientos.*


object caja {
    var property position = game.at(3,4)
    
    method image() = "caja.png"
}

object perro {
    var property position = game.at(6,6)

    method image() = "perro.png"
}

object ovillo {
    var property position = game.at(2,2)

    method image() = "ovillo.png"
}
object patioDeJuego {
    var property position = game.at(13,10)

    method image() = "patioDeJuego.png"
}