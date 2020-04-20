extends CollisionShape2D


func _physics_process(_delta):
	var mouse_pos = get_global_mouse_position()
	var head_pos = global_position
	
	if (mouse_pos.x > head_pos.x + 20 or mouse_pos.x < head_pos.x - 20) and head_pos.distance_to(mouse_pos) > 10:
		look_at(mouse_pos)
