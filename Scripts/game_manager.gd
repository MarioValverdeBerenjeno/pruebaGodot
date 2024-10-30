extends Node

var score_required = 9
@onready var labelNode: Label = $"../Score/UI/Base/Label"

func add_point(points: int):
	Global.player_score += points
	labelNode.text = "Score: " + str(Global.player_score)
	#if score == score_required:
		#win()

func win():
	get_tree().reload_current_scene()
