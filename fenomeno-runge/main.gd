#extends Node2D
#
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
extends Node2D

@onready var plot = $Grafica
@onready var slider = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Slider_n
@onready var label = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Label_n
@onready var selector = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/Selector_nodes

var n = 10
var tipo_nodos := 0 # 0 = equidistantes, 1 = Chebyshev

func _ready():
	slider.min_value = 2
	slider.max_value = 40
	slider.step = 1
	slider.value = n
	
	selector.add_item("Equidistantes", 0)
	selector.add_item("Chebyshev", 1)
	
	slider.connect("value_changed", _on_slider_changed)
	selector.connect("item_selected", _on_selector_changed)
	
	update_ui()
	update_plot()

func _on_slider_changed(value):
	n = int(value)
	update_ui()
	update_plot()

func _on_selector_changed(index):
	tipo_nodos = index
	update_plot()

func update_ui():
	label.text = "n = %d" % n

func update_plot():
	plot.set_data(n, tipo_nodos)
