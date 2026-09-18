from sklearn import model_selection, datasets, svm
iris = datasets.load_iris()
X=iris.data[0:100]
Y=iris.target[0:100]
X_train,X_test,Y_train,Y_test=model_selection.train_test_split(X,Y,test_size=0.33,random_state=42)
print(Y_train)
print(X_train[0])



import numpy as np
from qiskit import QuantumCircuit, transpile
from qiskit_aer import AerSimulator
from qiskit.visualization import plot_histogram

# Use Aer's qasm_simulator
simulator = AerSimulator()

# Create a Quantum Circuit acting on the q register
n=4

def feature_map(X):

  circuit = QuantumCircuit(n, 1)

  for i, x in enumerate(X):
    circuit.rx(x,i)
    
  return circuit

def variational_circuit(qc, theta):

  for i in range(n-1):
    qc.cx(i,i+1)
  qc.cx(n-1,0)
  for i in range(n):
    qc.ry(theta[i],i)
  return qc

def quantum_nn(X, theta, backend=simulator, shots=10000):
  qc = feature_map(X)
  qc = variational_circuit(qc, theta)
  qc.measure(0,0)
  job = backend.run(transpile(qc, backend), shots=shots)
  result = job.result()
  counts = result.get_counts(qc)
  #print("\nTotal count for 00 and 11 are:",counts)
  return counts.get('1',0)/shots

quantum_nn(X_train[5], np.random.rand(n))

# https://www.youtube.com/watch?v=5Kr31IFwJiI







# cirq version of the same example: see import_cirq.py
