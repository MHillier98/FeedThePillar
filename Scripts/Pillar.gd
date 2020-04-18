extends Sprite

func _ready():
	var anim = get_node("AnimationPlayer").get_animation("Fade")
	anim.set_loop(true)
	get_node("AnimationPlayer").play("Fade")
