extends StaticBody2D

@onready var interaction_area: InteractionArea = $Interaction_Area
@onready var coffee_menu = get_parent().get_node("Player").get_node("Camera2D").get_node("CoffeeMenu")
@export var Active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self,"_on_interact")
	pass # Replace with function body.

func _on_interact():
	if Active == true:
		coffee_menu.show()
		coffee_menu.get_node("CompletionProgress")._startup()
		Engine.time_scale = 0
	
	
