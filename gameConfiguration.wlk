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
		//self.iniciarMovimientoCaja()
		
	}

    method configurarVentana(){
		game.title("CatSurvivor")
		game.height(self.alturaMaxima())
		game.width(self.anchoMaximo())
		game.boardGround("escenario.jpg")
	}

    method agregarComponentesVisuales(){
        game.addVisual(gatito)
		/*game.addVisual(caja)*/
		game.addVisual(perro)
		game.addVisual(patioDeJuego)
		game.addVisual(platoDeComida)
    }

    method configurarAcciones(){
        keyboard.up().onPressDo({ movimiento.mover(gatito, haciaArriba) })
		keyboard.down().onPressDo({ movimiento.mover(gatito, haciaAbajo) })
		keyboard.left().onPressDo({ movimiento.mover(gatito, haciaLaIzquierda) })
		keyboard.right().onPressDo({ movimiento.mover(gatito, haciaLaDerecha) })
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
