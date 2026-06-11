extends RefCounted
class_name NaturalSpline

var x := []
var y := []

var a := []
var b := []
var c := []
var d := []

# =========================================================
# INIT
# =========================================================

func _init(points: Array):
	_build(points)

# =========================================================
# BUILD
# =========================================================

func _build(points: Array):

	var n = points.size()
	if n < 2:
		return

	x.clear()
	y.clear()

	for p in points:
		x.append(p.x)
		y.append(p.y)

	a = y.duplicate()
	b.resize(n)
	c.resize(n)
	d.resize(n)

	var h = []
	for i in range(n - 1):
		h.append(x[i + 1] - x[i])

	# sistema tridiagonal para c
	var alpha = []
	alpha.resize(n)

	alpha[0] = 0
	alpha[n - 1] = 0

	for i in range(1, n - 1):
		alpha[i] = (3.0 / h[i]) * (a[i + 1] - a[i]) - (3.0 / h[i - 1]) * (a[i] - a[i - 1])

	var l = []
	var mu = []
	var z = []

	l.resize(n)
	mu.resize(n)
	z.resize(n)

	l[0] = 1
	mu[0] = 0
	z[0] = 0

	for i in range(1, n - 1):
		l[i] = 2.0 * (x[i + 1] - x[i - 1]) - h[i - 1] * mu[i - 1]
		mu[i] = h[i] / l[i]
		z[i] = (alpha[i] - h[i - 1] * z[i - 1]) / l[i]

	l[n - 1] = 1
	z[n - 1] = 0
	c[n - 1] = 0

	for j in range(n - 2, -1, -1):
		c[j] = z[j] - mu[j] * c[j + 1]
		b[j] = (a[j + 1] - a[j]) / h[j] - h[j] * (c[j + 1] + 2.0 * c[j]) / 3.0
		d[j] = (c[j + 1] - c[j]) / (3.0 * h[j])

# =========================================================
# EVALUATION
# =========================================================

func evaluate(xq: float) -> float:

	var n = x.size()
	if n == 0:
		return 0.0

	# buscar intervalo
	var i = n - 2

	for j in range(n - 1):
		if xq < x[j + 1]:
			i = j
			break

	var dx = xq - x[i]

	return a[i] + b[i] * dx + c[i] * dx * dx + d[i] * dx * dx * dx
