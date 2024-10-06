extends Node

var score = 0
var score_required = 9
@onready var labelNode: Label = $"../Score/UI/Base/Label"

func add_point():
	score += 1
	labelNode.text = "Score: " + str(score)
	if score == score_required:
		win()

func win():
	get_tree().reload_current_scene()
