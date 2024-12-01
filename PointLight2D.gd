extends PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().get_first_node_in_group("base").time == "night":
		await get_tree().create_timer(3).timeout
		visible = true
	else:
		visible = false
