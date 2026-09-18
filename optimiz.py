# https://www.ibm.com/blogs/research/2020/07/quantum-optim-module/
#
# qiskit.optimization was split out of Qiskit before 1.0 and now lives in the
# separate qiskit-optimization package:
#     pip install qiskit-optimization docplex
# GroverOptimizer no longer takes a quantum_instance; it takes a Sampler.

from qiskit.primitives import StatevectorSampler

from qiskit_optimization.algorithms import GroverOptimizer
from qiskit_optimization.translators import from_docplex_mp

from docplex.mp.model import Model

# construct problem with DOcplex
model = Model('docplex_model')
x, y = model.binary_var_list(2)
model.maximize(x*y + x + y)

# convert DOcplex model to Qiskit Quadratic Program
qp = from_docplex_mp(model)

# use the Grover Adaptive Search (GAS) to solve the optimization problem
grover = GroverOptimizer(num_value_qubits=3, sampler=StatevectorSampler())
result = grover.solve(qp)

# printing results: x=[1.0,1.0], fval=3
print(result)
