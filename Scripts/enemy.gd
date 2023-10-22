extends Node2D

@onready var speed: float = 100.0 # Adjust speed as necessary
@onready var direction: Vector2 = Vector2(0, 0)

func _ready() -> void:
	print("Spawned Enemy: ", name)
	print(speed)

func _physics_process(delta: float) -> void:
	# Move towards the player based on the given direction
	position.x += direction.x * speed * delta

	print(position, speed, delta)
