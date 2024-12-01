extends CanvasModulate

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var currentcolor = get_parent().currentcolor
	color = lerp(color,currentcolor,0.1)
	pass
