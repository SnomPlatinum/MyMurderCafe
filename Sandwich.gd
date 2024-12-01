extends StaticBody2D

@onready var interaction_area: InteractionArea = $Interaction_Area
@onready var SandwichMenu = get_parent().get_node("Player").get_node("Camera2D").get_node("SandwichMenu")
@export var Active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self,"_on_interact")
	pass # Replace with function body.

func _on_interact():
	if Active == true:
		SandwichMenu.show()
		SandwichMenu.get_node("Cursor").dropmore = true
	
	
