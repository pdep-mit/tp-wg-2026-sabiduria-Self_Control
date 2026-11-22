import gameConfiguration.*
import obstaculos.*

object gatito{
    var property position = game.at(7,1)
    var property vidas = 3
    var property inmune = false
    var energia = 100//rango de 0 a 100
    var felicidad = 0//rango de 0 a 10
    var estaJugando = false
    var jugueteActual = ""
    const inventario = []
    //var tieneHueso = false
    var orientacion = "frente"
    var estaMojado=false
    var property puedeMoverse=true
    var property posicionInicial = game.at(7,1) // donde reaparece al perder una vida

  
  method agarrarItem(item){
    if(!self.tieneItem(item)){ //agarrarLlave y agarrarHueso
    inventario.add(item)} //agregamos el item al inventario
  }

  method tieneItem(item) =inventario.contains(item) // si el item esta en el inventario
  

  method darItem(item){  //perderLlave y darHueso
    inventario.remove(item) //quitamos el item del inventario
  }

  method estaJugando() = estaJugando
 
 //busca en la lista si algun item cumple con la condicion 
  method itemUtilPara(unObjeto) = inventario.findOrDefault({item => item.sirvePara(unObjeto)}, null)


  method usarItemPara(unObjeto){
    const item = self.itemUtilPara(unObjeto)
    if (item != null ){ 
      item.usarPara(unObjeto, self)
    } else {
      game.say(self,"No tengo nada q sirva aca")
    }
  }


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
        return "jugandocon" + jugueteActual.sufijoImagen() + ".png" 
    } else if (felicidad >= 8) { 
        return "gatitofeliz" + orientacion + ".png"
    } else if(estaMojado){
      return "gatoMojado.png"
    }else {
        return "gatito" + orientacion + ".png"
    }
  }

  method energia() {
    return energia
  }

  method calcularEnergia(variable) {
    energia = (energia+variable).max(0).min(100)
    if (energia == 0){
      self.perderVida()
    }
  }

  method felicidad() {
    return felicidad
  }

  method calcularFelicidad(variable) {
    felicidad = (felicidad+variable).max(0).min(10)
    if(felicidad == 10){
      self.activarInmunidad()
    }
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

  method activarInmunidad() {
  inmune = true                       
  game.schedule(5000, { inmune = false })   // 5 segundos de inmunidad
}

  method mojarse(){
    estaMojado=true
    puedeMoverse=false
    game.schedule(3000,{estaMojado=false; puedeMoverse=true})  
  }

  method perderVida(){
   if (!inmune || energia == 0){ 
    vidas = vidas - 1
    felicidad = 0
    energia = 100
    if(vidas <= 0) {
      nivelUno.mostrarVidas()
      self.terminarJuego("¡Te quedaste sin vidas! Game Over.")
    } else {
      self.position(posicionInicial) // Vuelve al inicio si aún tiene vidas
      self.mirarHacia("frente")
      nivelUno.mostrarVidas()
    }
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

class Vida {
  var property position 
  method image() {
    return "conVida.png" 
  }
}
const vidaUno = new Vida(position = game.at(10,0))
const vidaDos = new Vida(position = game.at(11,0))
const vidaTres = new Vida(position = game.at(12,0))


