extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var player_sprite = $Sprite2D
@onready var player = $"."

const SPEED = 100
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		if velocity.x > 0:
			player_sprite.flip_h = false
		elif velocity.x < 0:
			player_sprite.flip_h = true
		animation_player.play("run2")
		velocity.x = direction * SPEED
	else:
		animation_player.play("idle2")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



