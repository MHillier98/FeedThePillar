extends Node


onready var player = $Player
onready var pillar = $Pillar
onready var timerPanel = $CanvasLayer/HUD/Timer

var timer = 0 # timer for points

var time = 0 # timer for counter
var time_mult = 1.0
var paused = false


func _ready():
	set_process(true)


func _process(delta):
	if timer > 500:
		update_points()
		timer = 0
	timer += 1
	
	if not paused:
		time += delta * time_mult
		timerPanel.text = "Survival Time: " + str(int(time)) + "s"


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
