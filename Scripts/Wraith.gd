extends Node2D


export(int) var points = 300 setget set_points, get_points

onready var animatedSprite = $Area2D/AnimatedSprite

var being_clicked = false
var player
var timer = 0

func set_points(new_points):
	points = clamp(new_points, 0, 9999999)


func get_points():
	return points


func _ready():
	var main = get_tree().current_scene
	player = main.find_node("Player")
	$Area2D.input_pickable = true


func _process(_delta):
	if timer > 600:
		if points > 0:
			if being_clicked:
				animatedSprite.play("drain")
				print(points)
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


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			print("clicked down")
			being_clicked = true
		elif not event.pressed:
			print("clicked up")
			being_clicked = false
