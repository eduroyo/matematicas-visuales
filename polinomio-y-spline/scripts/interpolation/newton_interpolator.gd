extends RefCounted

class_name NewtonInterpolator

var x_nodes := []
var coefficients := []

# =========================================================
# CONSTRUCTOR
# =========================================================

func _init(points: Array):

	_build(points)

# =========================================================
# DIFERENCIAS DIVIDIDAS
# =========================================================

func _build(points: Array):

	x_nodes.clear()
	coefficients.clear()

	var n = points.size()

	# Guardar nodos x
	for p in points:
		x_nodes.append(p.x)

	# Tabla temporal
	var table := []

	for p in points:
		table.append(p.y)

	# Primer coeficiente
	coefficients.append(table[0])

	# Construcción diferencias divididas
	for level in range(1, n):

		var new_table := []

		for i in range(n - level):

			var numerator = table[i + 1] - table[i]
			var denominator = x_nodes[i + level] - x_nodes[i]

			new_table.append(numerator / denominator)

		table = new_table

		coefficients.append(table[0])

# =========================================================
# EVALUACIÓN
# =========================================================

func evaluate(x: float) -> float:

	var n = coefficients.size()

	var result = coefficients[0]

	var product = 1.0

	for i in range(1, n):

		product *= (x - x_nodes[i - 1])

		result += coefficients[i] * product

	return result
