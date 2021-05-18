# define data (input array X, target labels y)
from qiskit_machine_learning.datasets import ad_hoc_data
X_train, y_train, X_test, y_test = ad_hoc_data(20, 10, 2, 0.1)
# import the variational quantum classifier
from qiskit_machine_learning.algorithms import VQC


from qiskit.circuit.library import ZZFeatureMap, RealAmplitudes
# import the optimizer for the training
from qiskit.algorithms.optimizers import L_BFGS_B
# import backend
from qiskit.providers.aer import QasmSimulator
# construct classifier
num_qubits = 2
vqc = VQC(feature_map=ZZFeatureMap(num_qubits),
ansatz=RealAmplitudes(num_qubits, reps=1),
loss='cross_entropy',
optimizer=L_BFGS_B(),
quantum_instance=QasmSimulator())
# train classifier
vqc.fit(X_train, y_train)
# score result
vqc.score(X_test, y_test)