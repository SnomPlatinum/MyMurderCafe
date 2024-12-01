extends PathFollow2D
var speed = 0.1
@onready var npcspot = get_tree().get_first_node_in_group("cafemanager").npcs + 1
@onready var currentqueue = 1 + float(1)/30 -(float(npcspot)/30)
var moving = true
@onready var animationspot = get_node("CAFENPC2").get_node(get_node("CAFENPC2").npcname)

# Called when the node enters the scene tree for the first time.
func _ready():
	print(npcspot)
	print(currentqueue)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress_ratio < currentqueue:
		progress_ratio += delta * speed

func queueforward():
	currentqueue += float(1)/30
	npcspot = get_tree().get_first_node_in_group("cafemanager").npcs + 1

var _position_last_frame := Vector2()
var _cardinal_direction = 0

func _physics_process(delta):
	# Get motion vector between previous and current position
	var motion = position - _position_last_frame
	if motion.x == 0 and motion.y == 0:
		moving = false
	else:
		moving = true

	# If the node actually moved, we'll recompute its direction.
	# If it didn't, we'll just the last known one.
	if motion.length() > 0.0001:
		# Now if you want a value between N.S.W.E,
		# you can use the angle of the motion.
		# I came up with this formula last time I needed it:
		_cardinal_direction = int(4.0 * (motion.rotated(PI / 4.0).angle() + PI) / TAU)

	# And now you have it!
	# You can even use it with an array since it's like an index
	match _cardinal_direction:
		0:
			if moving == true:
				animationspot.play("WalkLeft")
			else:
				animationspot.play("IdleLeft")
		1:
			if moving == true:
				animationspot.play("WalkBack")
			else:
				animationspot.play("IdleBack")
		2:
			if moving == true:
				animationspot.play("WalkRight")
			else:
				animationspot.play("IdleRight")
		3:
			if moving == true:
				animationspot.play("WalkForward")
			else:
				animationspot.play("IdleForward")

	# Remember our current position for next frame
	_position_last_frame = position
