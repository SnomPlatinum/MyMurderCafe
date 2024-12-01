extends CharacterBody2D

@onready var animator = $AnimatedSprite2D
const SPEED = 100
const ACCELERATION = 1000
const FRICTION = 1000
var Sprint = 1
var Rotation = 0
var deadbody = false
var npcname = ""

func player_movement(input, delta):
	if deadbody == true:
		Sprint = 0.65
	elif Input.is_action_pressed("Sprint"):
		Sprint = 1.2
	else:
		Sprint = 1
	if input: 
		velocity = velocity.move_toward(input * SPEED * Sprint , delta * ACCELERATION)
	else: velocity = velocity.move_toward(Vector2(0,0), delta * FRICTION)
	#Decide rotation
	if Input.is_action_pressed("ui_down"):
		Rotation = 0
	elif Input.is_action_pressed("ui_right"):
		Rotation = 1
	elif Input.is_action_pressed("ui_up"):
		Rotation = 2
	elif Input.is_action_pressed("ui_left"):
		Rotation = 3


func _physics_process(delta):
	var input = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	player_movement(input, delta)
	move_and_slide()
	match Rotation:
			0: 
				if input:
					animator.play("WalkForwards")
				else:
					animator.play("IdleForward")
				if deadbody == true:
					get_node("DeadBody").get_node(npcname).play("forward")
					get_node("DeadBody").get_node(npcname).position.x = 0
					get_node("DeadBody").get_node(npcname).position.y = -12
			1:
				if input:
					animator.play("WalkRight")
				else:
					animator.play("IdleRight")
				if deadbody == true:
					get_node("DeadBody").get_node(npcname).play("left")
					get_node("DeadBody").get_node(npcname).position.x = -11
					get_node("DeadBody").get_node(npcname).position.y = -3
			2:
				if input:
					animator.play("WalkBack")
				else:
					animator.play("IdleBack")
				if deadbody == true:
					get_node("DeadBody").get_node(npcname).play("back")
					get_node("DeadBody").get_node(npcname).position.x = 1
					get_node("DeadBody").get_node(npcname).position.y = 8
			3:
				if input:
					animator.play("WalkLeft")
				else:
					animator.play("IdleLeft")
				if deadbody == true:
					get_node("DeadBody").get_node(npcname).play("right")
					get_node("DeadBody").get_node(npcname).position.x = 12
					get_node("DeadBody").get_node(npcname).position.y = -3

func addbody(NPCNAME):
	npcname = NPCNAME
	deadbody = true
	get_node("DeadBody").visible = true
	var fullpath = "res://deadbodies/" + NPCNAME + ".tscn"
	var mynode = load(fullpath)
	var Instance = mynode.instantiate()
	get_node("DeadBody").add_child(Instance)

func removebody():
	var child = get_node("DeadBody").get_node(npcname)
	child.queue_free()
	deadbody = false
