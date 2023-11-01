extends Node2D

var direction: Vector2

@onready var DEFAULT_SPEED: float = 4.0
@onready var speed: float = DEFAULT_SPEED
@onready var health: int = 100

@onready var push_back_distance: int = 40
@onready var progress_bar = $ProgressBar
@onready var sprite_2d = $Sprite2D

var getting_hit : bool = false

func _ready() -> void:
	print("Spawned Enemy: ", name)
	update_ui()

func _physics_process(delta: float) -> void:
	position.x += (speed * direction.x)

	if getting_hit:
		position -= position.lerp(Vector2(direction.normalized().x * push_back_distance, 0), 1)
		print(position)


func take_hit():



	got_hit()

	# Take damage
	health -= 50
	update_ui()

	if health <= 0:
		die()

func die():
	queue_free()

func got_hit():
	getting_hit = true
	speed = 0
	sprite_2d.play("idle")

	var timer = Timer.new()
	timer.timeout.connect(func(): on_hit_timer_end())
	timer.wait_time = 0.1
	add_child(timer)
	timer.start()

func on_hit_timer_end():
	speed = DEFAULT_SPEED
	getting_hit = false
	sprite_2d.play("default")


func update_ui():
	progress_bar.value = health
