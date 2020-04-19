extends KinematicBody2D


export(int) var points = 0 setget set_points, get_points

onready var pointsLabel = $PointsLabel
onready var animationPlayer = $AnimationPlayer

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 260
const JUMP_HEIGHT = -250

var motion = Vector2()


func _physics_process(_delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed('right'):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed('left'):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	else:
		friction = true
	
	if is_on_floor():
		if Input.is_action_pressed('up'):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		motion.x = lerp(motion.x, 0, 0.05)

	motion = move_and_slide(motion, UP)
	
	if get_global_mouse_position().x < global_position.x:
		animationPlayer.play("Look Left")
		get_node("HeadCollisionShape/HeadSprite").set_flip_v(true)
		yield(animationPlayer, "animation_finished")
	else:
		animationPlayer.play("Look Right")
		get_node("HeadCollisionShape/HeadSprite").set_flip_v(false)
		yield(animationPlayer, "animation_finished")


func set_points(new_points):
	points = clamp(new_points, 0, 9999999)
	update_text()


func get_points():
	return points


func update_text():
	if pointsLabel != null:
		pointsLabel.text = str(get_points())
