extends Node

var velocidad = Vector2(-500, 0)
var velocidad_inicial = velocidad
var offset_inicial = Vector2()
var comienzo = false
var termino = false
var puntuacion_obstaculo = 10
var puntos = 0
var record = 0

func _ready():
	get_node("Zombie1").connect("reiniciado", self, "sera_reiniciado")
	pass

func _process(delta):
	if not comienzo:
		return
	velocidad.x -= delta / 5 

func sera_reiniciado():
	velocidad = velocidad_inicial
