extends ProgressBar
var ButtonOn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ButtonOn == true:
		value += 0.2
	else:
		value -= 0.075


func _on_milk_button_toggled(toggled_on):
	if ButtonOn == false:
		ButtonOn = true
	else: ButtonOn = false