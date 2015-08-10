### Dispositivos de monitoreo
*Orientado a dispositivos móviles (Android, iOS, Windows Phone, BlackBerry OS, etc.) y aplicaciones de escritorio (Windows, GNU/Linux, Mac OSX).*

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

