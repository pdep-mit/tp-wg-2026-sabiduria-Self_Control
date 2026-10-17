import wollok.game.*

//Pensado para Generalizar varios efectosDeSonidos entre interacciones de los elementos
class Sonido {
    method sonar (melodia){
        game.sound(melodia).play()
    }
}

object brillo {
    method sonar() = game.sound("brillo.mp3").play()
}

object puertaBloqueada {
    method sonar () = game.sound("puertaBloqueada.mp3").play()
}

object gruñidoDePerro{
    method sonar()= game.sound("gruñidoDePerro.mp3").play() 
}
