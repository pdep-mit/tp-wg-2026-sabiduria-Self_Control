import gameConfiguration.*
import obstaculos.*

object gatito{
  var property position = game.at(7,1)
  var property vidas = 3
  var estado = normal
  var energia = 100//rango de 0 a 100
  var felicidad = 0//rango de 0 a 10
  const inventario = []
  var orientacion = "frente"
  var property posicionInicial = game.at(7,1) // donde reaparece al perder una vida
  
  method puedeMoverse() = estado.puedeMoverse()
  method esInmune() = estado.esInmune()
  method image() = estado.image(self) 
  method orientacion() = orientacion
  method felicidad() = felicidad
  method energia() = energia

  method volverAEstadoBase() { 
    if (felicidad >= 10) {
      self.activarInmunidad() 
    } else {
      self.cambiarEstado(normal) 
    }
  }
  method calcularFelicidad(variable) {
    felicidad = (felicidad+variable).max(0).min(10)
    estado.alCambiarFelicidad(self)
  }

  method mirarHacia(nuevaOrientacion) {
    orientacion = nuevaOrientacion
  }

  method calcularEnergia(variable) {
    energia = (energia+variable).max(0).min(100)
    if (energia == 0){
      self.perderVida()
    }
  }

  method cambiarEstado(nuevoEstado){
    estado = nuevoEstado
  }

  method jugar(unJuguete){
    self.calcularEnergia(-25)
    self.cambiarEstado(new Jugando(jugueteActual = unJuguete))
    self.calcularFelicidad(+2)
    game.schedule(1000, { self.volverAEstadoBase() })
  } 

  method comer(){ //le sumo valores iniciales "de prueba" casi 1/3 del total
    self.calcularEnergia(30) //le suma 30 de energia sin pasarse de 100
    self.calcularFelicidad(3)
  }

  method activarInmunidad() { 
    self.cambiarEstado(inmune)                     
    game.schedule(5000, { estado.finalizarTiempoInmunidad(self)})   
  }

  method terminarInmunidad(){
    felicidad = 0
    self.volverAEstadoBase()
  }
  
  method mojarse(){ 
    self.cambiarEstado(mojado)
    game.schedule(3000,{ self.volverAEstadoBase()})  
  }

  method perderVida(){
    estado.perderVida(self)
  }

  method aplicarPerderVida(){
    vidas = vidas - 1
    felicidad = 0
    energia = 100
    if(vidas <= 0) {
      self.cambiarEstado(derrotado)
      self.terminarJuego("¡Te quedaste sin vidas! Game Over.") 
    //TODO: cambiar para que muestre pantalla de derrota
    } else {
      self.position(posicionInicial) // Vuelve al inicio si aún tiene vidas
      self.mirarHacia("frente")
    }
    nivelUno.mostrarVidas() 
  }

  method enfrentarA(unEnemigo){ 
    estado.enfrentarA(self, unEnemigo) 
  }

  method terminarJuego(mensaje) {//cambiar para mostrar imagen de derrota
    game.say(self, mensaje)
    game.schedule(2000, { game.stop() }) 
    //Usamos schedule para dar mas tiempo para leer el mensaje
  }

  method ganarJuego(mensaje){ //cambiar para mostrar imagen de victoria
    game.say(self, mensaje)
  }

  //Inventario
  method inventario() = inventario

  method agarrarItem(item){
    if(!self.tieneItem(item)){ //agarrarLlave y agarrarHueso
    inventario.add(item)} //agregamos el item al inventario
    self.visualizarInventario()
  }

  method tieneItem(item) =inventario.contains(item) // si el item esta en el inventario

  method darItem(item){  //perderLlave y darHueso
    if (self.tieneItem(item)){
      inventario.remove(item) //quitamos el item del inventario
      if(game.hasVisual(item)){
        game.removeVisual(item)
      }
      self.visualizarInventario()
    }
  }
 
 //busca en la lista si algun item cumple con la condicion y sino devuelve null
  method itemUtilPara(unObjeto) = inventario.findOrDefault({item => item.sirvePara(unObjeto)}, null)

  method usarItemPara(unObjeto){
    const item = self.itemUtilPara(unObjeto)
    if (item != null ){ 
      item.usarPara(unObjeto, self)
    } else {
      game.say(self,"No tengo nada q sirva aca")
    }
  }

  method visualizarInventario(){
    var columna = 1
    inventario.forEach({item => item.position(game.at(columna, 0))
    if(!game.hasVisual(item)){ //si no se muestra en el juego actualmente de agrega 
      game.addVisual(item)
    }
    columna +=1
    })
  }
}
//Interfaz
class Vida {
  var property position 
  method image() {
    return "conVida.png" 
  }
}
const vidaUno = new Vida(position = game.at(10,0))
const vidaDos = new Vida(position = game.at(11,0))
const vidaTres = new Vida(position = game.at(12,0))

//Estados
class Estado{
  method image(gato)
  method perderVida(gato){
    gato.aplicarPerderVida()
  }
  method puedeMoverse() = true
  method alCambiarFelicidad(gato){}
  method finalizarTiempoInmunidad(gato){}
  method enfrentarA(gato, enemigo){ 
    enemigo.atacar(gato) 
  }
}
object normal inherits Estado{
  override method image(gato){
    return "gatito" + gato.orientacion() + ".png" 
  }
  override method alCambiarFelicidad(gato) { gato.volverAEstadoBase() }
}

class Jugando inherits Estado{
  const jugueteActual 
  override method image(gato){
    return "jugandocon" + jugueteActual.sufijoImagen() + ".png" 
  }

  override method puedeMoverse()=false
}

object mojado inherits Estado{
  override method image(gato){
    return "gatoMojado.png" 
  }
  override method puedeMoverse()=false
}

object inmune inherits Estado{
  override method image(gato){
    return "gatitofeliz" + gato.orientacion() + ".png"//cambiar por imagen de inmunidad
  }
  override method perderVida(gato){}
  override method finalizarTiempoInmunidad(gato){ gato.terminarInmunidad()}
  override method enfrentarA(gato, enemigo){ 
    enemigo.atacarUnInmune(gato) 
  }
}

object derrotado inherits Estado{
  override method image(gato){
    return "gatitoDerrotado.png"
  }
  override method perderVida(gato){}
  override method puedeMoverse()=false
}