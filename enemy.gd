extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$AnimationPlayer.play("Idle")
	pass

func _process(delta):
	position_update()

func position_update():
	if global_position.y < 350:
		global_position.y = 350
	elif global_position.y > get_viewport().get_visible_rect().size.y - 50:
		global_position.y = get_viewport().get_visible_rect().size.y - 50
	
	z_index = global_position.y

func take_damage():
	$AnimationPlayer.play("Hitted")
	$CollisionShape2D.disabled = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Hitted":
		queue_free()
