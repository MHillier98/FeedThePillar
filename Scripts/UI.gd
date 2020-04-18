extends Control

var player
var fire

var player_pos = Vector2(0, 0)
var fire_pos = Vector2(0, 0)

export(Color) var draw_colour  # = Color(0, 0, 0)

func _ready():
	var main = get_tree().current_scene
	player = main.find_node("Player")
	fire = main.find_node("Fire")
	
	set_process(true)

func _process(_delta):
	player_pos = player.global_position
	fire_pos = fire.global_position
	
#	print("-----")

	update()

func _draw():

#	randomize()
#	var r = rand_range(0, 1)
#	randomize()
#	var g = rand_range(0, 1)
#	randomize()
#	var b = rand_range(0, 1)
#	draw_colour = Color(r, g, b)



	var distance = clamp(player_pos.distance_to(fire_pos)/4, 20, 100)
#	print(distance)
#	draw_colour = Color.from_hsv(1 - clamp(distance/800, 0, 0.65), 1.0, 0)

	var r = (255 * distance) / 100
	var g = (255 * (100 - distance)) / 100
	
	draw_colour = Color(r/255, g/255, 0)
	
	draw_line(player_pos, fire_pos, draw_colour, 6, true)
