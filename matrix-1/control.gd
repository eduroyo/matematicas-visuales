extends Control

@onready var slider = $GridContainer/HSlider_a

@onready var label_a = $GridContainer/Label_a
@onready var label_b = $GridContainer/Label_b
@onready var label_c = $GridContainer/Label_c
@onready var label_d = $GridContainer/Label_d

@onready var label_1 = $HBoxContainer/GridContainer/Label
@onready var label_2 = $HBoxContainer/GridContainer/Label2
@onready var label_3 = $HBoxContainer/GridContainer/Label3
@onready var label_4 = $HBoxContainer/GridContainer/Label4

@onready var drawer = $"../MatrixDrawer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_a.text = "a = " + str(drawer.a)
	label_b.text = "b = " + str(drawer.b)
	label_c.text = "c = " + str(drawer.c)
	label_d.text = "d = " + str(drawer.d)
	
	label_1.text = "[ " + str(drawer.a) + " "
	label_2.text = str(drawer.b) + " ]"
	label_3.text = "[ " + str(drawer.c) + " "
	label_4.text = str(drawer.d) + " ]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_h_slider_a_value_changed(value: float) -> void:
	label_a.text = "a = " + str(value)
	label_1.text = "[ " + str(drawer.a) + " "
	drawer.a = value
	drawer.queue_redraw()

func _on_h_slider_b_value_changed(value: float) -> void:
	label_b.text = "b = " + str(value)
	label_2.text = str(drawer.b) + " ]"
	drawer.b = value
	drawer.queue_redraw()

func _on_h_slider_c_value_changed(value: float) -> void:
	label_c.text = "c = " + str(value)
	label_3.text =  "[ " + str(drawer.c) + " "
	drawer.c = value
	drawer.queue_redraw()

func _on_h_slider_d_value_changed(value: float) -> void:
	label_d.text = "d = " + str(value)
	label_4.text = str(drawer.d)  + " ]"
	drawer.d = value
	drawer.queue_redraw()
