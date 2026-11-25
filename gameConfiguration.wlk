import gatitos.*
import movimientos.*
import obstaculos.*
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
	//repetir n veces la imagen de vida dependiendo de la cantidad de vidas que tenga el gatito usar .times
		
    game.removeVisual(vidaUno)
    game.removeVisual(vidaDos)
    game.removeVisual(vidaTres)
     
	 //dependiendo la cantidad de vidas, aparecen los corazones 
    if(gatito.vidas() >= 1){
        game.addVisual(vidaUno)
    }
    if(gatito.vidas() >= 2){
        game.addVisual(vidaDos)
    }
    if(gatito.vidas() >= 3){
        game.addVisual(vidaTres)
    
}
	}

	method mostrarInventario(){
		gatito.visualizarInventario()
	}

	method iniciar(){
		self.configurarVentana()
		self.configurarComponentesVisuales()
		self.configurarAcciones()
		self.configurarColisiones()
		//self.iniciarMovimientoCaja()		
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
		//game.addVisual(unaLlave)
		game.addVisual(patioDeJuego)
		game.addVisual(ovilloUno)
		game.addVisual(ovilloDos)
		game.addVisual(unPlato)
		/*game.addVisual(caja)*/
		game.addVisual(perro)
		//game.addVisual(parteTraseraPerro)
		game.addVisual(huesoUno)
		perro.atrapar()
		// la llave aparece recién cuando el gatito le da el hueso al perro
		game.addVisual(gatito)	
		game.addVisual(new HitboxPuerta(position = game.at(6, 11)))
        game.addVisual(new HitboxPuerta(position = game.at(7, 11)))
        game.addVisual(new HitboxPuerta(position = game.at(8, 11)))
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
		//game.addVisual(caja)
		//game.addVisual(perro)
		//game.addVisual(parteTraseraPerro)

		gatito.darItem(unaLlave) // la llave del nivel uno ya se usó

		// Se aleja del borde inferior para no reaparecer sobre la puerta de salida
		gatito.posicionInicial(game.at(3,4))
		gatito.position(game.at(3,4))
		game.addVisual(new HitboxPuertaDos(position = game.at(6, 11)))
		game.addVisual(new HitboxPuertaDos(position = game.at(7, 11)))
		game.addVisual(new HitboxPuertaDos(position = game.at(8, 11)))
		game.addVisual(puertaDos)
		//game.addVisual(ovilloTres)
		game.addVisual(ovilloCuatro)
		game.addVisual(ovilloCinco)
		game.addVisual(ovilloSeis)
		game.addVisual(ovilloSiete)
		game.addVisual(unPlatoDos)	
		game.addVisual(unPlatoTres)
		game.addVisual(new HitboxCharco(position = game.at(7, 6)))
		game.addVisual(new HitboxCharco(position = game.at(8, 6)))
		game.addVisual(charco)
		game.addVisual(dueña)
		game.addVisual(gatito)
		
		//Se intento ir por el camino de no usar la funcion game.clear() pues parece que por este motivo las vidas no se muestran en este nivel visualmente. Rever nuevamente esta cuestion
		// game.removeVisual(ovilloUno)
		// game.removeVisual(ovilloDos)
		// game.removeVisual(unaLlave)
		// game.removeVisual(patioDeJuego)
		// game.removeVisual(unPlato)
		// game.removeVisual(perro)
		// game.removeVisual(puerta)
		self.mostrarVidas()	
		dueña.atrapar()
	}
}
