from sklearn import model_selection, datasets, svm
iris = datasets.load_iris()
X=iris.data[0:100]
Y=iris.target[0:100]
X_train,X_test,Y_train,Y_test=model_selection.train_test_split(X,Y,test_size=0.33,random_state=42)
print(Y_train)
print(X_train[0])



import numpy as np
from qiskit import(
  QuantumCircuit,
  execute,
  Aer)
from qiskit.visualization import plot_histogram

# Use Aer's qasm_simulator
simulator = Aer.get_backend('qasm_simulator')

# Create a Quantum Circuit acting on the q register
n=4

def feature_map(X):

  circuit = QuantumCircuit(n, n)

  for i, x in enumerate(X):
    circuit.rx(x,i)
    
  return circuit

def variational_circuit(qc, theta):

  for i in range(n-1):
    qc.cnot(i,i+1)
  qc.cnot(n-1,0)
  for i in range(n):
    qc.ry(theta[i],i)
  return qc

def quantum_nn(X, theta, simulator=True)
  qc, c = feature_map(X)
  qc = variational_circuit(qc, np.random.rand(n))
  qc.measure(0,c)
  job = execute(qc, simulator, shots=1E4)
  result = job.result()
  counts = result.get_counts(qc)
  #print("\nTotal count for 00 and 11 are:",counts)
  return counts['1']/1E4

quantum_nn(X_train[5], np.random.rand(n))

# https://www.youtube.com/watch?v=5Kr31IFwJiI



