extends Node

onready var player = $Player
onready var pillar = $Pillar
#onready var pointLabel = $UI/Points

#export(int) var pillar_points = 0

var timer = 0

func _process(_delta):
	if timer > 500:
		update_points()
		timer = 0
	timer += 1

func update_points():
	var player_pos = player.global_position
	var fire_pos = pillar.global_position
	if player_pos.distance_to(fire_pos) < 350:
		var distance = clamp(player_pos.distance_to(fire_pos)/20, 0, 100)
		var points = int(clamp(20 - distance, 0, 20))
		
		var old_player_points = player.get_points()
		var player_points = clamp(old_player_points - points, 0, 9999999)
		player.set_points(player_points)
		
		var points_difference = old_player_points - player_points
		if points_difference > 0:
			pillar.add_points(points_difference)
#			pillar_points += points_difference
#			pointLabel.text = str(pillar_points)
