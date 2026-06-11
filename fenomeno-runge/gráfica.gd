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

var n: int = 10
var tipo_nodos := 0

var xs = []
var ys = []

func set_data(_n, _tipo):
	n = _n
	tipo_nodos = _tipo
	recompute()
	queue_redraw()

# ------------------------
# Matemáticas
# ------------------------

func runge(x: float) -> float:
	return 1.0 / (1.0 + 25.0 * x * x)

func nodos_equidistantes(n: int) -> Array:
	var arr = []
	for i in range(n):
		var x = -1.0 + 2.0 * i / (n - 1)
		arr.append(x)
	return arr

func nodos_chebyshev(n: int) -> Array:
	var arr = []
	for k in range(n):
		var x = cos((2.0 * k + 1.0) * PI / (2.0 * n))
		arr.append(x)
	return arr

func lagrange(x: float, xs: Array, ys: Array) -> float:
	var total = 0.0
	var n = xs.size()
	
	for i in range(n):
		var term = ys[i]
		for j in range(n):
			if i != j:
				term *= (x - xs[j]) / (xs[i] - xs[j])
		total += term
	
	return total

# ------------------------
# Recalcular
# ------------------------

func recompute():
	if tipo_nodos == 0:
		xs = nodos_equidistantes(n)
	else:
		xs = nodos_chebyshev(n)
	
	ys.clear()
	for x in xs:
		ys.append(runge(x))

# ------------------------
# Dibujo
# ------------------------

func _draw():
	var size = get_viewport_rect().size
	draw_axes(size)
	draw_function(size)
	draw_interpolation(size)
	draw_nodes(size)
	

func to_screen(x: float, y: float, size) -> Vector2:
	var sx = (x + 1.0) * 0.5 * size.x
	var sy = size.y * (0.5 - y * 0.4)
	return Vector2(sx, sy)

func draw_axes(size):
	draw_line(Vector2(0, size.y/2), Vector2(size.x, size.y/2), Color.BLACK)
	draw_line(Vector2(size.x/2, 0), Vector2(size.x/2, size.y), Color.BLACK)

func draw_function(size):
	var prev = null
	for i in range(400):
		var x = -1.0 + 2.0 * i / 399.0
		var y = runge(x)
		var p = to_screen(x, y, size)
		
		if prev != null:
			draw_line(prev, p, Color(0.083, 0.43, 0.621, 1.0), 4)
		prev = p

func draw_interpolation(size):
	var prev = null
	for i in range(400):
		var x = -1.0 + 2.0 * i / 399.0
		var y = lagrange(x, xs, ys)
		var p = to_screen(x, y, size)
		
		if prev != null:
			draw_line(prev, p, Color(0.62, 0.351, 0.094, 1.0), 4)
		prev = p

func draw_nodes(size):
	for i in range(xs.size()):
		draw_circle(to_screen(xs[i], ys[i],size), 4, Color(0.109, 0.021, 0.006, 1.0),true, 4)
