extends ProgressBar

@export var need_name: String

@onready var text: Label = get_node("NeedText")

#changed "max" to maxValue so there wan't name ambiguity
func update_value (new_value, maxValue):
	max_value = maxValue
	value = new_value
	
	text.text = str(need_name, " : ", int(value), "/", int(max_value))
	
