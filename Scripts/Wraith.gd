extends Node2D


export(int) var points = 60 setget set_points, get_points

onready var area2d = $Area2D
onready var animatedSprite = $Area2D/AnimatedSprite

signal died
signal target_selected

var main_scene
var player
var power_line

var direction_modifier = 2
var timer = 0
var mouse_hovered = false
var paused = false


func set_points(new_points):
	points = clamp(new_points, 0, 9999999)


func get_points():
	return points


func _ready():
	main_scene = get_tree().current_scene
	player = main_scene.find_node("Player")
	power_line = main_scene.find_node("PowerLine")
	power_line.clear_target()
	area2d.input_pickable = true


func _physics_process(delta):
	if paused == false:
		move_self(delta)
		
		if timer > (350 * delta):
			if points > 0:
				if mouse_hovered:
					drain()
				else:
					default()
			
			timer = 0
		else:
			timer += 1
		
		if points <= 0:
			die()


func default():
	animatedSprite.play("default")


func drain():
	animatedSprite.play("drain")
	points -= 2
	player.add_points(2)
#	yield(animatedSprite, "animation_finished")


func die():
	animatedSprite.play("death")
	player.clear_wraith()
	paused = true
	emit_signal("died")
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
	if points > 0:
		power_line.set_target("Wraith")
		emit_signal("target_selected")
		mouse_hovered = true
	else:
		power_line.clear_target()
		mouse_hovered = false


func _on_Area2D_mouse_exited():
	power_line.clear_target()
	mouse_hovered = false
