extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = get_parent().dir
	var sqrt = sqrt(2)/2
	if direction.x < sqrt and direction.x > -sqrt and direction.y > 0:
		rotation = deg_to_rad(180)
	elif direction.x < sqrt and direction.x > -sqrt and direction.y < 0:
		rotation = deg_to_rad(0)
	elif direction.x < -sqrt:
		rotation = deg_to_rad(270)
	else:
		rotation = deg_to_rad(90)
