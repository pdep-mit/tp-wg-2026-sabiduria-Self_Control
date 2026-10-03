

object gatito{
    var property position = game.origin()
    var property vidas = 3
    var energia = 100//rango de 0 a 100
    var felicidad = 0//rango de 0 a 10

	method image() = "gatito.png"

    method energia() {
    return energia
  }
  method calcularEnergia(variable) {
    energia = (energia+variable).max(0).min(100)
  }
  method felicidad() {
    return felicidad
  }
  method calcularFelicidad(variable) {
    felicidad = (felicidad+variable).max(0).min(10)
  }
  method jugar(){
    self.calcularEnergia(-25)
    self.calcularFelicidad(+2)
  } 

}

