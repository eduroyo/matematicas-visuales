extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


var a := 1.0
var b := 0.0
var c := 0.0
var d := 1.0

func transform(v: Vector2) -> Vector2:
	return Vector2(
		a * v.x + b * v.y,
		c * v.x + d * v.y
		)

func math_to_screen(v: Vector2) -> Vector2:
	return Vector2(v.x, -v.y)
	
func draw_grid(origin: Vector2, scale: float):
	var N = 10
	var color = Color(0.7, 0.7, 0.7, 0.4)

	for k in range(-N, N + 1):
		# Líneas verticales
		var p1 = transform(Vector2(k, -N))
		var p2 = transform(Vector2(k, N))

		draw_line(
			origin + math_to_screen(p1 * scale),
			origin + math_to_screen(p2 * scale),
			color,
			1
		)

		# Líneas horizontales
		p1 = transform(Vector2(-N, k))
		p2 = transform(Vector2(N, k))

		draw_line(
			origin + math_to_screen(p1 * scale),
			origin + math_to_screen(p2 * scale),
			color,
			1
		)


func _draw():
	var origin = Vector2(700, 400)

	# Escala base
	var L = 150

	draw_grid(origin, L)

	# Vectores originales
	var e1 = Vector2(L, 0)
	var e2 = Vector2(0, L)

	# Vectores transformados
	var Ae1 = transform(e1)
	var Ae2 = transform(e2)

	# Dibujar originales (gris, finos)
	draw_line(origin, origin + math_to_screen(e1), Color(0.6, 0.6, 0.6), 1)
	draw_line(origin, origin + math_to_screen(e2), Color(0.6, 0.6, 0.6), 1)

	# Dibujar transformados (colores vivos)
	draw_line(origin, origin + math_to_screen(Ae1), Color.RED, 3)
	draw_line(origin, origin + math_to_screen(Ae2), Color.GREEN, 3)
		# Paralelogramo (determinante)
	var poly = PackedVector2Array()
	poly.append(origin)
	poly.append(origin + math_to_screen(Ae1))
	poly.append(origin + math_to_screen(Ae1 + Ae2))
	poly.append(origin + math_to_screen(Ae2))

	draw_colored_polygon(
		poly,
		Color(0.2, 0.6, 1.0, 0.25)
	)
