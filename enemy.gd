extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$AnimationPlayer.play("Idle")
	pass

func _process(delta):
	position_update()
	update()

func position_update():
	if global_position.y < 350:
		global_position.y = 350
	elif global_position.y > get_viewport().get_visible_rect().size.y - 50:
		global_position.y = get_viewport().get_visible_rect().size.y - 50
	
	z_index = global_position.y

func take_damage():
	$AnimationPlayer.play("Hitted")
	$CollisionShape2D.disabled = true

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

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Hitted":
		queue_free()
