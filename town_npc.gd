extends CharacterBody2D
var xpos = 0
var ypos = 0
var locationfound = false
var speed = 32
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var animator = $AnimatedSprite2D
var currentlocation = Vector2(xpos,ypos)
var dir = Vector2(xpos,ypos)
var moving = true
var alive = true
@onready var interaction_area: InteractionArea = $Interaction_Area





#LOADCHARACTERSETUP

var mypath = "res://NPCS/"
var path := DirAccess.open(mypath)
var file_names := path.get_files()
var npcname = "" 



# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite2D").play("SBlank")
	interaction_area.interact = Callable(self,"_on_interact")
	#animation setup
	var npc := file_names[randi() % file_names.size()]
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
	animator = Instance
	
	
	var navpath = get_tree().get_first_node_in_group("navregion")
	var navvertices = navpath.navigation_polygon.get_vertices()
	while locationfound == false:
		xpos = randi_range(-28,24)
		ypos = randi_range(-37,27)
		currentlocation = Vector2(xpos*16, ypos*16)
		var coords = Vector2(xpos,ypos)
		var tiledata = get_tree().get_first_node_in_group("navmap").get_cell_tile_data(-1,coords,false)
		if Geometry2D.is_point_in_polygon(currentlocation,navvertices) and ! tiledata:
			#print("yippee!")
			locationfound = true
			global_position.x = currentlocation.x
			global_position.y = currentlocation.y
	locationfound = false
	while locationfound == false:
		xpos = randi_range(-28,24)
		ypos = randi_range(-37,27)
		currentlocation = Vector2(xpos*16, ypos*16)
		var coords = Vector2(xpos,ypos)
		var tiledata = get_tree().get_first_node_in_group("navmap").get_cell_tile_data(-1,coords,false)
		if Geometry2D.is_point_in_polygon(currentlocation,navvertices) and ! tiledata:
			locationfound = true
			#print(currentlocation)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _physics_process(_delta: float) -> void:
	if moving == true:
		var next_path_pos := nav_agent.get_next_path_position()
		dir = global_position.direction_to(next_path_pos)
		velocity = dir * speed
		direction(dir,false)
		move_and_slide()
	else:
		direction(dir,true)
func makepath():
	nav_agent.target_position = currentlocation
	if nav_agent.is_target_reachable() == false:
		currentlocation = global_position
		nav_agent.target_position = currentlocation


func _on_navigation_agent_2d_target_reached():
	var navpath = get_tree().get_first_node_in_group("navregion")
	var navvertices = navpath.navigation_polygon.get_vertices()
	locationfound = false
	
	while locationfound == false:
		var xarray = [0,0,0]
		var yarray = [0,0,0]
		for I in 3:
			xarray[I] = randi_range(-28,24)
			yarray[I] = randi_range(-37,27)
		
		#I apologise for the horde of nested ifs :(
		if xpos > -2:
			if xarray[0] > xarray[1] and xarray[0] > xarray[2]:
				xpos = xarray[1]
			elif xarray[1] > xarray[2]:
				xpos = xarray[1]
			else:
				xpos = xarray[2]
		else:
			if xarray[0] < xarray[1] and xarray[0] < xarray[2]:
				xpos = xarray[1]
			elif xarray[1] < xarray[2]:
				xpos = xarray[1]
			else:
				xpos = xarray[2]
		
		#ypos time :sob:
		if ypos > -5:
			if yarray[0] > yarray[1] and yarray[0] > yarray[2]:
				ypos = yarray[0]
			elif yarray[1] > yarray[2]:
				ypos = yarray[1]
			else:
				ypos = yarray[2]
		else:
			if yarray[0] < yarray[1] and yarray[0] < yarray[2]:
				ypos = yarray[0]
			elif yarray[1] < yarray[2]:
				ypos = yarray[1]
			else:
				ypos = yarray[2]
		
		
		currentlocation = Vector2(xpos*16, ypos*16)
		var coords = Vector2(xpos,ypos)
		var tiledata = get_tree().get_first_node_in_group("navmap").get_cell_tile_data(-1,coords,false)
		if Geometry2D.is_point_in_polygon(currentlocation,navvertices) and ! tiledata:
			locationfound = true
	moving = false
	await get_tree().create_timer(randf_range(0,2)).timeout
	moving = true


func _on_timer_timeout():
	makepath()

func direction(dir,idle):
	var sqrt = sqrt(2)/2
	var direction = "right"
	if dir.x < sqrt and dir.x > -sqrt and dir.y > 0:
		direction = "down"
	elif dir.x < sqrt and dir.x > -sqrt and dir.y < 0:
		direction = "up"
	elif dir.x < -sqrt:
		direction = "left"
	pass
	if idle == false:
		match direction:
			"right":
				animator.play("WalkRight")
			"up":
				animator.play("WalkBack")
			"down":
				animator.play("WalkForwards")
			"left":
				animator.play("WalkLeft")
	else:
		match direction:
				"right":
					animator.play("IdleRight")
				"up":
					animator.play("IdleBack")
				"down":
					animator.play("IdleForward")
				"left":
					animator.play("IdleLeft")

func _on_interact():
	if get_tree().get_first_node_in_group("base").time == "night" and get_tree().get_first_node_in_group("player").deadbody == false:
		alive = false
		get_tree().get_first_node_in_group("player").addbody(npcname)
		queue_free()
	
	



func _on_coneofsight_area_entered(area):
	if get_tree().get_first_node_in_group("player").deadbody == true:
		get_node("AnimatedSprite2D").play("Surprise!")
		get_tree().get_first_node_in_group("canvas").color = Color(1,1,1)
		get_tree().get_first_node_in_group("base").time = "cafe"
		await get_tree().create_timer(1).timeout
		var instance = preload("res://GAMEOVER.tscn").instantiate()
		get_tree().get_first_node_in_group("player").add_child(instance)
		get_tree().get_first_node_in_group("player").global_position.x = 0
		get_tree().get_first_node_in_group("player").global_position.y = 0
		await get_tree().create_timer(4).timeout
		get_tree().get_first_node_in_group("base").reload()
