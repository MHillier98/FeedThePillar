extends Control

export(Color) var draw_colour

var player
var pillar
var pillar_light

func _ready():
	var main = get_tree().current_scene
	player = main.find_node("Player")
	pillar = main.find_node("PillarAccents")
	pillar_light = main.find_node("Light")
	set_process(true)


func _process(_delta):
	update()


func _draw():
	var player_pos = player.global_position
	var pillar_pos = pillar.global_position
	
	if player_pos.distance_to(pillar_pos) < 350:
		var distance = clamp(player_pos.distance_to(pillar_pos) / 3, 0, 100)
		
		# https://stackoverflow.com/questions/340209/generate-colors-between-red-and-green-for-a-power-meter
		var r = (255 * distance) / 100
		var g = (255 * (100 - distance)) / 100
		draw_colour = Color(r / 255, g / 255, 0)
		
		draw_line(player_pos, pillar_pos, Color(36 / 255, 35 / 255, 38 / 255), 7, true) # set a background / outline
		draw_line(player_pos, pillar_pos, draw_colour, 6, true) # set the line's colour
		
		pillar.modulate = Color(draw_colour.r, draw_colour.g, draw_colour.b, pillar.get_modulate().a) # set the pillar's accent colour
		pillar_light.color = draw_colour
		
		player.find_node("AnimatedHeadAccent").modulate = draw_colour # set the player's body colour
		player.find_node("AnimatedBodyAccent").modulate = draw_colour # set the player's body colour
