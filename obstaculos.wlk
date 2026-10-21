import movimientos.*
import effectosDeSonido.*
import gameConfiguration.*
/*object caja {
    var property position = game.at(3,4)
    
    method image() = "caja.png"
}*/

class Enemigo{
    var property position 
    var property orientacion = "frente"
    
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
    var recibioHueso = false
    
    method recibioHueso() = recibioHueso

    method image() {
        if(recibioHueso) {
            return "perroDormido.png"//se puede remplazar con otra imagen
        } else if(estaDormido) {
            return "perroDormido.png"
        } else  {
            return "perro" + orientacion + ".png" 
        }  
    }

    method recibirHueso(unGatito) {
        unGatito.darHueso()
        recibioHueso = true
        estaDormido = true
        game.addVisual(unaLlave) // el perro deja ver la llave que estaba escondiendo
    }

    override method interactuarCon(unGatito) {
        // Si ya recibió el hueso está entretenido y no ataca
        if(!recibioHueso) {
            if(unGatito.tieneHueso()) {
                self.recibirHueso(unGatito)
            } else {
                super (unGatito)
                estaDormido = false
                gruñidoDePerro.sonar()
            }
        }
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
    var tieneLlave = true
   
    method image(){
        return "dueña" + orientacion + ".png"
    }

    method tieneLlave() = tieneLlave

    method robarLlave(unGatito){
        tieneLlave = false
        unGatito.agarrarLlave()
        game.say(unGatito, "¡Le saqué la llave a la dueña!")
    }

    override method interactuarCon(unGatito){
        // Si ya le robaron la llave, no hace nada
        if(tieneLlave) {
            if(unGatito.inmune()) {
                self.robarLlave(unGatito)
            } else {
                super (unGatito)
                unGatito.calcularEnergia(-10)
            }
        }
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

class Juguete{
    var property position 
    method interactuarCon(unGatito) {
        if (self.puedeUsarse()) {
            unGatito.jugar(self) 
            self.efectoAlUsar()
            if(unGatito.felicidad() >= 8) { brillo.sonar() }
        }
    }
    method puedeUsarse()
    method efectoAlUsar()
    method sufijoImagen() 
}

class Ovillo inherits Juguete{
    var estaDeshecho = false

    method image() {
        if (estaDeshecho) {
            return "ovilloDeshecho.png"
        } else { 
            return "ovillo.png" 
        }
    }

    override method puedeUsarse() = !estaDeshecho
    override method efectoAlUsar() { 
        estaDeshecho = true 
    }

    override method sufijoImagen() = "ovillo"
}

const ovilloUno = new Ovillo (position = game.at(2,2))
const ovilloDos = new Ovillo(position = game.at(12,2))

class PatioDeJuego inherits Juguete{
    method image() = "patioDeJuego.png"
    override method puedeUsarse() = true
    override method efectoAlUsar() {} //queda vacion porque no se gasta o lo gasto?
    override method sufijoImagen() = "patio"
}
const patioDeJuego = new PatioDeJuego(position = game.at(13, 10))

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
// Elementos del nivel dos, cerca de la dueña para poder llegar a ella con la inmunidad activa
const ovilloTres = new Ovillo(position=game.at(8,6))
const unPlatoDos = new PlatoDeComida(position=game.at(10,6))



class Hueso {
    var property position

    method image() = "huesoParaPerro.png"

    method interactuarCon(unGatito) {
        unGatito.agarrarHueso()
        game.removeVisual(self)
    }
}

const huesoUno = new Hueso(position = game.at(3,7))

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

// Salida del nivel dos: está dibujada en el borde inferior de escenarioDos.png, por eso no tiene imagen propia
object puertaDos {
    var property position = game.at(7, 1)

    method interactuarCon(unGatito) {
        if (unGatito.tieneLlave()) {
            unGatito.terminarJuego("¡Escapaste de la casa! ¡Ganaste!")
        } else {
            game.say(unGatito, "¡Está cerrada! Necesito la llave de la dueña.")
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

class HitboxPuertaDos inherits Hitbox {
    override method objetoVinculado() = puertaDos
}
