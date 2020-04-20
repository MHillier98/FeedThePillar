extends Sprite


export(int) var points = 0 setget set_points, get_points

onready var pointsLabel = $PointsLabel

signal end_game

var timer = 0
var game_started = false


func _ready():
	var anim = get_node("AnimationPlayer").get_animation("Fade")
	anim.set_loop(true)
	update_text()
	get_node("AnimationPlayer").play("Fade")
	game_started = false
#	yield(get_tree().create_timer(2), "timeout")


func _physics_process(delta):
	if game_started == true:
		if points < 1:
			pointsLabel.hide()
			get_tree().paused = true
			game_started = false
			emit_signal("end_game")

		if timer > (450 * delta):
			points = clamp(points - 1, 0, 9999999)
			update_text()
			timer = 0

		timer += 1


func set_points(new_points):
	points = clamp(new_points, 0, 9999999)
	update_text()


func get_points():
	return points


func add_points(new_points):
	points += new_points
	update_text()


func update_text():
	if pointsLabel != null:
		var points = get_points()
		if points > 0:
			game_started = true
			pointsLabel.text = str(points)
		else:
			pointsLabel.text = ""
