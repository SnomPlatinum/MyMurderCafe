extends Node2D

@onready var interaction_area: InteractionArea = get_node("Interaction_Area")
var complete = false
var recipefinished = false
var currentorder = false
var npcname = "AnimatedSprite2D"


#LOADCHARACTERSETUP

var mypath = "res://NPCS/"
var dir := DirAccess.open(mypath)
var file_names := dir.get_files()

# Called when the node enters the scene tree for the first time.
func _ready():
	var npc := file_names[randi() % file_names.size()]
	npcname = ""
	var complete = false
	for I in len(npc):
		if npc[I] != "." and complete != true:
			npcname += npc[I]
		else:
			complete = true
	var filepath = mypath + npc
	var mynode = load(filepath)
	var Instance = mynode.instantiate()
	add_child(Instance)
	Instance.position.x = -1
	Instance.position.y = -7
	interaction_area.interact = Callable(self,"_on_interact")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_interact():
	if complete != true:
		_createorder()
	elif currentorder == true and recipefinished == true:
		get_tree().get_first_node_in_group("base").cafetimemanager()
		get_tree().get_first_node_in_group("cafemanager").spawnnpc()
		get_tree().get_first_node_in_group("cafemanager").npcs -= 1
		if get_tree().get_first_node_in_group("cafemanager").get_child_count() > 0:
			var children = get_tree().get_first_node_in_group("cafemanager").get_node("Path2D").get_children()
			for c in children:
				c.queueforward()
				c.get_node("CAFENPC2").recipefinished = false
		get_parent().queue_free()



func _createorder():
	complete = true
	currentorder = true
	var coffeeorsandwich = randi_range(1,2)
	const ingredients = ["Bacon","Lettuce","Tomato","Cheese"]
	if coffeeorsandwich == 1:
		#enable sandwich
		get_node("Interaction_Area").action_name = "res://SandwichDialogue-export.png"
		var SandwichArray = []
		var Itemcount = randi_range(3,5)
		for I in Itemcount:
			SandwichArray.append("")
		SandwichArray[0] = "Bread"
		SandwichArray[Itemcount-1] = "Bread"
		for I in range(1,Itemcount-1):
			SandwichArray[I] = ingredients[randi_range(0,3)]
		print(SandwichArray)
		get_tree().get_first_node_in_group("sandwich").Active = true
		get_tree().get_first_node_in_group("sandwichmenu").get_node("Cursor").sandwicharray = SandwichArray
	else:
		get_node("Interaction_Area").action_name = "res://CoffeeInteract.png"
		var coffeeorder = true
		get_tree().get_first_node_in_group("coffee").Active = true
		pass
		
