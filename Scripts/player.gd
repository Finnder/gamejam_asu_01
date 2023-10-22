extends Node2D

@onready var player_attack_speed : float = 0.2
@onready var attacking : bool = false
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var tweens_completed : int = 0

enum POSITIONS {
	CENTER,
	LEFT,
	RIGHT,
	UP
}

var offsets: Dictionary = {
	POSITIONS.CENTER: Vector2(0, 0),
	POSITIONS.LEFT: Vector2(-50, 0),
	POSITIONS.RIGHT: Vector2(50, 0)
}

var current_position = POSITIONS.CENTER
var tween : Tween = null

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("left") and !attacking:
		attack_in_direction(POSITIONS.LEFT)
		sprite_2d.flip_h = true

	elif Input.is_action_just_pressed("right") and !attacking:
		attack_in_direction(POSITIONS.RIGHT)
		sprite_2d.flip_h = false

	if position.x > 1:
		sprite_2d.play("running")
	elif position.x < -1:
		sprite_2d.play("running")
	else:
		sprite_2d.play("idle")

func attack_in_direction(direction: int) -> void:
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func(): finished_attacking())

	var start_pos = position
	var target_pos = position + offsets[direction]

	tween.tween_property(self, "position", target_pos, player_attack_speed)
	tween.tween_property(self, "position", start_pos, player_attack_speed) # Added delay to ensure this tween starts after reaching the target.

	if !attacking:
		attacking = true
		tween.play()
	else:
		print("Player already is attacking")

func finished_attacking():
	print("player has finished attacking")
	attacking = false

