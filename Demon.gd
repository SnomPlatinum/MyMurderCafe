extends StaticBody2D

@onready var interaction_area: InteractionArea = $Interaction_Area
# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self,"_on_interact")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().get_first_node_in_group("base").time == "night":
		visible = true
	else:
		visible = false
	

func _on_interact():
	if get_tree().get_first_node_in_group("player").deadbody == true:
		get_tree().get_first_node_in_group("player").removebody()
		get_tree().get_first_node_in_group("base").bodies += 1
