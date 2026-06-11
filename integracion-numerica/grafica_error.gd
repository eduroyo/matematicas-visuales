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

func _draw():
	var main = get_parent()

	var max_n = 100
	var w = 800
	var h = 200

	var puntos = []

	for n in range(2, max_n):
		var aprox = main.aproximacion(n)
		var exacta = main.integral_exacta()
		var error = abs(exacta - aprox)

		puntos.append(Vector2(n, error))

	# normalizar
	var max_error = 0.0
	for p in puntos:
		if p.y > max_error:
			max_error = p.y

	# dibujar curva
	var prev = null
	for p in puntos:
		var px = p.x / max_n * w
		var py = h - (p.y / max_error) * h

		if prev != null:
			draw_line(prev, Vector2(px, py), Color.RED, 2)

		prev = Vector2(px, py)
