extends Node2D



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	update()

func draw_ellipse(center, radius, color):
	var points = 32
	var ellipse = PoolVector2Array()
	var angle = 360/points
	var colors = PoolColorArray([color])
	
	for i in range(points):
		ellipse.push_back(center + Vector2(cos(deg2rad(angle*i)), sin(deg2rad(angle*i))/4) * radius)
	draw_polygon(ellipse, colors)	
	

func _draw():
	for node in get_children():
		for object in node.get_children():
			if object.is_in_group("Player") or object.is_in_group("Enemy"):
				draw_ellipse(object.global_position + Vector2(0,26),40,Color(0,0,0,0.5))