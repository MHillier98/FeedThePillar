extends Node2D


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("die")
		body.add_points(500)
		queue_free()
