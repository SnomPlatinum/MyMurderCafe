extends Node2D
var sandwicharray = ["Bread","Tomato","Bread","Tomato","Bread"]
var mypath = "res://SandwichItems/"
var currentspot = 0
const bodylocation = preload("res://yummy_object.tscn")
var fullpath = mypath + sandwicharray[currentspot] + "/" + sandwicharray[currentspot] + ".png"
var dropmore = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print(self.get_path())  # prints /root/Control/Node2D
	$AnimationPlayer.play("CursorMove")
	get_node("CurrentIngredient").texture=ResourceLoader.load(fullpath)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Click") and dropmore == true:
		fullpath = mypath + sandwicharray[currentspot] + "/" + sandwicharray[currentspot] + ".png"
		var instance = bodylocation.instantiate()
		get_parent().get_node("InstanceHolder").add_child(instance)
		
		instance.global_position = global_position
		instance.get_node("Sprite2D").texture =ResourceLoader.load(fullpath)
		if currentspot < sandwicharray.size()-1:
			currentspot += 1
			fullpath = mypath + sandwicharray[currentspot] + "/" + sandwicharray[currentspot] + ".png"
			get_node("CurrentIngredient").texture=ResourceLoader.load(fullpath)
		else:
			var cafenpcs = get_tree().get_nodes_in_group("cafenpc")
			dropmore = false
			currentspot = 0
			await get_tree().create_timer(1.0).timeout
			get_parent().hide()
			get_tree().paused = false
			get_tree().get_first_node_in_group("sandwich").Active = false
			#delete instances
			if get_owner().get_node("InstanceHolder").get_child_count() > 0:
				var children = get_owner().get_node("InstanceHolder").get_children()
				for c in children:
					get_owner().get_node("InstanceHolder").remove_child(c)
					c.queue_free()
			for c in len(cafenpcs):
				if cafenpcs[c].currentorder == true:
					cafenpcs[c].recipefinished = true
			get_tree().get_first_node_in_group("sandwich").Active
