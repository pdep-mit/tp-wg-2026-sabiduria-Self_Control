import movimientos.*
import effectosDeSonido.*
import gameConfiguration.*
class Visual {
    var property position
    var property orientacion=""
    method image(){}
    method interactuarCon(unGatito){}
}

//Molde ovillo que hereda de propiedades o methodos de Visual
//y sus dos ovillos existiendo (tratados como instancias)
class Ovillo inherits Visual{
    var estaDeshecho = false

    override method image() {
        if (estaDeshecho) {
            return "ovilloDeshecho.png"
        } else {
            return "ovillo.png" 
        }
    }

    override method interactuarCon(unGatito) {
        if(!estaDeshecho) {
            unGatito.jugar("ovillo")
            estaDeshecho = true
             if(unGatito.felicidad()>=8){
                brillo.sonar()
            }
        }
    }
}
const ovilloUno = new Ovillo(position=game.at(2,2))
const ovilloDos = new Ovillo(position=game.at(12,2))

class PlatoDeComida inherits Visual{
    var estaVacio = false

    override method image() {
        if (estaVacio) {
            return "platoDeComidaVacio.png"
        } else {
            return "platoDeComida.png" 
        }
    }
    override method interactuarCon(unGatito) {
        if(!estaVacio) {
            unGatito.comer()
            estaVacio = true
            if(unGatito.felicidad()>=8){
                brillo.sonar()
            }
        }
    }
}
const unPlato = new PlatoDeComida(position = game.at(10, 4))

class Perro inherits Visual{
    var estaDormido = true
    method estaJugando() = false
    override method image() {
        if(estaDormido) {
            return "perroDormido.png"
        } else  {
            return "perro" + orientacion + ".png"
            }       
    }
    override method interactuarCon(unGatito) {
        unGatito.perderVida()
        estaDormido = false

        gruñidoDePerro.sonar()
        // El perro se vuelve a dormir después de 2 segundos
        //game.schedule(2000, {estaDormido = true })
    }
    
    method mirarHacia(nuevaOrientacion){
        orientacion = nuevaOrientacion
    }
 
    method despertar(){
        estaDormido = false 
    }
}
const perro = new Perro (position = game.at(6,7))
const dueña = new Dueña (position= game.at(9,8))

class Dueña inherits Visual{
    method estaJugando() = false
    override method image(){
        return "dueña" + orientacion + ".png"
    }
    override method interactuarCon(unGatito){
        super (unGatito)
        unGatito.calcularEnergia(-10)
    }
}

class Llave inherits Visual{
    override method image() = "llave.png"

    override method interactuarCon(unGatito) {
        unGatito.agarrarLlave() 
        game.removeVisual(self)        
    }
}
const unaLlave = new Llave(position=game.at(5,6))

class Puerta inherits Visual{
    override method image() = "puerta.png"

    override method interactuarCon(unGatito) {
        if (unGatito.tieneLlave()) {
            unGatito.ganarJuego("Ganaste! el siguiente nivel te espera")
            nivelDos.iniciar()
           
        } else {
            game.say(unGatito, "¡Está cerrada! Necesito encontrar la llave.")
            puertaBloqueada.sonar()
        }
    }
}

const puerta = new Puerta(position=game.at(5,11))

class Charco inherits Visual{
    override method image()= "charco.png"

    override method interactuarCon(unGatito){
        unGatito.mojarse()   
    }
}
const charco = new Charco(position=game.at(6,6))

class PatioDeJuego inherits Visual{
    override method image () ="patioDeJuego.png"
    override method interactuarCon(unGatito){
        unGatito.jugar("patio")
        if(unGatito.felicidad()>=8){
            brillo.sonar()
        }
    } 
}
const patioDeJuego = new PatioDeJuego(position=game.at(13,10))
class HitboxPuerta inherits Visual{
    override method image() = "imagenInvisible.png"

    override method interactuarCon(unGatito) {
        puerta.interactuarCon(unGatito) 
    }
}

object escenarioUno {
    var property position = game.at(0,0)
    method image() = "escenarioUno.jpg"
}

object escenarioDos{
    var property position = game.at(0,0)
    method image() ="escenarioDos.jpg"
}