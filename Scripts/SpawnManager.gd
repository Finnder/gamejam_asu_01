extends Node2D

# Load your enemy scene. Replace with the path to your enemy's .tscn file.
@onready var enemy_scene: PackedScene = preload("res://Scenes/enemy.tscn")

# Spawn interval in seconds
@onready var spawn_interval: float = 2.0
@onready var current_wave : int = 1

# Timer to control the spawn interval
var spawn_timer : Timer

func _ready():
	# Initialize the timer
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.timeout.connect(func(): _on_spawn_timer_timeout())
	add_child(spawn_timer)

# On spawner interval timer end
func _on_spawn_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	# Get a list of all child nodes and filter out non-spawners (like timers)
	var spawners = []
	for child in get_children():
		if child is Node2D and !(child is Timer):
			spawners.append(child)

	# Choose a random spawner position
	var random_spawner_index = randi() % spawners.size()
	var spawner_position: Node2D = spawners[random_spawner_index]

	# Instantiate the enemy at the chosen spawner's position
	var enemy_instance = enemy_scene.instantiate()

	if spawner_position.name == "spawner_right":
		enemy_instance.direction = Vector2(-1, 0) # move left
	elif spawner_position.name == "spawner_left":
		enemy_instance.direction = Vector2(1, 0) # move right

	enemy_instance.position = spawner_position.position

	get_parent().add_child(enemy_instance)  # Add the enemy to the parent node
