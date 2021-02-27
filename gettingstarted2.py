import numpy as np
from qiskit import(
  QuantumCircuit,
  execute,
  Aer)
from qiskit.visualization import plot_histogram

# Use Aer's qasm_simulator
simulator = Aer.get_backend('qasm_simulator')


# Create a Quantum Circuit acting on the q register
# circuit = QuantumCircuit(2, 2)
# Add a H gate on qubit 0
# circuit.h(0)
# Add a CX (CNOT) gate on control qubit 0 and target qubit 1
# circuit.cx(0, 1)

from qiskit import QuantumRegister, ClassicalRegister, QuantumCircuit
# from numpy import pi

qreg_q = QuantumRegister(3, 'q')
creg_c = ClassicalRegister(3, 'c')
circuit = QuantumCircuit(qreg_q, creg_c)

circuit.h(qreg_q[0])
circuit.h(qreg_q[1])
circuit.h(qreg_q[2])
circuit.measure(qreg_q[0], creg_c[0])
circuit.measure(qreg_q[1], creg_c[1])
circuit.measure(qreg_q[2], creg_c[2])


# Map the quantum measurement to the classical bits
# circuit.measure([0,1], [0,1])

# Execute the circuit on the qasm simulator
job = execute(circuit, simulator, shots=1000)

# Grab results from the job
result = job.result()

# Returns counts
counts = result.get_counts(circuit)
print("\nTotal count for 00 and 11 are:",counts)

# Draw the circuit
circuit.draw()

# Plot a histogram
plot_histogram(counts)


