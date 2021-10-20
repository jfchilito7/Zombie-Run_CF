extends Area2D

var Obstaculo1 = preload("res://Obstaculo2.tscn")
var suelo =Vector2(110,630)
var gravedad = 4000
var velocidad = Vector2()
var velocidad_zombie = -1200
var modificador_gravedad = 1.7
var tiempo = 0.0
var intervalo = 3
var intervalo_min = 0.5
var intervalo_max = 3

var obstaculos = [preload("res://Obstaculo2.tscn"), preload("res://Obstaculo1.tscn")]

func _ready():
	set_position(suelo)
	pass

func _physics_process(delta):
	if not get_parent().comienzo:
		return
	
	tiempo += delta
	
	if tiempo >= intervalo:
		tiempo = 0
		
		#Decide obstaculo
		var o = rand_range(0, obstaculos.size())
		get_parent().add_child(obstaculos[o].instance())
		
		#Decide nuevo onstaculo
		intervalo = rand_range(intervalo_min, intervalo_max)
	
	if Input.is_action_just_pressed("saltar"):
		velocidad.y += gravedad * delta
	else:
		velocidad.y += gravedad * delta * modificador_gravedad
	
	if Input.is_action_just_pressed("saltar") and position == suelo:
		velocidad.y = velocidad_zombie
	
	position += velocidad * delta
	
	#limita la posicion del dinosaurio
	if get_position().y > suelo.y :
		set_position(suelo)
		velocidad = Vector2()

func colision(area):
	get_parent().comienzo = false
	get_parent().termino = true
	if get_parent().puntos > get_parent().record:
		get_parent().record = get_parent().puntos
	pass
	
func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if get_parent().termino and not event.is_echo():
			get_tree().reload_current_scene()
			get_parent().termino= false
			get_parent().get_node("Record").text = "Record: " + str(get_parent().record)
			pass
		get_parent().comienzo = true
	#queue_free()
