

object gatito{
    var property position = game.origin()

	method image() = "gatito.png"

    var property vida = 7
    var property felicidad = 3

    method perderVida(){
        vida = (vida -1).max(0)
        if(vida == 0){
            vida = 7
        }

        self.position (game.origin())

    }

    method jugar (){
        felicidad += 1

        if (felicidad == 0){ //si su felicidad llega a 0 pierde una vida 
            self.perderVida()
        }
    }
}

