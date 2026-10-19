import gatitos.*
import movimientos.*
import obstaculos.*


import wollok.game.*

object nivelUno{
	method alturaMaxima () = 15
	method anchoMaximo () = 15

	method configurarVentana(){
		game.title("CatSurvivor")
		game.height(self.alturaMaxima())
		game.width(self.anchoMaximo())
		game.boardGround("escenario.jpg")
	}

	method configurarComponentesVisuales(){
		game.addVisual(puerta)
		game.addVisual(patioDeJuego)
		game.addVisual(new Ovillo(position = game.at(2, 2)))
		game.addVisual(new Ovillo(position = game.at(12, 2)))
		game.addVisual(new PlatoDeComida(position = game.at(10, 4)))
		/*game.addVisual(caja)*/
		/*game.aadVisual(dueña)*/
		game.addVisual(perro)
		/*game.addVisual(parteTraseraPerro)*/
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
			gatito.puedeMoverse(true)
		})
		keyboard.down().onPressDo({ 
			gatito.mirarHacia("abajo")
			movimiento.mover(gatito, haciaAbajo) 
			gatito.puedeMoverse(true)
		})
		keyboard.left().onPressDo({ 
			gatito.mirarHacia("izquierda")
			movimiento.mover(gatito, haciaLaIzquierda) 
			gatito.puedeMoverse(true)
		})
		keyboard.right().onPressDo({ 
			gatito.mirarHacia("derecha")
			movimiento.mover(gatito, haciaLaDerecha) 
			gatito.puedeMoverse(true)
		})

	}
	method configurarColisiones(){
		game.onCollideDo(gatito, { elemento => elemento.interactuarCon(gatito)})  
		/*Aplicamos polimorfismo para que el gatito interactue con cualquier elemento que choque*/
	}
	
    //perseguir.seguir(dueña, gatito)
	method atrapar(){
		game.schedule(2000, {game.onTick(300, "perseguir", {
			perseguir.seguir(perro, gatito)
		})
		})
	}


	method iniciar(){
		self.configurarVentana()
		self.configurarComponentesVisuales()
		self.configurarAcciones()
		self.configurarColisiones()
		//self.iniciarMovimientoCaja()		
	} 
}

object nivelDos{
	method alturaMaxima () = 15
	method anchoMaximo () = 15

	method configurarVentana(){		
		game.title("CatSurvivor - Nivel Dos")
		game.boardGround("escenarioDosssss.jpg")
	}

	method configurarComponentesVisuales(){
		/*game.addVisual(caja)*/
		//game.addVisual(perro)
		//game.addVisual(parteTraseraPerro)
		game.addVisual(gatito)		
		game.addVisual(charco)	
	}
	method configurarAcciones(){
		    keyboard.up().onPressDo({ 
			gatito.mirarHacia("arriba")
			movimiento.mover(gatito, haciaArriba)
			gatito.puedeMoverse(true) 
		})
		keyboard.down().onPressDo({ 
			gatito.mirarHacia("abajo")
			movimiento.mover(gatito, haciaAbajo) 
			gatito.puedeMoverse(true)
		})
		keyboard.left().onPressDo({ 
			gatito.mirarHacia("izquierda")
			movimiento.mover(gatito, haciaLaIzquierda) 
			gatito.puedeMoverse(true)
		})
		keyboard.right().onPressDo({ 
			gatito.mirarHacia("derecha")
			movimiento.mover(gatito, haciaLaDerecha) 
			gatito.puedeMoverse(true)
		})

	}
	method configurarColisiones(){
		game.onCollideDo(gatito, { elemento => elemento.interactuarCon(gatito)})  
		/*Aplicamos polimorfismo para que el gatito interactue con cualquier elemento que choque*/
	}

	method limpiezaDeJuego(){
		game.allVisuals().forEach({visual=>game.removeVisual(visual)})
	}
	method iniciar(){
		game.clear()
		self.limpiezaDeJuego()
		self.configurarVentana()
		self.configurarComponentesVisuales()
		self.configurarAcciones()
		self.configurarColisiones()
		//self.iniciarMovimientoCaja()		
	} 
}



object config{

	method alturaMaxima() = 15
	method anchoMaximo() = 15

    method configurarJuego(){
		self.configurarVentana()
		self.agregarComponentesVisuales()
		self.configurarAcciones()
		self.configurarColisiones()
		self.atrapar()
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
		/*game.aadVisual(dueña)*/
		game.addVisual(perro)
		/*game.addVisual(parteTraseraPerro)*/
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
			gatito.puedeMoverse(true)
		})
		keyboard.down().onPressDo({ 
			gatito.mirarHacia("abajo")
			movimiento.mover(gatito, haciaAbajo) 
			gatito.puedeMoverse(true)
		})
		keyboard.left().onPressDo({ 
			gatito.mirarHacia("izquierda")
			movimiento.mover(gatito, haciaLaIzquierda) 
			gatito.puedeMoverse(true)
		})
		keyboard.right().onPressDo({ 
			gatito.mirarHacia("derecha")
			movimiento.mover(gatito, haciaLaDerecha) 
			gatito.puedeMoverse(true)
		})
    }

	method bajarFelicidad() {
		game.onTick(5000, "bajarFelicidad", { gatito.calcularFelicidad(-1)}) // cada 5 segundos cae uno de felicidad
	}

    /*method iniciarMovimientoCaja() {//hacer algo repetidamente cada cierto tiempo
    //game.onTick(500, "moverCaja", {
    //    movimientoDeLaCaja.moverse(caja)
    //})
	}*/


    //perseguir.seguir(dueña, gatito)
	method atrapar(){
		game.schedule(2000, {game.onTick(300, "perseguir", {
			perseguir.seguir(perro, gatito)
		})
		})
	}


	method configurarColisiones(){
		game.onCollideDo(gatito, { elemento => elemento.interactuarCon(gatito) })  
		/*Aplicamos polimorfismo para que el gatito interactue con cualquier elemento que choque*/
	}

}
