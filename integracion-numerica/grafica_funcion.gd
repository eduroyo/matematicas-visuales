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

func f(x):
	#return sin(x)
	return 1 + sin(x)+0.5*sin(2*x)

func _draw():
	var main = get_parent()

	var a = main.a
	var b = main.b
	var n = main.n

	var w = 800
	var h = 300

	var scale_x = w / (b - a)
	var scale_y = 100

	# Dibujar ejes
	draw_line(Vector2(0, h/2), Vector2(w, h/2), Color.BLACK)

	# Dibujar función
	var prev = null
	for i in range(201):
		var x = lerp(a, b, i/200.0)
		var y = f(x)

		var px = (x - a) * scale_x
		var py = h/2 - y * scale_y

		if prev != null:
			draw_line(prev, Vector2(px, py), Color(0.334, 0.091, 0.398, 1.0), 2)

		prev = Vector2(px, py)

	# Dibujar rectángulos (punto medio como ejemplo)
	var metodo = main.metodo
	var h_n = (b - a) / n
	match metodo:
		# 🔵 PUNTO MEDIO
		0:
			for i in range(n):
				var x_mid = a + (i + 0.5) * h_n
				var altura = f(x_mid)
##
				var x0 = (a + i*h_n - a) * scale_x
				var ancho = h_n * scale_x
				var y0 = h/2
				var alto = -altura * scale_y
				
				draw_rect(Rect2(x0, y0, ancho, alto), Color(0,0,1,0.3))
		## 🟢 TRAPECIO
		1:
			for i in range(n):
				var x0 = a + i*h_n
				var x1 = x0 + h_n
#
				var y0 = f(x0)
				var y1 = f(x1)
#
				var p0 = Vector2((x0-a)*scale_x, h/2)
				var p1 = Vector2((x0-a)*scale_x, h/2 - y0*scale_y)
				var p2 = Vector2((x1-a)*scale_x, h/2 - y1*scale_y)
				var p3 = Vector2((x1-a)*scale_x, h/2)
#
				draw_polygon([p0, p1, p2, p3], [Color(0,1,0,0.3)])
		#🔴 SIMPSON
		2:
			# asegurar n par
			#if n % 2 != 0:
				#n -= 1

			for i in range(0, n):

				var x0 = a + i*h_n
				var x1 = x0 + h_n/2
				var x2 = x0 + h_n

				var y0 = f(x0)
				var y1 = f(x1)
				var y2 = f(x2)

				var puntos = []

				for t in range(31):
					var tt = t / 30.0
					var x = lerp(x0, x2, tt)

					# LAGRANGE
					var L0 = (x - x1)*(x - x2) / ((x0 - x1)*(x0 - x2))
					var L1 = (x - x0)*(x - x2) / ((x1 - x0)*(x1 - x2))
					var L2 = (x - x0)*(x - x1) / ((x2 - x0)*(x2 - x1))

					var y = y0*L0 + y1*L1 + y2*L2

					var px = (x - a) * scale_x
					var py = h/2 - y * scale_y
					var prev_p = null
					if prev_p != null:
						draw_line(prev_p, Vector2(px, py), Color(1,0,0), 2)
					prev_p = Vector2(px, py)
					puntos.append(Vector2(px, py))

				# cerrar área
				var px2 = (x2 - a) * scale_x
				var px0 = (x0 - a) * scale_x

				puntos.append(Vector2(px2, h/2))
				puntos.append(Vector2(px0, h/2))

				draw_polygon(puntos, [Color(1,0,0,0.3)])
				

	
			#for i in range(n):
				#var x0 = a + i*h_n
				#var x2 = x0 + h_n
				#var prev_s = null
#
				#for t in range(20):
					#var tt = t / 20.0
					#var x = lerp(x0, x2, tt)
					#var y = f(x)
#
					#var px = (x - a) * scale_x
					#var py = h/2 - y * scale_y
#
					#var punto = Vector2(px, py)
#
					#if prev_s != null:
						#draw_line(prev_s, punto, Color(1,0,0), 2)
#
					#prev_s = punto
		## recorrer de 2 en 2
			#for i in range(0, n, 2):
#
				#var x0 = a + i*h_n
				#var x1 = x0 + h_n
				#var x2 = x0 + 2*h_n
#
				## dibujar curva aproximada (parábola)
				#var prev_s = null
#
				#for t in range(20):
					#var tt = t / 20.0
					#var x = lerp(x0, x2, tt)
					## interpolación cuadrática simple
					#var y = f(x)
#
					#var px = (x - a) * scale_x
					#var py = h/2 - y * scale_y
#
					#if prev_s != null:
						#draw_line(prev_s, Vector2(px, py), Color(1,0,0), 2)
#
					#prev_s = Vector2(px, py)
