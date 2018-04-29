extends Node

var screen_size

enum stage {WANDER, FIRSTREG} 

var current_limit_left = 0
var currentstage
var over = false

func _ready():
	screen_size = get_viewport().get_visible_rect().size - Vector2(50,50)
	$Pivot/Camera2D.limit_bottom = get_viewport().get_visible_rect().size.y
	$Pivot/Camera2D.limit_top = 0
	
	currentstage = stage.WANDER
	pass

func _process(delta):
	$GameObject/Player.global_position.x = clamp($GameObject/Player.global_position.x, $Pivot.global_position.x - screen_size.x/2, $Pivot.global_position.x + screen_size.x/2)
	
	if currentstage == stage.WANDER:
		$Pivot.global_position = $GameObject/Player.global_position
	elif currentstage == stage.FIRSTREG:
		$Pivot.global_position = $FirstRegion.global_position
		if $GameObject/FirstRegion.get_children().size() == 0:
			currentstage = stage.WANDER
	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		currentstage = stage.FIRSTREG
