import movimientos.*
import effectosDeSonido.*
import gameConfiguration.*
import gatitos.*
import visuales.*

class Enemigo{
    var property position 
    var property orientacion = "frente"
    
    method mirarHacia(nuevaOrientacion){
        orientacion = nuevaOrientacion
    }
    method atacar(unGatito) {unGatito.perderVida()}
    method atacarUnInmune(unGatito){}

    method puedeMoverse() = true

    method interactuarCon(unGatito){
        unGatito.enfrentarA(self)
    }

    method perseguir(unGatito){
        if(position.y() < unGatito.position().y()){
            self.mirarHacia("arriba")
            movimiento.mover(self, haciaArriba)
        }
        else if(position.y() > unGatito.position().y()){
            self.mirarHacia("abajo")
            movimiento.mover(self, haciaAbajo)
        }
        else if(position.x() < unGatito.position().x()){
            self.mirarHacia("derecha")
            movimiento.mover(self, haciaLaDerecha)
        }
        else if(position.x() > unGatito.position().x()){
            self.mirarHacia("izquierda")
            movimiento.mover(self, haciaLaIzquierda)
        }
    }

    method aceptaHueso() = false
    method aceptaLlave() = false
    method atrapar(){}
}

class Perro inherits Enemigo  {
    
    var estaDormido = true
    var recibioHueso = false
    
    method recibioHueso() = recibioHueso
    override method aceptaHueso() = !recibioHueso

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
        recibioHueso = true
        estaDormido = true
        game.addVisual(unaLlave) // el perro deja ver la llave que estaba escondiendo
    }

    override method interactuarCon(unGatito) {
        // Si ya recibió el hueso está entretenido y no ataca
       if(!recibioHueso){
        const item = unGatito.itemUtilPara(self)
        if(item != null){
            item.usarPara(self, unGatito)
            } else {
                super (unGatito)
                estaDormido = false
                gruñidoDePerro.sonar()
            }
        }
    }
 
    override method perseguir(unGatito){
        estaDormido = false
        super(unGatito)
    }
    override method atrapar(){
	game.schedule(2000, {game.onTick(300, "perseguir", {
		// una vez que recibe el hueso, el perro deja de perseguir
		    if(!perro.recibioHueso()) {
			    self.perseguir(gatito)
		    }
	    })
	})
}
    
}

const perro = new Perro ( position = game.at(6,7))

class Dueña inherits Enemigo{
    var tieneLlave = true
    var estaDistraida = false
   
    method image(){
        return "dueña" + orientacion + ".png"
    }

    method tieneLlave() = tieneLlave

    method robarLlave(unGatito){
        tieneLlave = false
        unGatito.agarrarItem(unaLlave)
        game.say(unGatito, "¡Le saqué la llave a la dueña!")
    }
    method distraerse(){
        estaDistraida = true
        game.say(self, "¿Un perrito? ¡Qué lindo!")
        game.schedule(5000, { estaDistraida = false })//Se distrae por 5 segundos
    }

    override method interactuarCon(unGatito){
        //Solo interactua/ataca si tiene la llave y NO está distraída
        if (tieneLlave && !estaDistraida) { 
            super(unGatito) 
        }
        // Si ya le robaron la llave, no hace nada
        if(tieneLlave){ super(unGatito) }
        /* {
            if(unGatito.esInmune()) {
                self.robarLlave(unGatito)
            } else {
                super (unGatito)
                unGatito.calcularEnergia(-10)
            }
        }*/
    }
    override method perseguir(unGatito){
        //Si está distrída, no se mueve hacia el gato
         if (!estaDistraida) {
            super(unGatito)
        }
    }
    override method atacar(unGato){
        super(unGato)
        unGato.calcularEnergia(-10)
    }

    override method atacarUnInmune(unGato){
        self.robarLlave(unGato)
    }

    override method atrapar(){
	    game.schedule(2000, {game.onTick(300, "perseguir", {
	        // una vez que recibe el hueso, el perro deja de perseguir
            self.perseguir(gatito)  //no deberia recibir por parametro al gato?
	        })
	    })
    }
 
}

const dueña = new Dueña (position= game.at(9,8), orientacion = "abajo")

class ObjetoAyuda{
    var property position

    // template method: el gatito se beneficia, el objeto se gasta (si corresponde) y puede brillar
    method interactuarCon(unGatito) {
        if (self.puedeUsarse()) {
            self.beneficiarA(unGatito)
            self.efectoAlUsar()
            if(unGatito.felicidad() >= 8) { brillo.sonar() }
        }
    }
    method puedeUsarse()
    method beneficiarA(unGatito)
    method efectoAlUsar()
}

class Juguete inherits ObjetoAyuda{
    override method interactuarCon(unGatito){
        if(unGatito.puedeJugar()){ super(unGatito) }
    }
    override method beneficiarA(unGatito) {
        unGatito.jugar(self)
    }
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
    override method efectoAlUsar() {} 
    override method sufijoImagen() = "patio"
}
const patioDeJuego = new PatioDeJuego(position = game.at(13, 10))

class PlatoDeComida inherits ObjetoAyuda{
    var estaVacio = false

    method image() {
        if (estaVacio) {
            return "platoDeComidaVacio.png"
        } else {
            return "platoDeComida.png" 
        }
    }

    override method puedeUsarse() = !estaVacio
    override method beneficiarA(unGatito) {
        unGatito.comer()
    }
    override method efectoAlUsar() {
        estaVacio = true
    }
}

const unPlato = new PlatoDeComida(position=game.at(10,4))
// Elementos del nivel dos, cerca de la dueña para poder llegar a ella con la inmunidad activa
const unPlatoDos = new PlatoDeComida(position=game.at(10,6))
const unPlatoTres = new PlatoDeComida(position=game.at(3,4))



class Hueso {
    var property position

    method image() = "huesoParaPerro.png"

    method interactuarCon(unGatito) {
        if(!unGatito.tieneItem(self)){
        game.removeVisual(self)
        unGatito.agarrarItem(self)
      }
    }

    method sirvePara(unObjeto) = unObjeto.aceptaHueso()

    method usarPara(unObjeto, unGatito){
        unObjeto.recibirHueso(unGatito)
        unGatito.darItem(self)
    }
}

const huesoUno = new Hueso(position = game.at(3,7))

class Llave {
    var property position = game.at(5, 6)

    method image() = "llave.png"

    method interactuarCon(unGatito) {
        if(unGatito.tieneItem(self))
        game.removeVisual(self) 
        unGatito.agarrarItem(self)   
    }

    method sirvePara(unObjeto) = unObjeto.aceptaLlave()

    method usarPara(unObjeto, unGatito){ //delega la accion en el objeto con el que quiere interactuar
        unObjeto.abrirCon(unGatito)
        unGatito.darItem(self)
    }

    method aceptaHueso() = false
    method aceptallave() = false
}

const unaLlave = new Llave (position = game.at(5,6))

object puerta {
    var property position = game.at(5, 11)

    method image() = "puerta.png"

    method interactuarCon(unGatito) {
        unGatito.usarItemPara(self)
    }

    method aceptaLlave() = true

    method abrirCon(unGatito){
        nivelDos.iniciar()
    }
    
    method aceptaHueso() = false
}

// Salida del nivel dos: está dibujada en el borde inferior de escenarioDos.png, por eso no tiene imagen propia
object puertaDos {
    var property position = game.at(5, 11)
    method image() = "puertanvdos.png"
    method interactuarCon(unGatito) {
        unGatito.usarItemPara(self)
    }

    method aceptaLlave() = true 

    method abrirCon(unGatito){
        unGatito.terminarJuego(pantallaVictoria)
    }

    method aceptaHueso() = false
}

object charco {
    var property position = game.at(6,6)
    method image() = "charco.png"
    method interactuarCon(unGatito) {
        unGatito.mojarse()
    }
}

object disfrazDePerro{
     var property position = game.at(0, 0)
      method image() = "disfrazDePerro.png"

    method sirvePara(unObjeto) = false

    method activarEn(unGatito) {
        unGatito.ponerseDisfraz(self)
        dueña.distraerse()}
}

object cofre{ 
    var property position = game.at(12, 9) //puse 1 celda libre del Nivel 1
    var estaAbierto = false //el cofre está cerrado

    method image() {
        if (estaAbierto) {
            return "cofreAbierto.png"
        } else {
            return "cofreCerrado.png"
        }
    }
    method interactuarCon(unGatito) {
        if (!estaAbierto) {
            estaAbierto = true
            unGatito.agarrarItem(disfrazDePerro)
            game.say(unGatito, "¡Encontré un disfraz de perro!")
        }
}
}

class Cascabel inherits Juguete{
    method image() = "cascabel.png"
    override method puedeUsarse() = true               
    override method sufijoImagen() = "cascabel"  
    override method efectoAlUsar() {                
        if(game.hasVisual(self)){ game.removeVisual(self) }
    }    
}

class Raton inherits Juguete{
    method image() = "raton.png"
    override method puedeUsarse() = true
    override method efectoAlUsar() {                
        if(game.hasVisual(self)){ game.removeVisual(self) }
    }
    override method sufijoImagen() = "raton"    
}

const ratonUno  = new Raton(position = game.at(2,8))
const ratonDos  = new Raton(position = game.at(12,5))
const cascabel  = new Cascabel(position = game.at(2,3))

class Hitbox {
    var property position 
    method image() = "imagenInvisible.png"
    method objetoVinculado() //abstracto
    method interactuarCon(unGatito) {
        self.objetoVinculado().interactuarCon(unGatito) 
    }
}

class HitboxCharco inherits Hitbox {
    override method objetoVinculado() = charco
}

class HitboxPuerta inherits Hitbox {
    override method objetoVinculado() = puerta
}

class HitboxPuertaDos inherits Hitbox {
    override method objetoVinculado() = puertaDos
}
