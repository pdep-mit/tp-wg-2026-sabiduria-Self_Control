# Explicaciones teóricas

Para este TP aplicamos varios conceptos como:

Polimorfismo: lo aplicamos en interactuarCon(unGatito).Todos los obstaculos, enemigos y juguetes entienden este mensaje e interactuan con el gato de manera distinta (el perro saca vida, el ovillo sube la felicidad, el charco lo moja), pero el sistema de colisiones los trata a todos indistintamente sin necesidad de preguntar qué tipo de objeto son.

Encapsulamiento: los atributos de los objetos no son modificables directamente por otro objeto, el propio objeto los modifica al recibir un mensaje. El acceso al estado interno es privado (por ejemplo: al gatito, ningun otro objeto le puede cambiar la energia directamente ni sacarle la llave, tienen que mandar un mensaje para que el mismo lo haga).

Clases: aplicadas para crear objetos que repetian comportamiento y atributos, funcionando como moldes que nos permiten instanciar multiples objetos iguales que solo difieren algun atributo, como los Ovillos que son todos los mismos pero se encuentran en distintas posiciones.

Herencia: aplicada en las superclases Enemigo y Juguete. Nos permite juntar el comportamiento comun para no repetir codigo. Cada subclase (como Perro o Ovillo) hereda esa logica base y utiliza override para sobreescribir los metodos done actuan diferente, manteniendo el resto de los atributos compartidos iguales.

Colecciones: aplicadas en el Inventario del gatito utilizando una lista. En lugar de tener cada item definido como variables sueltas, agrupamos los objetos en una coleccion, permitiendonos agregar elementos dinamicamente y delegarle a la coleccion la verificacion de si tenemos cierto item para pasar de nivel.Por ejemplo, de esta manera
el gatito guarda la llave en su inventario, sin necesidad de usar variables booleanas para consultar su estado.

Delegación: La aplicamos cuando un objeto le cede una responsabilidad a otro para no resolverla por sí mismo, dividiendo así las tareas. Un ejemplo claro es la clase Hitbox: cuando choca con el gato y recibe el mensaje interactuarCon(unGatito), la hitbox no resuelve la colisión, sino que delega esa acción en su objetoVinculado (por ejemplo, la puerta). Otro ejemplo se da en el movimiento, donde el gato delega la responsabilidad de calcular su próxima posicion al objeto movimiento, y este a su vez delega en los objetos de dirección (haciaArriba, haciaAbajo).

# Diagramas

![Diagrama de clases](imagenes/diagramaEscapeGatuno.png)