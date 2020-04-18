extends Control

var player
var fire

export(Color) var draw_colour

func _ready():
	var main = get_tree().current_scene
	player = main.find_node("Player")
	fire = main.find_node("Fire")
	set_process(true)

func _process(_delta):
	update()

func _draw():
	var player_pos = player.global_position
	var fire_pos = fire.global_position
	var distance = clamp(player_pos.distance_to(fire_pos)/4, 20, 100)
	
	# https://stackoverflow.com/questions/340209/generate-colors-between-red-and-green-for-a-power-meter
	var r = (255 * distance) / 100
	var g = (255 * (100 - distance)) / 100
	draw_colour = Color(r / 255, g / 255, 0)
	
	draw_line(player_pos, fire_pos, draw_colour, 6, true)
