extends Node2D

@onready var player_health : int = 100
@onready var global_ui = $"../GlobalUI"

@onready var area_rect = $"../GlobalUI/AreaRect"
@onready var area_rect_2 = $"../GlobalUI/AreaRect2"

@onready var saved_color_rect_01 = area_rect.color
@onready var saved_color_rect_02 = area_rect_2.color

@onready var wave_number_label = $"../GlobalUI/WaveLabel/WaveNumberLabel"
@onready var health_bar = $"../GlobalUI/HealthBar"


# On Enter Area
func _on_area_2d_left_body_entered(body):
	global_ui.get_node("AreaRect2").color = Color(100, 0, 0, 0.1);

func _on_area_2d_right_body_entered(body):
	global_ui.get_node("AreaRect").color = Color(100, 0, 0, 0.1);


# On Leave Area
func _on_area_2d_left_body_exited(body):
	global_ui.get_node("AreaRect2").color = saved_color_rect_01;

func _on_area_2d_right_body_exited(body):
	global_ui.get_node("AreaRect").color = saved_color_rect_02;


func _on_area_2d_base_body_entered(body):
	if body.is_in_group("enemy"):
		body.queue_free()
		player_health -= 1
		health_bar.value = player_health
		body.take_hit()
		print(player_health)
