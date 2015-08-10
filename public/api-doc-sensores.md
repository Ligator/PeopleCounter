### Dispositivos de registro de personas.
*Orientado a microcontroladores y dispositivos similares (Arduino, Raspberry Pi, TI Launchpad, Intel Galileo, etc.).*

Para registrar la entrada o salida de una persona, basta con hacer una sola llamada con el ID del acceso/puerta y la cantidad de personas que entraron y/o salieron.


#### Registrar la entrada y la salida de una persona:

Ejemplo: Una persona entró a "Lugar_1" por la puerta "Acceso lado norte", pero dos más salieron por la misma puerta.
Como vimos en el ejemplo anterior, el ID de la puerta "Acceso lado norte" que pertenece a "Lugar_1" es "3".
Por lo tanto, la llamada queda de la siguiente manera:

`http://flextronicschallenge.herokuapp.com/counts/door/3.json?enter=1&leave=2`

Donde:
* **3**: ID del acceso/puerta.
* **enter**: Cantidad de personas que entraron.
* **leave**: Cantidad de personas que salieron.

Si queremos saber el ID de algún acceso, podemos simplemente poner el cursor sobre el nombre del acceso [en el Home de esta página](http://flextronicschallenge.herokuapp.com), se nos mostrará un mensaje con el ID.


A continuación algunos ejemplo de uso y sus respectivas respuestas, el contenido de la respuesta no es muy importante, lo importante es verificar que el código de respuesta sea siempre 200 para asegurar que el registro fue recibido por el servidor.

#### 1. Una persona entra

`http://flextronicschallenge.herokuapp.com/counts/door/3.json?enter=1`

```
{
	"message":"Contador actualizado",
	"venue":{
		"id":1,
		"counter":17,
		"name":"Lugar_1",
		"created_at":"2015-07-28T13:24:43.989Z",
		"updated_at":"2015-07-28T13:24:54.436Z"
	},
	"door":{
		"id":3,
		"venue_id":1,
		"name":"Acceso lado norte",
		"description":"",
		"created_at":"2015-07-28T13:25:09.788Z",
		"updated_at":"2015-07-30T02:17:40.594Z",
		"enter":1,
		"leave":0
	}
}
```

#### 2. Una persona sale

`http://flextronicschallenge.herokuapp.com/counts/door/3.json?leave=1`

```
{
	"message":"Contador actualizado",
	"venue":{
		"id":1,
		"counter":16,
		"name":"Lugar_1",
		"created_at":"2015-07-28T13:24:43.989Z",
		"updated_at":"2015-07-28T13:24:54.436Z"
	},
	"door":{
		"id":3,
		"venue_id":1,
		"name":"Acceso lado norte",
		"description":"",
		"created_at":"2015-07-28T13:25:09.788Z",
		"updated_at":"2015-07-30T02:17:40.594Z",
		"enter":1,
		"leave":1
	}
}
```

#### 3. Una persona entra y otra sale

`http://flextronicschallenge.herokuapp.com/counts/door/3.json?enter=1&leave=1`

```
{
	"message":"Contador actualizado",
	"venue":{
		"id":1,
		"counter":17,
		"name":"Lugar_1",
		"created_at":"2015-07-28T13:24:43.989Z",
		"updated_at":"2015-07-28T13:24:54.436Z"
	},
	"door":{
		"id":3,
		"venue_id":1,
		"name":"Acceso lado norte",
		"description":"",
		"created_at":"2015-07-28T13:25:09.788Z",
		"updated_at":"2015-07-30T02:17:40.594Z",
		"enter":2,
		"leave":2
	}
}
```

Nótese el cambio del valor **counter** en cada llamada, **counter** es la suma del valor **enter** de todos los accesos menos la suma del valor **leave** de todos los accesos, ambos pertenecientes al evento.
