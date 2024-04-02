import math

MAX = math.inf
pi = 0

for n in range(0, MAX):
    pi += pow(-1, n) / ((2 * n) + 1)

pi = 4 * pi

print(pi)