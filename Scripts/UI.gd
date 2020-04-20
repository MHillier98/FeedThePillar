extends Control


export(Color) var draw_colour

var main_scene
var player
var pillar
var pillar_light
var target = ""

func _ready():
	main_scene = get_tree().current_scene
	player = main_scene.find_node("Player")
	pillar = main_scene.find_node("PillarAccents")
	pillar_light = main_scene.find_node("Light")
	set_process(true)


func _process(_delta):
	update()


func set_target(new_target):
	target = new_target


func _draw():
	draw_pillar_player_light()
	
	if target == "Wraith":
		var wraith = main_scene.find_node("Wraith")
		draw_wraith_player_light(wraith)


func draw_pillar_player_light():
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


func draw_wraith_player_light(wraith):
	if wraith != null:
		var player_pos = player.global_position
		var wraith_pos = Vector2(wraith.global_position.x, wraith.global_position.y - 16)
		draw_line(player_pos, wraith_pos, Color(36 / 255, 35 / 255, 38 / 255), 7, true)
