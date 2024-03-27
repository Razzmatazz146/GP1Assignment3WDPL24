extends Node2D

@onready var playerBody = $Player
@onready var fire_sfx = $FireSprite/FireSFX
var can_light = false
var can_door = false
var has_doored = false
var is_lit = false
@onready var interactLabel = $Player/Label
@onready var fireLight = $"FireSprite/Fire Light"
@onready var fireSmoke = $FireSprite/FireSmoke
@onready var fireLightPlayer = $FireSprite/FireLightAnimationPlayer
@onready var fire = $FireSprite
@onready var door_tiles = $Door
@onready var door_particles = $DoorParticles
@onready var wood_smash = $wood_smash_sfx
@onready var fire_light_sfx = $FireSprite/FireLightingSFX
@onready var overlay = $DarkOverlay

# Called when the node enters the scene tree for the first time.
func _ready():
	can_door = false
	interactLabel.visible = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var sin_timer = $Player/Timer
	if not sin_timer.time_left == 0:
		can_door = false
		interactLabel.visible = false
	
	if Input.is_action_just_pressed("interact"):
		if can_light:
			print("lighting fire")
			fireLight.enabled = true
			fireSmoke.emitting = true
			fireLightPlayer.play("light_flicker")
			fire_sfx.play()
			fire_light_sfx.play()
			fire.play("fire_lit")
			print("Fire on")
			is_lit = true
			interactLabel.visible = false
		if can_door:
			door_particles.emitting = true
			wood_smash.play()
			door_tiles.queue_free()
			has_doored = true
			interactLabel.visible = false
	
func _on_area_2d_body_entered(playerBody):
	print("player entered fire area")
	if not is_lit:
		can_light = true
		interactLabel.visible = true 


func _on_area_2d_body_exited(playerBody):
	can_light = false
	interactLabel.visible = false


func _on_door_area_body_entered(playerBody):
	if not has_doored:
		print("player entered door area")
		can_door = true
		interactLabel.visible = true


func _on_door_area_body_exited(playerBody):
	can_door = false
	interactLabel.visible = false
