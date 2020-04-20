extends Sprite


export(int) var points = 0 setget set_points, get_points

onready var pointsLabel = $PointsLabel

var timer = 0
var started = false

func _ready():
	var anim = get_node("AnimationPlayer").get_animation("Fade")
	anim.set_loop(true)
	update_text()
	get_node("AnimationPlayer").play("Fade")


func _physics_process(delta):
	if started == true:
		if points == 0:
			get_tree().paused = true
		
		if timer > (450 * delta):
			points = clamp(points - 1, 0, 9999999)
			update_text()
			timer = 0
		
		timer += 1


func set_points(new_points):
	points = clamp(new_points, 0, 9999999)
	started = true
	update_text()


func get_points():
	return points


func add_points(new_points):
	points += new_points
	started = true
	update_text()


func update_text():
	if pointsLabel != null:
		pointsLabel.text = str(get_points())
