import wollok.game.*

//Pensado para Generalizar varios efectosDeSonidos entre interacciones de los elementos
class Sonido { 
    var property archivo                                                                                                                                                                                                              
    method sonar (melodia){
        game.sound(melodia).play()
    }
}

const brillo = new Sonido(archivo = "brillo.mp3")
const puertaBloqueada = new Sonido(archivo = "puertaBloqueada.mp3")
const gruñidoDePerro = new Sonido(archivo = "gruñidoDePerro.mp3")