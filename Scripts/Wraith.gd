extends Node2D


export(int) var points = 300 setget set_points, get_points

onready var animatedSprite = $Area2D/AnimatedSprite

var main_scene
var player
var power_line

var direction_modifier = -2
var timer = 0
var mouse_hovered = false

func set_points(new_points):
	points = clamp(new_points, 0, 9999999)


func get_points():
	return points


func _ready():
	main_scene = get_tree().current_scene
	player = main_scene.find_node("Player")
	power_line = main_scene.find_node("PowerLine")
	$Area2D.input_pickable = true


func _process(delta):
	move_self(delta)
	
	if timer > 400:
		if points > 0:
			if mouse_hovered:
				animatedSprite.play("drain")
#				print(points)
				points -= 10
				player.add_points(10)
				# yield(animatedSprite, "animation_finished")
			else:
				animatedSprite.play("default")
			
		timer = 0
	else:
		timer += 1
	
	if points <= 0:
		animatedSprite.play("death")
		yield(animatedSprite, "animation_finished")
		queue_free()


func move_self(delta):
	randomize()
	var move_x = rand_range(-80, 250)
	
	if global_position.x > 1200:
		direction_modifier = -2
	elif global_position.x < -600:
		direction_modifier = 2
	
	var movement = Vector2(move_x * delta * direction_modifier, 0)
	self.translate(movement)


func _on_Area2D_input_event(_viewport, _event, _shape_idx):
	power_line.set_target("Wraith")
	mouse_hovered = true


func _on_Area2D_mouse_exited():
	power_line.set_target("")
	mouse_hovered = false
