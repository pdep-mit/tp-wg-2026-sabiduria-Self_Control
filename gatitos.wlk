object gatito{
    var property position = game.at(7,1)
    var property vidas = 3
    var energia = 100//rango de 0 a 100
    var felicidad = 0//rango de 0 a 10
    var estaJugando = false

	method image() {
    if (vidas <= 0) {
        return "gatitoDerrotado.png"
    } else if (estaJugando) {
        return "gatitoJugando.png" 
    } else if (felicidad >= 8) { 
        return "gatitoFeliz.png"
    } else {
        return "gatito.png" 
    }
  }

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
    estaJugando = true
    game.schedule(1000, { estaJugando = false })
  } 

  method comer(){ //le sumo valores iniciales "de prueba" casi 1/3 del total
    self.calcularEnergia(30) //le suma 30 de energia sin pasarse de 100
    self.calcularFelicidad(3)
  }

  method perderVida(){
    vidas = vidas - 1
    felicidad = 0
  
    if(vidas <= 0) {
      self.terminarJuego("¡Te quedaste sin vidas! Game Over.")
    } else {
      self.position(game.at(7,1)) // Vuelve al inicio si aún tiene vidas
      game.say(self, "¡Auch! Me quedan " + vidas.toString() + " vidas")
      //Mensaje temporal hasta que pongamos una interfaz visual para mostrar las vidas restantes
    }
  }

  method terminarJuego(mensaje) {
    game.say(self, mensaje)
    game.schedule(2000, { game.stop() }) 
    //Usamos schedule para dar mas tiempo para leer el mensaje
  }

  method ganarJuego(mensaje){
    game.say(self, mensaje)
  }

}
