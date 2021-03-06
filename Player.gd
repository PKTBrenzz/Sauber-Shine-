extends Area2D

const bullet = preload("res://bullet.tscn")

const MOVESPEEDX = 300
const MOVESPEEDY = 200

enum state {IDLE, MOVE}

var current_position = Vector3()
var is_grounded = true
var direction = 1
var anim

func _ready():
	$AnimationPlayer.play("Idle")
	pass

func _physics_process(delta):
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
	
	if Input.is_action_just_pressed("attack"):
		$AnimationPlayer.play("Hit")
	
	if Input.is_action_just_pressed("shot"):
		shot(direction)

func move(dir):
	global_position += dir

func position_update():
	global_position.y = clamp(global_position.y,300,get_viewport().get_visible_rect().size.y - 50)
	scale.x = direction
	z_index = global_position.y

func shot(dir):
	var bullet_proj = bullet.instance()
	bullet_proj.set_dir(direction)
	bullet_proj.global_position = $Position2D.global_position
	get_parent().add_child(bullet_proj)

func animate(animation):
	pass

func _on_Area2D_area_entered( area ):
	if area.is_in_group("Enemy"):
		area.take_damage()


func _on_AnimationPlayer_animation_finished(anim_name):
	print("Yes")
	if anim_name == "Hit":
		print("finished")
		$AnimationPlayer.play("Idle")
