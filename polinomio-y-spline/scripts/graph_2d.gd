extends Control

class_name Graph2D

# =========================================================
# CONFIGURACIÓN VISUAL
# =========================================================

@export var background_color := Color(0.08, 0.08, 0.08)
@export var axis_color := Color.WHITE
@export var grid_color := Color(0.3, 0.3, 0.3, 0.5)

@export var function_color := Color.CYAN
@export var node_color := Color(0.773, 0.161, 0.435, 0.992)

@export var axis_width := 2.0
@export var grid_width := 1.0
@export var curve_width := 2.5

# =========================================================
# RANGO MATEMÁTICO VISIBLE
# =========================================================

@export var x_min := -5.0
@export var x_max := 5.0

@export var y_min := -5.0
@export var y_max := 5.0

# =========================================================
# GRID
# =========================================================

@export var grid_step_x := 1.0
@export var grid_step_y := 1.0
@export var tick_size := 6.0
@export var label_color := Color.WHITE
@export var font_size := 14
var default_font := ThemeDB.fallback_font


# =========================================================
# FUNCIÓN ACTUAL
# =========================================================

var functions := []

# =========================================================
# NODOS DE INTERPOLACIÓN
# =========================================================

var interpolation_nodes := []
var show_nodes := false

# =========================================================
# GODOT
# =========================================================

func set_show_nodes(value: bool):
	show_nodes = value
	queue_redraw()

func _ready():
	queue_redraw()
	
func fit_square_grid():
	fit_square_grid()
	var rect = get_rect()

	var aspect = rect.size.x / rect.size.y

	var x_range = x_max - x_min

	var desired_y_range = x_range / aspect

	var y_center = (y_min + y_max) * 0.5

	y_min = y_center - desired_y_range * 0.5
	y_max = y_center + desired_y_range * 0.5

func _draw():
	print(size)

	var rect = get_rect()

	# Fondo
	draw_rect(rect, background_color, true)

	# Grid
	_draw_grid(rect)

	# Ejes
	_draw_axes(rect)

	# Funciones

	for item in functions:

		_draw_function(
			item.func,
			item.color
		)
	# Nodos
	_draw_nodes()

# =========================================================
# CONVERSIÓN COORDENADAS
# =========================================================

#func math_to_screen(x: float, y: float) -> Vector2:
#
	#var rect = get_rect()
#
	#var screen_x = remap(
		#x,
		#x_min,
		#x_max,
		#0.0,
		#rect.size.x
	#)
#
	#var screen_y = remap(
		#y,
		#y_min,
		#y_max,
		#rect.size.y,
		#0.0
	#)
#
	#return Vector2(screen_x, screen_y)
func math_to_screen(x: float, y: float) -> Vector2:

	var rect = get_rect()

	var world_width = x_max - x_min
	var world_height = y_max - y_min

	# Escala uniforme
	var scale = min(
		rect.size.x / world_width,
		rect.size.y / world_height
	)

	# Tamaño real usado por la gráfica
	var used_width = world_width * scale
	var used_height = world_height * scale

	# Centrar contenido
	var offset_x = (rect.size.x - used_width) / 2.0
	var offset_y = (rect.size.y - used_height) / 2.0

	var screen_x = offset_x + (x - x_min) * scale

	var screen_y = rect.size.y - (
		offset_y + (y - y_min) * scale
	)

	return Vector2(screen_x, screen_y)
# =========================================================
# GRID
# =========================================================

func _draw_grid(rect):

	# Verticales
	var x = ceil(x_min / grid_step_x) * grid_step_x

	while x <= x_max:

		var p1 = math_to_screen(x, y_min)
		var p2 = math_to_screen(x, y_max)

		draw_line(
			p1,
			p2,
			grid_color,
			grid_width
		)

		x += grid_step_x

	# Horizontales
	var y = ceil(y_min / grid_step_y) * grid_step_y

	while y <= y_max:

		var p1 = math_to_screen(x_min, y)
		var p2 = math_to_screen(x_max, y)

		draw_line(
			p1,
			p2,
			grid_color,
			grid_width
		)

		y += grid_step_y

# =========================================================
# EJES
# =========================================================

#func _draw_axes(rect):
#
	## Eje X
	#if y_min <= 0.0 and y_max >= 0.0:
#
		#var p1 = math_to_screen(x_min, 0.0)
		#var p2 = math_to_screen(x_max, 0.0)
#
		#draw_line(
			#p1,
			#p2,
			#axis_color,
			#axis_width
		#)
#
	## Eje Y
	#if x_min <= 0.0 and x_max >= 0.0:
#
		#var p1 = math_to_screen(0.0, y_min)
		#var p2 = math_to_screen(0.0, y_max)
#
		#draw_line(
			#p1,
			#p2,
			#axis_color,
			#axis_width
		#)
		
func nice_step(range_size: float) -> float:
	var rough = range_size / 10.0

	var pow10 = pow(10, floor(log(rough) / log(10)))

	var candidates = [1, 2, 5, 10]

	var best = pow10
	for c in candidates:
		var v = c * pow10
		if v >= rough:
			best = v
			break

	return best
	
func _draw_axes(rect):

	# =========================
	# EJE X
	# =========================

	if y_min <= 0.0 and y_max >= 0.0:

		var p1 = math_to_screen(x_min, 0.0)
		var p2 = math_to_screen(x_max, 0.0)

		draw_line(
			p1,
			p2,
			axis_color,
			axis_width
		)

		# Ticks y números
		var x = ceil(x_min)

		while x <= floor(x_max):

			if x != 0:

				var p = math_to_screen(x, 0)

				# Tick
				draw_line(
					Vector2(p.x, p.y - tick_size),
					Vector2(p.x, p.y + tick_size),
					axis_color,
					axis_width
				)

				# Número
				draw_string(
					default_font,
					Vector2(p.x - 5, p.y + 20),
					str(x),
					HORIZONTAL_ALIGNMENT_LEFT,
					-1,
					font_size,
					label_color
				)

			x += 1

	# =========================
	# EJE Y
	# =========================

	if x_min <= 0.0 and x_max >= 0.0:

		var p1 = math_to_screen(0.0, y_min)
		var p2 = math_to_screen(0.0, y_max)

		draw_line(
			p1,
			p2,
			axis_color,
			axis_width
		)

		# Ticks y números
		var y = ceil(y_min)

		while y <= floor(y_max):

			if y != 0:

				var p = math_to_screen(0, y)

				# Tick
				draw_line(
					Vector2(p.x - tick_size, p.y),
					Vector2(p.x + tick_size, p.y),
					axis_color,
					axis_width
				)

				# Número
				draw_string(
					default_font,
					Vector2(p.x + 10, p.y + 5),
					str(y),
					HORIZONTAL_ALIGNMENT_LEFT,
					-1,
					font_size,
					label_color
				)

			y += 1
# =========================================================
# DIBUJAR FUNCIÓN
# =========================================================

#func _draw_function(func_ref: Callable, color: Color):
#
	#print("FUNC REF:", func_ref)
#
	#if func_ref == null:
		#return
#
	#if !func_ref.is_valid():
		#print("INVALID FUNC")
		#return
#
	#var rect = get_rect()
#
	#var previous_point : Vector2
	#var first_point := true
#
	#var samples := int(rect.size.x)
	#
	#for i in range(samples):
#
		#var t = float(i) / float(samples - 1)
#
		#var x = lerp(x_min, x_max, t)
#
		#var y = func_ref.call(x)
		#if y == null:
			#continue
#
		## Evitar NaN o infinitos
		#if is_nan(y) or is_inf(y):
			#first_point = true
			#continue
#
		#var screen_point = math_to_screen(x, y)
#
		#if first_point:
			#previous_point = screen_point
			#first_point = false
			#continue
#
		#draw_line(
			#previous_point,
			#screen_point,
			#color,
			#curve_width,
			#true
		#)
		#previous_point = screen_point
func _draw_function(func_ref: Callable, color: Color):

	var rect: Rect2= get_rect()



	var previous_point : Vector2
	var first_point := true
	var samples : int= max(300, int(rect.size.x))

	for i in range(samples):

		var t = float(i) / float(samples - 1)
		var x = lerp(x_min, x_max, t)

		var y = func_ref.call(x)

		if is_nan(y) or is_inf(y):
			first_point = true
			continue

		var screen_point = math_to_screen(x, y)

		if first_point:
			previous_point = screen_point
			first_point = false
			continue

		draw_line(previous_point, screen_point, color, curve_width, true)
		previous_point = screen_point
# =========================================================
# DIBUJAR NODOS
# =========================================================

func _draw_nodes():
	if show_nodes:
		for node in interpolation_nodes:

			var p = math_to_screen(node.x, node.y)

			draw_circle(
				p,
				7.0,
				node_color
			)

# =========================================================
# API PÚBLICA
# =========================================================

func set_functions(f_array: Array):
	print("FUNCTIONS:", f_array)
	functions = f_array
	queue_redraw()

func set_nodes(nodes: Array):

	interpolation_nodes = nodes
	queue_redraw()

func set_view(x0, x1, y0, y1):

	x_min = x0
	x_max = x1

	y_min = y0
	y_max = y1

	queue_redraw()
