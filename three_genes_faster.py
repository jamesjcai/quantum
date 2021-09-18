from scipy.optimize import minimize

from qiskit import QuantumRegister, ClassicalRegister, QuantumCircuit, Aer, execute
from numpy import pi
from numpy.random import rand
import numpy as np
from numpy.linalg import norm 


N=3

r_min, r_max = 0, 2*pi
theta = r_min + rand(N) * (r_max - r_min)



def variational_circuit(qc, qr, theta):
    qc.cry(theta[0], qr[0], qr[1])
    qc.cry(theta[1], qr[1], qr[2])
    qc.cry(theta[2], qr[2], qr[0])
    return qc



#def objective(x):
#	return x[0]**2.0 + x[1]**2.0
#result = minimize(objective, theta, method='L-BFGS-B')


qreg_q = QuantumRegister(N, 'q')
creg_c = ClassicalRegister(N, 'c')
circuit = QuantumCircuit(qreg_q, creg_c)

for i in range(N):
    circuit.h(qreg_q[i])

#circuit.barrier()   
circuit=variational_circuit(circuit,qreg_q,theta)
#circuit.barrier()
circuit.measure(qreg_q[0], creg_c[0])
circuit.measure(qreg_q[1], creg_c[1])
circuit.measure(qreg_q[2], creg_c[2])

#circuit.draw()
#circuit.draw(output='mpl', reverse_bits=False).show()

shots=10000
backend = Aer.get_backend('qasm_simulator')
job=execute(circuit, backend, shots=shots, memory=False)
result=job.result()
counts=result.get_counts(circuit)

a=[]
b=[]
for id, key in enumerate(counts):
    # print(id)
    a.append(key)
    b.append(counts[key])

c=np.array(b)[np.argsort(a).astype(int)]
p=c / sum(c)

print(p)
print(theta)

p0=[0.1247, 0.1517, 0.2061, 0.1718, 0.2491, 0.0296, 0.0056, 0.0614]

norm(p-p0)
