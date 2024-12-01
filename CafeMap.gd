extends Node2D
const dawncolor = Color(1,0.746,0.859)
const daycolor = Color(1,1,1)
const duskcolor = Color(1,0.847,0.703)
const nightcolor = Color(0.049,0.099,0.159) #(0.341,0.345,0.478) for brighter
var currentcolor = dawncolor
var music = "res://Cafe_theme.mp3"
var bodies = 0
var bodiesrequired = 3

var time = "cafe" #Time will always be morning, cafe(day) or night
@onready var timesegments = 1/float(get_tree().get_first_node_in_group("cafemanager").maxnpcs)
var currenttime = float(0) #currenttime will always end at 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currenttime == 1:
		newtime()
		currenttime = 0
	if bodies == 3:
		currenttime = 1
		bodies = 0
	pass

func cafetimemanager():
	var previouscolor = currentcolor
	currenttime += timesegments
	print(currenttime)
	if currenttime < float(1)/3:
		currentcolor = (3*currenttime*daycolor) + (1-3*currenttime)*dawncolor #first variable increases, second variable decreases
	elif currenttime < float(2)/3:
		currentcolor = daycolor
	elif currenttime < float(5)/6:
		currentcolor = (6*currenttime-4)*duskcolor + (5-6*currenttime)*daycolor
	elif currenttime > float(5)/6:
		currentcolor = (6-6*currenttime) *duskcolor + (6*currenttime-5)*nightcolor
	currentcolor.a = 1
	print(currentcolor)

func nighttimemanager():
	pass


func newtime():
	match time:
		"morning": 
			time = "cafe"
			
		"cafe": 
			for c in get_node("CafeWalls2").get_children():
				c.disabled = true
			var instance = preload("res://night_fade.tscn").instantiate()
			get_tree().get_first_node_in_group("player").add_child(instance)
			nighttimemanager()
			get_tree().get_first_node_in_group("npcmanagement").childclear()
			get_tree().get_first_node_in_group("npcmanagement").spawnnpcs(15)
			await get_tree().create_timer(5).timeout
			instance.queue_free()
			time = "night"
			music = "res://Night_music.mp3"
			bodies = 0
		"night": 
			time = "cafe"
			music = "res://Cafe_theme.mp3"
			for c in get_node("CafeWalls2").get_children():
				c.disabled = false
			get_tree().get_first_node_in_group("npcmanagement").childclear()
			get_tree().get_first_node_in_group("npcmanagement").spawnnpcs(15)
			get_tree().get_first_node_in_group("cafemanager").maxnpcs = randi_range(6,14)
			get_tree().get_first_node_in_group("cafemanager").npcs = 0
			currentcolor = dawncolor
			get_node("TimeCanvas").color = currentcolor
			var instance = preload("res://night_fade.tscn").instantiate()
			get_tree().get_first_node_in_group("player").add_child(instance)
			await get_tree().create_timer(4).timeout
			reload()
	get_node("Musicplayer").stream = load(music)
	get_node("Musicplayer").playing = true

func reload():
	get_tree().reload_current_scene()
	
func clear():
	for c in get_node("CafeWalls2").get_children():
		c.disabled = false
	get_tree().get_first_node_in_group("npcmanagement").childclear()
	get_tree().get_first_node_in_group("npcmanagement").spawnnpcs(15)
	get_tree().get_first_node_in_group("cafemanager").maxnpcs = randi_range(6,14)
	get_tree().get_first_node_in_group("cafemanager").npcs = 0
	currentcolor = dawncolor
	get_node("TimeCanvas").color = currentcolor
