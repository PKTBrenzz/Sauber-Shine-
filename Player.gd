extends Area2D

const bullet = preload("res://bullet.tscn")

const MOVESPEEDX = 300
const MOVESPEEDY = 200

var current_position = Vector3()
var is_grounded = true
var direction = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	get_input(delta)
	position_update()

func get_input(delta):
	if Input.is_action_pressed("ui_left"):
		move(Vector2(-MOVESPEEDX,0) * delta)
		direction = -1
	elif Input.is_action_pressed("ui_right"):
		move(Vector2(MOVESPEEDX,0) * delta)
		direction = 1
	
	if Input.is_action_pressed("ui_down"):
		move(Vector2(0,MOVESPEEDY) * delta)
	elif Input.is_action_pressed("ui_up"):
		move(Vector2(0,-MOVESPEEDY) * delta)
	
	if Input.is_action_pressed("ui_accept"):
		$Area2D.monitoring = true
	else:
		$Area2D.monitoring = false
	
	if Input.is_action_just_pressed("shot"):
		shot(direction)

func move(dir):
	global_position += dir

func position_update():
	if global_position.y < 350:
		global_position.y = 350
	elif global_position.y > get_viewport().get_visible_rect().size.y - 50:
		global_position.y = get_viewport().get_visible_rect().size.y - 50
	
	z_index = global_position.y

func shot(dir):
	var bullet_proj = bullet.instance()
	bullet_proj.set_dir(direction)
	bullet_proj.global_position = $Position2D.global_position
	get_parent().add_child(bullet_proj)

func draw_ellipse(center, radius, color):
	var points = 32
	var ellipse = PoolVector2Array()
	var angle = 360/points
	var colors = PoolColorArray([color])
	
	for i in range(points):
		ellipse.push_back(center + Vector2(cos(deg2rad(angle*i)), sin(deg2rad(angle*i))/4) * radius)
	draw_polygon(ellipse, colors)	
	

func _draw():
	draw_ellipse(Vector2(0,26),40,Color(0,0,0,0.5))

func _on_Area2D_area_entered( area ):
	if area.is_in_group("Enemy"):
		print("HIT")
