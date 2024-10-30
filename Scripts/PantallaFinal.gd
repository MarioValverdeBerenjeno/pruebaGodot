extends Control

@onready var label_score: Label = $VBoxContainer/LabelScore
@onready var label_health: Label = $VBoxContainer/LabelHealth

func _ready() -> void:
	label_score.text = "Final Score: " + str(Global.player_score)
	label_health.text = "Final Health: " + str(Global.player_health)

func _on_btn_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainMenu.tscn")
