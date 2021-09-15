# https://machinelearningmastery.com/function-optimization-with-scipy/

from scipy.optimize import minimize
from numpy.random import rand
import numpy as np

# objective function
def objective(x):
	return x[0]**2.0 + x[1]**2.0


n=2

r_min, r_max = 0, 2*np.pi
pt = r_min + rand(n) * (r_max - r_min)


result = minimize(objective, pt, method='L-BFGS-B')

#print('Status : %s' % result['message'])
#print('Total Evaluations: %d' % result['nfev'])
solution = result['x']
evaluation = objective(solution)
print('Solution: f(%s) = %.5f' % (solution, evaluation))



