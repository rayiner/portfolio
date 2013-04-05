def sum(x, s, n):
	if x == n:
		return s
	else:
		return sum(x + 1, s + 1, n)

print sum(0, 0, 10000000)

