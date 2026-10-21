import movimientos.*
import effectosDeSonido.*
import gameConfiguration.*
/*object caja {
    var property position = game.at(3,4)
    
    method image() = "caja.png"
}*/

class Enemigo{
    var property position 
    var property orientacion = ""
    
    method mirarHacia(nuevaOrientacion){
        orientacion = nuevaOrientacion
    }

    method estaJugando() = false

    method interactuarCon(unGatito){
        unGatito.perderVida()
    }

    method despertar(){}
}

class Perro inherits Enemigo  {
    var estaDormido = true
    
    method image() {
        if(estaDormido) {
            return "perroDormido.png"
        } else  {
            return "perro" + orientacion + ".png"
            //return "perroDespierto.png" 
            }
            
    }

    override method interactuarCon(unGatito) {
        super (unGatito)

        estaDormido = false
        gruñidoDePerro.sonar()
        /*game.schedule(2000, { 
            estaDormido = true 
            
            })*/ // El perro se vuelve a dormir después de 2 segundos
    }
 
    override method despertar(){
        estaDormido = false 
    }
    
}

const perro = new Perro ( position = game.at(6,7))

class Dueña inherits Enemigo{
   
    method image(){
        return "dueña" + orientacion + ".png"
    }
    override method interactuarCon(unGatito){
        super (unGatito)

        unGatito.calcularEnergia(-10)
    }
   
}

const dueña = new Dueña (position= game.at(9,8))


/*object parteTraseraPerro {
    var property position = game.at(7, 6) //a la derecha del perro 

    method image() = "imagenInvisible.png"

    method interactuarCon(unGatito) {
        perro.interactuarCon(unGatito)
    }
}*/


class Ovillo {
    var property position 
    var estaDeshecho = false

    method image() {
        if (estaDeshecho) {
            return "ovilloDeshecho.png"
        } else { 
            return "ovillo.png" 
        }
    }

    method interactuarCon(unGatito) {
        if(!estaDeshecho) {
            unGatito.jugar("ovillo")
            estaDeshecho = true
             if(unGatito.felicidad()>=8){
                brillo.sonar()
            }
        }
    }
}

const ovilloUno = new Ovillo (position=game.at(2,2))
const ovilloDos = new Ovillo(position=game.at(12,2))

class PlatoDeComida {
    var property position //game.at(10,4)
    var estaVacio = false

    method image() {
        if (estaVacio) {
            return "platoDeComidaVacio.png"
        } else {
            return "platoDeComida.png" 
        }
    }
    method interactuarCon(unGatito) {
        if(!estaVacio) {
            unGatito.comer()
            estaVacio = true
            if(unGatito.felicidad()>=8){
                brillo.sonar()
            }
        }
    }
}

const unPlato = new PlatoDeComida(position=game.at(10,4))

object patioDeJuego {
    var property position = game.at(13,10)

    method image() = "patioDeJuego.png"
    method interactuarCon(unGatito){
        unGatito.jugar("patio")
         if(unGatito.felicidad()>=8){ //puede terminarse en consulta como método
                brillo.sonar()
            }
    }
}

class Llave {
    var property position = game.at(5, 6)

    method image() = "llave.png"

    method interactuarCon(unGatito) {
        unGatito.agarrarLlave() 
        game.removeVisual(self)        
    }
}

const unaLlave = new Llave (position = game.at(5,6))

object puerta {
    var property position = game.at(5, 11)

    method image() = "puerta.png"

    method interactuarCon(unGatito) {
        if (unGatito.tieneLlave()) {
            unGatito.ganarJuego("Ganaste! el siguiente nivel te espera")
            nivelDos.iniciar()
        } else {
            game.say(unGatito, "¡Está cerrada! Necesito encontrar la llave.")
            puertaBloqueada.sonar()
        }
    }
}

object charco {
    var property position = game.at(6,6)
    method image() = "charco.png"
    method interactuarCon(unGatito) {
        unGatito.mojarse()
    }
}

class Hitbox {
    var property position 
    method image() = "imagenInvisible.png"
    method objetoVinculado() //abstracto
    method interactuarCon(unGatito) {
        self.objetoVinculado().interactuarCon(unGatito) 
    }
}

class HitboxPuerta inherits Hitbox {
    override method objetoVinculado() = puerta
}
