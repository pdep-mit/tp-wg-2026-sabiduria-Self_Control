import gatitos.*
import movimientos.*
import obstaculos.*


import wollok.game.*

object config{

	method alturaMaxima() = 15
	method anchoMaximo() = 15

    method configurarJuego(){
		self.configurarVentana()
		self.agregarComponentesVisuales()
		self.configurarAcciones()
		self.configurarColisiones()
		//self.iniciarMovimientoCaja()
		
	}

    method configurarVentana(){
		game.title("CatSurvivor")
		game.height(self.alturaMaxima())
		game.width(self.anchoMaximo())
		game.boardGround("escenario.jpg")
	}

    method agregarComponentesVisuales(){
		game.addVisual(puerta)
		game.addVisual(patioDeJuego)
		game.addVisual(new Ovillo(position = game.at(2, 2)))
		game.addVisual(new Ovillo(position = game.at(12, 2)))
		game.addVisual(new PlatoDeComida(position = game.at(10, 4)))
		/*game.addVisual(caja)*/
		game.addVisual(perro)
		game.addVisual(parteTraseraPerro)
		game.addVisual(new Llave(position = game.at(5, 6)))
		game.addVisual(gatito)	
		game.addVisual(new HitboxPuerta(position = game.at(6, 11)))
        game.addVisual(new HitboxPuerta(position = game.at(7, 11)))
        game.addVisual(new HitboxPuerta(position = game.at(8, 11)))
    }

    method configurarAcciones(){
        keyboard.up().onPressDo({ 
			gatito.mirarHacia("arriba")
			movimiento.mover(gatito, haciaArriba) 
		})
		keyboard.down().onPressDo({ 
			gatito.mirarHacia("abajo")
			movimiento.mover(gatito, haciaAbajo) 
		})
		keyboard.left().onPressDo({ 
			gatito.mirarHacia("izquierda")
			movimiento.mover(gatito, haciaLaIzquierda) 
		})
		keyboard.right().onPressDo({ 
			gatito.mirarHacia("derecha")
			movimiento.mover(gatito, haciaLaDerecha) 
		})
    }

    /*method iniciarMovimientoCaja() {//hacer algo repetidamente cada cierto tiempo
    //game.onTick(500, "moverCaja", {
    //    movimientoDeLaCaja.moverse(caja)
    //})
	}*/

	method configurarColisiones(){
		game.onCollideDo(gatito, { elemento => elemento.interactuarCon(gatito) })  
		/*Aplicamos polimorfismo para que el gatito interactue con cualquier elemento que choque*/
	}

}
