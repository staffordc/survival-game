extends Node
class_name Need

var value: float
@export var max_value: float
@export var start_value: float
@export var regen_rate: float
@export var decay_rate: float
@export var ui_bar: Node

#values increase over time until bar is full
func add(amount):
	value += amount
	
	if value > max_value:
		value = max_value

#values decrease until empty and health also decreases
func subtract(amount):
	value -= amount
	
	if value < 0:
		value = 0

func update_ui_bar():
	ui_bar.update_value(value, max_value)
