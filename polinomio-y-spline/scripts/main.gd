extends Control
const NewtonInterpolator = preload("res://scripts/interpolation/newton_interpolator.gd")
const NaturalSpline = preload("res://scripts/interpolation/spline_natural.gd")
const ClampedSpline = preload("res://scripts/interpolation/spline_clamped.gd")
# =========================================================
# REFERENCIAS
# =========================================================

@onready var graph := $HSplitContainer/RightPanel/Graph2D

@onready var function_selector := $HSplitContainer/LeftPanel/VBoxContainer/HBox_f/FunctionSelector
@onready var nodes_spinbox := $HSplitContainer/LeftPanel/VBoxContainer/HBox_n/NodesSpinBox

@onready var original_cb = $HSplitContainer/LeftPanel/VBoxContainer/VBox_checkbox/CheckBox_f
@onready var newton_cb = $HSplitContainer/LeftPanel/VBoxContainer/VBox_checkbox/CheckBox_polinomio
@onready var spline_cb = $HSplitContainer/LeftPanel/VBoxContainer/VBox_checkbox/CheckBox_natural
@onready var clamped_cb = $HSplitContainer/LeftPanel/VBoxContainer/VBox_checkbox/CheckBox_campled
@onready var nodes_cb = $HSplitContainer/LeftPanel/VBoxContainer/VBox_checkbox/CheckBox_nodos
#@onready var a_edit = $HSplitContainer/LeftPanel/VBoxContainer/HBox_interval/OptionButton
#@onready var b_edit = $HSplitContainer/LeftPanel/VBoxContainer/HBox_interval/OptionButton2

@onready var deriv_start_sb = $HSplitContainer/LeftPanel/VBoxContainer/VBox_campled/HBox_campled/OptionButton
@onready var deriv_end_sb = $HSplitContainer/LeftPanel/VBoxContainer/VBox_campled/HBox_campled/OptionButton2
# =========================================================
# DATOS
# =========================================================

var current_function : Callable
var current_a := -6.0
var current_b := 6.0

# =========================================================
# GODOT
# =========================================================

func _ready():

	_setup_function_selector()

	# =========================
	# CONEXIONES UI
	# =========================

	function_selector.item_selected.connect(_on_function_changed)

	original_cb.toggled.connect(_on_ui_changed)
	newton_cb.toggled.connect(_on_ui_changed)
	spline_cb.toggled.connect(_on_ui_changed)
	clamped_cb.toggled.connect(_on_ui_changed)
	nodes_cb.toggled.connect(_on_ui_changed)

	deriv_start_sb.text_changed.connect(_on_ui_changed)
	deriv_end_sb.text_changed.connect(_on_ui_changed)

	nodes_spinbox.value_changed.connect(_on_ui_changed)



	# =========================
	# ESTADO INICIAL
	# =========================

	function_selector.select(0)

	_on_function_changed(0)
	
func _on_ui_changed(_value = null):
	_update_graph()
# =========================================================
# SETUP UI
# =========================================================

func _setup_function_selector():

	function_selector.clear()

	function_selector.add_item("sin(x)")
	function_selector.add_item("cos(x)")
	function_selector.add_item("exp(x/3)")
	function_selector.add_item("Runge")
	function_selector.add_item("|x|")

# =========================================================
# FUNCIONES TEST
# =========================================================

func f_sin(x):
	return sin(x)

func f_cos(x):
	return cos(x)

func f_exp(x):
	return exp(x/3.0 )

func f_runge(x):
	return 1.0 / (1.0 + x * x)

func f_abs(x):
	return abs(x)

# =========================================================
# EVENTOS
# =========================================================

func _on_function_changed(index):
	print("FUNCTION CHANGED:", index)

	match index:

		0:
			current_function = Callable(self, "f_sin")
			current_a = -6.0
			current_b = 6.0
			graph.set_view(
				current_a,
				current_b,
				-2.0,
				2.0
			)

		1:
			current_function = Callable(self, "f_cos")
			current_a = -6.0
			current_b = 6.0
			graph.set_view(
				current_a,
				current_b,
				-2.0,
				2.0
			)

		2:
			current_function = Callable(self, "f_exp")
			current_a = -6.0
			current_b = 6.0
			graph.set_view(
				current_a,
				current_b,
				-1.0,
				8.0
			)

		3:
			current_function = Callable(self, "f_runge")
			current_a = -5.0
			current_b = 5.0
			graph.set_view(
				current_a,
				current_b,
				-4.0,
				4.0
			)

		4:
			current_function = Callable(self, "f_abs")
			current_a = -6.0
			current_b = 6.0
			graph.set_view(
				current_a,
				current_b,
				0.0,
				6.5
			)

	_update_graph()

func _on_nodes_changed(value):

	_update_graph()


func _get_float(line_edit: LineEdit, default_value := 0.0) -> float:

	var t = line_edit.text.strip_edges()

	if t == "":
		return default_value

	return float(t)
# =========================================================
# ACTUALIZACIÓN GENERAL
# =========================================================

func _update_graph():

	var nodes = _generate_nodes()
	var a = -6.0
	var b = 6.0

	var newton = NewtonInterpolator.new(nodes)
	var spline = NaturalSpline.new(nodes)

	var functions = []

	# =========================
	# FUNCIÓN ORIGINAL
	# =========================
	if original_cb.button_pressed:
		functions.append({
			"func": current_function,
			"color": Color.WHITE
		})

	# =========================
	# NEWTON
	# =========================
	if newton_cb.button_pressed:
		var newton_f = func(x): return newton.evaluate(x)

		functions.append({
			"func": newton_f,
			"color": Color.RED
		})

	# =========================
	# SPLINE NATURAL
	# =========================
	if spline_cb.button_pressed:
		var spline_f = func(x): return spline.evaluate(x)

		functions.append({
			"func": spline_f,
			"color": Color.GREEN
		})
		
	# =========================
	# SPLINE CAMPLED
	# =========================
	if clamped_cb.button_pressed:
		var clamped = ClampedSpline.new(
		nodes,
		_get_float(deriv_start_sb,0.0),
		_get_float(deriv_end_sb,0.0)
	)
		var clamped_f = func(x):
			return clamped.evaluate(x)
		functions.append({
		"func": clamped_f,
		"color": Color.YELLOW
	})
	var margin = (b - a) * 0.02

	graph.set_view(
		a - margin,
		b + margin,
		graph.y_min,
		graph.y_max
)
	graph.set_functions(functions)
	graph.set_nodes(nodes)
	graph.set_show_nodes(nodes_cb.button_pressed)
# =========================================================
# GENERAR NODOS
# =========================================================

#func _generate_nodes():
#
	#var nodes = []
#
	#var n = int(nodes_spinbox.value)
#
	#var a = _get_float(a_edit, -6.0)
	#var b = _get_float(b_edit, 6.0)
#
	#for i in range(n):
#
		#var t = 0.0
		#if n > 1:
			#t = float(i) / float(n - 1)
#
		#var x = lerp(a, b, t)
		#var y = current_function.call(x)
#
		#nodes.append({"x": x, "y": y})
	#print(nodes)
	#return nodes
func _generate_nodes():

	var nodes = []

	var n = int(nodes_spinbox.value)

	var x0 = current_a
	var x1 = current_b

	for i in range(n):

		var t = 0.0

		if n > 1:
			t = float(i) / float(n - 1)

		var x = lerp(x0, x1, t)

		var y = current_function.call(x)

		nodes.append({
			"x": x,
			"y": y
		})

	return nodes
