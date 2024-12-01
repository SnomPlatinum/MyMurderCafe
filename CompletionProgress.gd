extends ProgressBar
@onready var MilkProg = $MilkButton/MilkProgress.value
@onready var HeatProg = $HeatButton/HeatProgress.value
@onready var CoffeeProg = $CoffeeButton/CoffeeProgress.value
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _startup():
	value = 0
	$MilkButton/MilkProgress.value = 0
	$HeatButton/HeatProgress.value = 0
	$CoffeeButton/CoffeeProgress.value = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	MilkProg = $MilkButton/MilkProgress.value
	HeatProg = $HeatButton/HeatProgress.value
	CoffeeProg = $CoffeeButton/CoffeeProgress.value
	if MilkProg > 50 and MilkProg < 90 and HeatProg > 50 and HeatProg < 80 and CoffeeProg > 50 and CoffeeProg < 80:
		value += 0.1 #typically 0.1
	else: value -= 0.05
	if value == 100:
		Engine.time_scale = 1
		get_parent().hide()
		$MilkButton/MilkProgress.ButtonOn = false
		$HeatButton/HeatProgress.ButtonOn = false
		$CoffeeButton/CoffeeProgress.ButtonOn = false
		var cafenpcs = get_tree().get_nodes_in_group("cafenpc")
		for c in len(cafenpcs):
				if cafenpcs[c].currentorder == true:
					cafenpcs[c].recipefinished = true
		get_tree().get_first_node_in_group("coffee").Active = true
		
