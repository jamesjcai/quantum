Ω = 3
4 + Ω

from qiskit import QuantumCircuit
from qiskit.quantum_info import Statevector
from math import pi, sqrt
from qiskit.visualization import plot_bloch_multivector, plot_histogram

qc = QuantumCircuit(1)

qc.h(0)
qc.x(0)
# qc.h(0)
qc.draw()

state = Statevector(qc)
plot_bloch_multivector(state).show()



