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

  method comer(){ //le sumo valores iniciales "de prueba" casi 1/3 del total
    self.calcularEnergia(30) //le suma 30 de energia sin pasarse de 100
    self.calcularFelicidad(3)
  }

  method perderVida(){
        vidas = vidas - 1
        //game.say(self, "me mataron :c")

        if(vidas == 0 ){
            self.position(game.origin())
        }
    }

}
