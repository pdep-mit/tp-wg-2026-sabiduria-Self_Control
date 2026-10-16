object gatito{
    var property position = game.at(7,1)
    var property vidas = 3
    var energia = 100//rango de 0 a 100
    var felicidad = 0//rango de 0 a 10
    var estaJugando = false
    var jugueteActual = ""
    var tieneLlave = false
    var orientacion = "frente"

  method estaJugando() = estaJugando
  method tieneLlave() = tieneLlave
  method agarrarLlave() {tieneLlave = true}

  method mirarHacia(nuevaOrientacion) {
    orientacion = nuevaOrientacion
    //game.schedule(2000, { orientacion = "frente" }) 
    //pensado para que mire al frente cuando este reposando pero se buggea porque si se mueve rapido se superponen las imagenes y se ve raro al ir a la izquierda
  }

//Herencia
	method image() {
    if (vidas <= 0) {
        return "gatitoDerrotado.png"
    } else if (estaJugando) {
        return "jugandocon" + jugueteActual + ".png" 
    } else if (felicidad >= 8) { 
        return "gatitofeliz" + orientacion + ".png"
    } else {
        return "gatito" + orientacion + ".png"
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

  method jugar(unJuguete){
    self.calcularEnergia(-25)
    self.calcularFelicidad(+2)

    jugueteActual = unJuguete
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
      self.mirarHacia("frente")
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
