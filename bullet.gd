extends Area2D

var direction 

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	move(Vector2(1200*direction, 0) * delta)
	z_index = global_position.y
	update()
	pass

func set_dir(dir):
	direction = dir

func move(dir):
	global_position += dir

func draw_ellipse(center, radius, color):
	var points = 32
	var ellipse = PoolVector2Array()
	var angle = 360/points
	var colors = PoolColorArray([color])
	
	for i in range(points):
		ellipse.push_back(center + Vector2(cos(deg2rad(angle*i)), sin(deg2rad(angle*i))/4) * radius)
	draw_polygon(ellipse, colors)	

func _draw():
	draw_ellipse(Vector2(0,26),5,Color(0,0,0,0.9))

func _on_Area2D_area_entered( area ):
	if area.is_in_group("Enemy"):
		queue_free()
