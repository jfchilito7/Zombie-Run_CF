extends Area2D

onready var zombie = get_parent().get_node("Zombie1")
var suelo =Vector2(1318, 634)
var velocidad = Vector2(-500, 0)
var tiempo_vida = 5
var salto = false
onready var main = get_parent() #get_node("/root/Main")

func _ready():
	set_position(suelo)
	connect("area_entered", zombie, "colision")
	zombie.connect("reiniciado", self, "reiniciado")
	pass

func _physics_process(delta):
	
	if not main.comienzo:
		return
		
	set_position(position + get_node("/root/Main").velocidad * delta)
	
	tiempo_vida = tiempo_vida - delta
	
	if tiempo_vida <= 0:
		queue_free()
		
	# comprueba si el jugador ya a saltado el obstaculo y adiciona puntos
	if not salto:
		if get_position().x < main.get_node("Zombie1").get_position().x:
			salto = true
			main.puntos = main.puntos + main.puntuacion_obstaculo
			main.get_node("Puntos").text = "Puntos: " + str(main.puntos)

func reiniciado():
	queue_free()
