extends ProgressBar
var ButtonOn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ButtonOn == true:
		value += 0.125
	else:
		value -= 0.05





func _on_coffee_button_toggled(toggled_on):
	if ButtonOn == false:
		ButtonOn = true
	else: ButtonOn = false
