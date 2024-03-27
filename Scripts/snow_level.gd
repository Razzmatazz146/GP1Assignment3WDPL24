extends Node2D

@onready var playerBody = $Player
@onready var fire_sfx = $FireSprite/FireSFX
@onready var can_light = false
@onready var can_door = false
@onready var has_doored = false
@onready var is_lit = false
@onready var interactLabel = $Player/Label
@onready var fireLight = $"FireSprite/Fire Light"
@onready var fireSmoke = $FireSprite/FireSmoke
@onready var fireLightPlayer = $FireSprite/FireLightAnimationPlayer
@onready var fire = $FireSprite
@onready var door_tiles = $Door
@onready var door_particles = $DoorParticles
@onready var wood_smash = $wood_smash_sfx
@onready var fire_light_sfx = $FireSprite/FireLightingSFX

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
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
