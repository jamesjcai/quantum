
from qiskit import QuantumCircuit, Aer, IBMQ, QuantumRegister, ClassicalRegister, execute
from sklearn import model_selection, datasets, svm
import numpy as np
import qiskit

iris = datasets.load_iris()
X=iris.data[0:100]
Y=iris.target[0:100]
X_train,X_test,Y_train,Y_test=model_selection.train_test_split(X,Y,test_size=0.33,random_state=42)


N=4
def feature_map(X):
    q=QuantumRegister(N)
    c=ClassicalRegister(1)
    qc=QuantumCircuit(q,c)
    for i, x in enumerate(X):
        qc.rx(x,i)
    return qc, c

def variational_circuit(qc, theta):
    for i in range(N-1):
        qc.cnot(i, i+1)
    qc.cnot(N-1,0)
    for i in range(N):
        qc.ry(theta[i],i)
    return qc



def quantum_nn(X, theta, simulator=True):
    qc,c=feature_map(X)

    qc=variational_circuit(qc,np.random.rand(N))
    qc.measure(0,c)
    shots=1E4
    backend = Aer.get_backend('qasm_simulator')

    job=qiskit.execute(qc, backend, shots=shots)
    result=job.result()
    counts=result.get_counts(qc)
    return counts['1']/shots

quantum_nn(X_train[5], np.random.rand(N))





