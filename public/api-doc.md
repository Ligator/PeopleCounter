
Documentación de la API 
----------------------------------------------------------

La API sirve para comunicar los dispositivos con la plataforma WEB y puede ser consumida de igual forma por cualquier dispositivo.
Todas las llamadas son del tipo HTTP GET y devuelven datos en formato JSON.


### Dispositivos de monitoreo
*Usado por dispositivos móviles y aplicaciones de escritorio.*

Son necesarias dos llamadas a la API, la primera es para saber qué lugares están registrados en la base de datos y la segunda es para saber los detalles del lugar, así como la lista de todos los accesos que tiene.

#### 1. Lista de todos los lugares que existen en la base de datos.

Suponiendo que en la base de datos tenemos 4 lugares llamados "Lugar_1", "Lugar_2", "Lugar_3" y "Lugar_4" respectivamente, entonces la siguiente llamada:

`http://flextronicschallenge.herokuapp.com/venues.json`

Nos va a devolver lo siguiente:

```javascript
[
	{
		"id":1,
		"counter":16,
		"name":"Lugar_1",
		"url":"http://flextronicschallenge.herokuapp.com/venues/1.json"
	},
	{
		"id":2,
		"counter":9,
		"name":"Lugar_1",
		"url":"http://flextronicschallenge.herokuapp.com/venues/2.json"
	},
	{
		"id":3,
		"counter":0,
		"name":"Lugar_1",
		"url":"http://flextronicschallenge.herokuapp.com/venues/3.json"
	},
	{
		"id":4,
		"counter":0,
		"name":"Lugar_1",
		"url":"http://flextronicschallenge.herokuapp.com/venues/4.json"
	}
]
```

Donde: 

* **id**: Es el identificador (ID) único de cada lugar en nuestra base de datos.
* **counter**: Cantidad de personas que se encuentran dentro del lugar actualmente.
* **name**: Nombre del lugar
* **url**: Es la dirección donde podemos obtener más detalles de ese lugar.

#### 2. Detalles del lugar y la lista de todos los accesos que tiene.

Si queremos saber los detalles de "Lugar_1", usamos la siguiente llamada (nótese que el "1" es el ID del lugar):

`http://flextronicschallenge.herokuapp.com/venues/1.json`

```
{
	"id":1,
	"counter":16,
	"name":"Lugar_1",
	"created_at":"2015-07-25T06:52:38.118Z",
	"updated_at":"2015-07-29T08:55:31.308Z",
	"devices":[
		{
			"id":1,
			"venue_id":1,
			"name":"Puerta principal",
			"description":"wertwert",
			"created_at":"2015-07-25T10:02:14.768Z",
			"updated_at":"2015-07-28T12:45:28.633Z",
			"enter":23,
			"leave":5
		},
		{
			"id":2,
			"venue_id":1,
			"name":"Acceso por estacionamiento",
			"description":"",
			"created_at":"2015-07-28T12:14:41.269Z",
			"updated_at":"2015-07-29T08:55:31.303Z",
			"enter":9,
			"leave":11
		},
		{
			"id":3,
			"venue_id":1,
			"name":"Acceso lado norte",
			"description":"",
			"created_at":"2015-07-28T12:19:15.829Z",
			"updated_at":"2015-07-28T12:19:15.829Z",
			"enter":0,
			"leave":0
		}
	]
}
```

Donde los datos en la respuesta JSON son:

 * **id**, **counter** y **name**: Son los datos del lugar (iguales que la llamada anterior)
 * **devices**: Es la lista de los accesos registrados para este lugar. 

Dentro de **devices**:

 * **id**: Es el identificador (ID) único de cada acceso en nuestra base de datos.
 * **venue_id**: Es el ID del lugar al cual pertenece este acceso.
 * **name**: Nombre del acceso o puerta al lugar.
 * **enter**: Cantidad de personas que han entrado por esta puerta.
 * **leave**: Cantidad de personas que han salido por esta puerta.

### Dispositivos de registro de personas.
*Usado por microcontroladores y dispositivos similares (Arduino, Raspberry Pi, TI Launchpad, Intel Galileo, etc.).*

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
