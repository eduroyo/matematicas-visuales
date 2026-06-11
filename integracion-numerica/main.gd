#extends Node2D
#var metodo = 0
#
## Called when the node enters the scene tree for the first time.
#func _ready() :
	#var opt = $Control/Metodo
#
	#opt.add_item("Punto medio", 0)
	#opt.add_item("Trapecio", 1)
	#opt.add_item("Simpson", 2)
#
	#opt.connect("item_selected", Callable(self, "_on_metodo_changed"))
#
	##actualizar()
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#func _on_metodo_changed(index):
	#metodo = index
	##actualizar()

extends Node2D

enum Metodo {MEDIO, TRAPECIO, SIMPSON}
#enum Funcion {SENO, }

var metodo = Metodo.MEDIO
var n = 1


#var a = 0.0
#var b = 2*3.14   # ~pi
var a = 0.0
var b = 3*3.14/2 # 3pi/2

# función a integrar
func f(x):
	#return sin(x)
	return 1 + sin(x)+0.5*sin(2*x)

# integral exacta
func integral_exacta():
	#return -cos(b) + cos(a)
	return (b-a)-cos(b) + cos(a)-cos(2*b)/4+cos(2*a)/4

# ----------------------------------
# MÉTODOS NUMÉRICOS
# ----------------------------------

func punto_medio(n):
	var h = (b - a) / n
	var suma = 0.0
	
	for i in range(n):
		var x_mid = a + (i + 0.5) * h
		suma += f(x_mid)
	
	return h * suma

func trapecio(n):
	var h = (b - a) / n
	var suma = 0.5 * (f(a) + f(b))
	
	for i in range(1, n):
		suma += f(a + i * h)
	
	return h * suma

func simpson(n):
	if n % 2 != 0:
		n += 1
	
	var h = (b - a) / n
	var suma = f(a) + f(b)
	
	for i in range(1, n):
		var coef = 4 if i % 2 != 0 else 2
		suma += coef * f(a + i * h)
	
	return h * suma / 3.0

func aproximacion(n):
	match metodo:
		Metodo.MEDIO:
			return punto_medio(n)
		Metodo.TRAPECIO:
			return trapecio(n)
		Metodo.SIMPSON:
			return simpson(n)

	return 0

# ----------------------------------
# UI
# ----------------------------------

func _ready():
	var opt = $Control/Metodo
	opt.add_item("Punto medio", Metodo.MEDIO)
	opt.add_item("Trapecio", Metodo.TRAPECIO)
	opt.add_item("Simpson", Metodo.SIMPSON)

	opt.connect("item_selected", Callable(self, "_on_metodo_changed"))
	$Control/SliderN.connect("value_changed", Callable(self, "_on_slider_changed"))
	$Control/Labelf.text = "f(x)" 
	$Control/Labelx_start.text = "a = "+str(a) 
	$Control/Labelx_end.text = "b = 3π/2" 
	$Control/Labelf.add_theme_color_override("font_color", Color(0.334, 0.091, 0.398, 1.0))

	actualizar()

func _on_metodo_changed(index):
	metodo = index
	actualizar()

func _on_slider_changed(value):
	n = int(value)
	actualizar()

func actualizar():
	var aprox = aproximacion(n)
	var exacta = integral_exacta()
	var error = abs(exacta - aprox)

	$Control/LabelN.text = "N = " + str(n)
	$Control/LabelError.text = "|Error| = " + str(error)

	$GraficaFuncion.queue_redraw()
	$GraficaError.queue_redraw()
