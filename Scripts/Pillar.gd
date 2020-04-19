extends Sprite


export(int) var points = 0 setget set_points, get_points

onready var pointsLabel = $PointsLabel

var timer = 0


func _ready():
	var anim = get_node("AnimationPlayer").get_animation("Fade")
	anim.set_loop(true)
	get_node("AnimationPlayer").play("Fade")


func _process(_delta):
	if timer > 600:
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
		pointsLabel.text = str(get_points())
