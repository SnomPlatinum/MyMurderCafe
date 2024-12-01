extends Node2D
var mynode = preload("res://CafeExpanded.tscn")
var spawning = true
var npcs = 0
var maxnpcs =  randi_range(6,10) #2 for testing
var npcsspawned = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnnpc()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawning == true:
		spawning = false
		await get_tree().create_timer(randi_range(10,30)).timeout
		spawnnpc()
		spawning = true
	pass

func spawnnpc():
	if npcs < 5 and npcsspawned < maxnpcs:
		var instance = mynode.instantiate()
		get_node("Path2D").add_child(instance)
		npcs += 1
		npcsspawned += 1

