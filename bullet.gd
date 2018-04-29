extends Area2D

var direction 

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	move(Vector2(1200*direction, 0) * delta)
	z_index = global_position.y
	pass

func set_dir(dir):
	direction = dir

func move(dir):
	global_position += dir


func _on_Area2D_area_entered( area ):
	if area.is_in_group("Enemy"):
		area.take_damage()
		queue_free()


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
