extends KinematicBody2D

export (int) var speed = 20

func get_input():
	look_at(get_global_mouse_position())

func _physics_process(delta):
	pass
	# this isn't working
	
	get_input()
	var mouse_pos = get_global_mouse_position()
#	if mouse_pos.x != 0 and mouse_pos.y != 0:

	print("---")
#	print(mouse_pos.x)
	print(global_position)
	
	var player_pos = get_parent().global_position
	print(player_pos)
	
	var target = Vector2(0, 0)
	
	if mouse_pos.x > global_position.x:
		target = Vector2(player_pos.x + 10, player_pos.y - 55)
#		var velocity = position.direction_to(target) * speed # position.move_toward(, 55)
	else:
		target = Vector2(player_pos.x - 10, player_pos.y - 55)
#		var velocity = position.direction_to(target) * speed # position.move_toward(Vector2(player_pos.x - 26, player_pos.y + 20), 55)
	
	print(target.x)
	
	var velocity = global_position.direction_to(target) * speed
	if global_position.distance_to(target) > 20:
		velocity = move_and_slide(velocity)
