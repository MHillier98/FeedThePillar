extends KinematicBody2D

export (int) var speed = 400

var velocity = Vector2()

onready var animationPlayer = $AnimationPlayer

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
#	if Input.is_action_pressed('down'):
#		velocity.y += 1
#	if Input.is_action_pressed('up'):
#		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
	if get_global_mouse_position().x < global_position.x:
		animationPlayer.play("Look Left")
		get_node("HeadCollisionShape/HeadSprite").set_flip_v(true)
		yield(animationPlayer, "animation_finished")
	else:
		animationPlayer.play("Look Right")
		get_node("HeadCollisionShape/HeadSprite").set_flip_v(false)
		yield(animationPlayer, "animation_finished")
