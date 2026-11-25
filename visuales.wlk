class Visual{
    var property position = game.at(0,0)
    var property image = ""
}

class PantallaFinal {
  const property image
  const property position
}

const pantallaVictoria = new PantallaFinal(image = "victoriajuego.png", position = game.at(2, 6))
const pantallaDerrota  = new PantallaFinal(image = "finjuego.png",      position = game.at(5, 6))

object escenarioUno {
    var property position = game.at(0,0)
    method image() = "escenarioUno.png"
}

object escenarioDos{
    var property position = game.at(0,0)
    method image() ="escenarioDos.png"
}