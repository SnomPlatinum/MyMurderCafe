extends Node2D
var mynode = preload("res://town_npc.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnnpcs(25)

func spawnnpcs(count):
	for i in count: #normally 25 during day
		var instance = mynode.instantiate()
		add_child(instance)

func childclear():
	var children = get_children()
	for c in children:
		remove_child(c)
		c.queue_free()
