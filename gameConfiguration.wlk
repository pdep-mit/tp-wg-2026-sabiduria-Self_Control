import gatitos.*
import movimientos.*
//import obstaculos.*
import visuales.*
import wollok.game.*

class Nivel {
	method alturaMaxima () = 15
	method anchoMaximo () = 15

	method configurarVentana(){}
	method configurarComponentesVisuales(){}

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
	method configurarColisiones(){
		game.onCollideDo(gatito, { elemento => elemento.interactuarCon(gatito)})  
		/*Aplicamos polimorfismo para que el gatito interactue con cualquier elemento que choque*/
	}
	
	
	method mostrarVidas(){
		if(gatito.vidas()==3){
			game.addVisual(vidaUno)
			game.addVisual(vidaDos)
			game.addVisual(vidaTres)
		}else if(gatito.vidas()==2){
			game.removeVisual(vidaTres)		
		}else if(gatito.vidas()==1){
			game.removeVisual(vidaDos)
			game.removeVisual(vidaTres)
		}else{
			game.removeVisual(vidaUno)
			game.removeVisual(vidaDos)
			game.removeVisual(vidaTres)
		}
	}
}

object nivelUno inherits Nivel{
	override method configurarVentana(){
		game.title("CatSurvivor")
		game.height(self.alturaMaxima())
		game.width(self.anchoMaximo())
		game.boardGround("unaCelda.png")
		game.addVisual(escenarioUno)
	}
	override method configurarComponentesVisuales(){
		self.mostrarVidas()
		game.addVisual(puerta)
		game.addVisual(patioDeJuego)
		game.addVisual(ovilloUno)
		game.addVisual(ovilloDos)
		game.addVisual(unPlato)
		/*game.addVisual(caja)*/
		game.addVisual(perro)
		//game.addVisual(parteTraseraPerro)
		game.addVisual(unaLlave)
		game.addVisual(gatito)	
		game.addVisual(new HitboxPuerta(position = game.at(6, 11)))
        game.addVisual(new HitboxPuerta(position = game.at(7, 11)))
        game.addVisual(new HitboxPuerta(position = game.at(8, 11)))
	}
	
	method iniciar(){
		self.configurarVentana()
		self.configurarComponentesVisuales()
		self.configurarAcciones()
		self.configurarColisiones()
		self.atrapar()
		//self.iniciarMovimientoCaja()		
	} 
	method atrapar(){
		game.schedule(2000, {game.onTick(300, "perseguir", {
			perseguir.seguir(perro, gatito)
		})
		})
	}
	
}

object nivelDos inherits Nivel{

	override method configurarVentana(){
		game.title("CatSurvivor - Nivel Dos")
		game.clear()
		game.boardGround("unaCelda.png")
		game.addVisual(escenarioDos)
	}

	override method configurarComponentesVisuales(){
		/*game.addVisual(caja)*/
		//game.addVisual(perro)
		//game.addVisual(parteTraseraPerro)
		
		game.addVisual(gatito)		
		game.addVisual(charco)
		// game.removeVisual(ovilloUno)
		// game.removeVisual(ovilloDos)
		// game.removeVisual(unaLlave)
		// game.removeVisual(patioDeJuego)
		// game.removeVisual(unPlato)
		// game.removeVisual(perro)
		// game.removeVisual(puerta)
		self.mostrarVidas()	
	}

	method iniciar(){
		self.configurarVentana()
		self.configurarComponentesVisuales()
		self.configurarAcciones()
		self.configurarColisiones()
	} 
}




// object config{

// 	method alturaMaxima() = 15
// 	method anchoMaximo() = 15

//     method configurarJuego(){
// 		self.configurarVentana()
// 		self.agregarComponentesVisuales()
// 		self.configurarAcciones()
// 		self.configurarColisiones()
// 		//self.iniciarMovimientoCaja()
// 	}

//     method configurarVentana(){
// 		game.title("CatSurvivor")
// 		game.height(self.alturaMaxima())
// 		game.width(self.anchoMaximo())
// 		game.boardGround("escenario.jpg")
// 	}

//     method agregarComponentesVisuales(){
// 		game.addVisual(puerta)
// 		game.addVisual(patioDeJuego)
// 		game.addVisual(new Ovillo(position = game.at(2, 2)))
// 		game.addVisual(new Ovillo(position = game.at(12, 2)))
// 		game.addVisual(new PlatoDeComida(position = game.at(10, 4)))
// 		/*game.addVisual(caja)*/
// 		game.addVisual(perro)
// 		game.addVisual(parteTraseraPerro)
// 		game.addVisual(new Llave(position = game.at(5, 6)))
// 		game.addVisual(gatito)	
// 		game.addVisual(new HitboxPuerta(position = game.at(6, 11)))
//         game.addVisual(new HitboxPuerta(position = game.at(7, 11)))
//         game.addVisual(new HitboxPuerta(position = game.at(8, 11)))
//     }

//     method configurarAcciones(){
//         keyboard.up().onPressDo({ 
// 			gatito.mirarHacia("arriba")
// 			movimiento.mover(gatito, haciaArriba) 
// 		})
// 		keyboard.down().onPressDo({ 
// 			gatito.mirarHacia("abajo")
// 			movimiento.mover(gatito, haciaAbajo) 
// 		})
// 		keyboard.left().onPressDo({ 
// 			gatito.mirarHacia("izquierda")
// 			movimiento.mover(gatito, haciaLaIzquierda) 
// 		})
// 		keyboard.right().onPressDo({ 
// 			gatito.mirarHacia("derecha")
// 			movimiento.mover(gatito, haciaLaDerecha) 
// 		})
//     }

//     /*method iniciarMovimientoCaja() {//hacer algo repetidamente cada cierto tiempo
//     //game.onTick(500, "moverCaja", {
//     //    movimientoDeLaCaja.moverse(caja)
//     //})
// 	}*/

// 	method configurarColisiones(){
// 		game.onCollideDo(gatito, { elemento => elemento.interactuarCon(gatito) })  
// 		/*Aplicamos polimorfismo para que el gatito interactue con cualquier elemento que choque*/
// 	}

// }
