extends Node


onready var player = $Player
onready var pillar = $Pillar
onready var timer_panel = $CanvasLayer/HUD/Timer
onready var power_line = $PowerLine
onready var notes = $PowerLine/Notes
onready var game_over = $CanvasLayer/HUD/GameOver
onready var restart_button = $CanvasLayer/HUD/RestartButton


var new_wraith = preload("res://Scenes/Wraith.tscn")

var timer = 0 # timer for points

var time = 0 # timer for counter
var time_mult = 1.0
var paused = true


func _ready():
	var wraith = spawn_wraith()
	player.set_wraith(wraith)
	notes.show()
	game_over.hide()
	restart_button.hide()
	set_process(true)


func _physics_process(delta):
	if timer > (450 * delta):
		update_points()
		timer = 0

	timer += 1

	if not paused:
		time += delta * time_mult
		timer_panel.text = "Survival Time: " + str(int(time)) + "s"


func update_points():
	var player_pos = player.global_position
	var pillar_pos = pillar.global_position

	if player_pos.distance_to(pillar_pos) < 350:
		var distance = clamp(player_pos.distance_to(pillar_pos)/20, 0, 100)
		var points = int(clamp(20 - distance, 0, 20))
		var old_player_points = player.get_points()
		var player_points = clamp(old_player_points - points, 0, 9999999)

		player.set_points(player_points)
		var points_difference = old_player_points - player_points

		if points_difference > 0:
			pillar.add_points(points_difference)
			paused = false


func _on_Wraith_died():
	player.clear_wraith()
#	print("we need another wraith!")
	var wraith = spawn_wraith()
	player.set_wraith(wraith)
	power_line.clear_target()


func spawn_wraith():
	var new_wraith_instance = new_wraith.instance()
	new_wraith_instance.set_name("Wraith")
	new_wraith_instance.connect("died", self, "_on_Wraith_died")

	randomize()
	var pos_x = rand_range(-400, 1000)
	var pos_y = rand_range(110, 200)

	new_wraith_instance.position = Vector2(pos_x, pos_y)
	add_child(new_wraith_instance)
	return new_wraith_instance


func _on_Pillar_end_game():
#	yield(get_tree().create_timer(2), "timeout")
	notes.hide()
	game_over.show()
	restart_button.show()
#	get_tree().paused = false


func _on_RestartButton_button_up():
	var new_scene = get_tree().reload_current_scene()
	get_tree().paused = false
	if new_scene != 0: # Error.OK
		print(new_scene)
