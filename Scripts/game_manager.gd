extends Node

var score = 0
@onready var labelNode: Label = $"../Score/UI/Base/Label"

func add_point():
	score += 1
	labelNode.text = "Score: " + str(score)
