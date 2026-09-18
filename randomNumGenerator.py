#matplotlib inline
# Importing standard Qiskit libraries and configuring account
from qiskit import QuantumCircuit, transpile, ClassicalRegister, QuantumRegister
from qiskit_aer import AerSimulator
from qiskit.visualization import *
from qiskit.quantum_info import Pauli, state_fidelity, process_fidelity

# Hardware path (needs a configured IBM Quantum account; 'ibmq_ourense' is retired):
#   from qiskit_ibm_runtime import QiskitRuntimeService, SamplerV2
#   service = QiskitRuntimeService()
#   backend = service.least_busy(operational=True, simulator=False)
#   job = SamplerV2(mode=backend).run([transpile(qc, backend)], shots=shots)


qc = QuantumCircuit(5, 5)
qc.h(0)
qc.h(1)
qc.h(2)
qc.h(3)
qc.h(4)
qc.measure([0, 1, 2, 3, 4], [0, 1, 2, 3, 4]) 
    
# decide how many times to send the circuit
shots = 1024

simulator = AerSimulator()
job = simulator.run(transpile(qc, simulator), shots=shots, memory=True)

#we want to see results independently, instead of as a probability
result = job.result()
memory = result.get_memory()

# need an array to drop all the results into
outputArray = []

#convert results to int and drop into array
for x in range(0, shots):
    converted = int(memory[x], 2)
    outputArray.append(converted)

# copy returned values from outputArray into corpus.js    
print(outputArray)