extends CollisionShape2D

#export (int) var speed = 20

func get_input():
	var mouse_pos = get_global_mouse_position()
	
	if (mouse_pos.x > global_position.x + 20 or mouse_pos.x < global_position.x - 20) and global_position.distance_to(mouse_pos) > 10:
		look_at(mouse_pos)

func _physics_process(_delta):
	get_input()
