extends CollisionShape2D


func _physics_process(_delta):
	var mouse_pos = get_global_mouse_position()
	
	if (mouse_pos.x > global_position.x + 20 or mouse_pos.x < global_position.x - 20) and global_position.distance_to(mouse_pos) > 10:
		look_at(mouse_pos)
