
from qiskit import QuantumCircuit
from qiskit.quantum_info import Statevector
from qiskit.quantum_info import state_fidelity
from qiskit.visualization import plot_bloch_multivector
from qiskit.visualization import plot_state_qsphere
from qiskit.visualization import plot_state_city
from qiskit.visualization import plot_state_paulivec
from qiskit.visualization import plot_state_hinton
from qiskit import ClassicalRegister, QuantumRegister, execute
from qiskit import BasicAer

svZero  = Statevector.from_label('0') 
svOne   = Statevector.from_label('1')  
svPlus  = Statevector.from_label('+')  
svMinus = Statevector.from_label('-')  
svRight = Statevector.from_label('r')
svLeft  = Statevector.from_label('l')

# https://medium.com/qubitco/coding-single-qubit-circuits-in-qiskit-4f19e4d858b2

plot_bloch_multivector(svZero,title='Zero').show()


mcX = QuantumCircuit(1) # creating a quantum circuit with only one qubit
mcX.x(0)                # adding an X gate on our circuit
mcX.draw('mpl').show()         # drawing the circuit

new_svZero = svZero.evolve(mcX)
new_svZero

plot_bloch_multivector(new_svZero,title='X|0>').show()
plot_state_qsphere(new_svZero).show()

mcCrazyCircuit = QuantumCircuit(1) # creating a quantum circuit with only one qubit
mcCrazyCircuit.id(0)               # adding an I gate on our circuit
mcCrazyCircuit.x(0)                # adding an X gate on our circuit
mcCrazyCircuit.y(0)                # adding a  Y gate on our circuit
mcCrazyCircuit.z(0)                # adding a  Z gate on our circuit
mcCrazyCircuit.h(0)                # adding an H gate on our circuit
mcCrazyCircuit.s(0)                # adding an S gate on our circuit
mcCrazyCircuit.t(0)                # adding a  T gate on our circuit
mcCrazyCircuit.sdg(0)              # adding an S-dagger gate on our circuit
mcCrazyCircuit.tdg(0)              # adding an T-dagger gate on our circuit
mcCrazyCircuit.draw('mpl').show()         # drawing the circuit

q = QuantumRegister(1) # creates a Quantum register of 1 qubit
c = ClassicalRegister(1) # creates a classical register of 1 bit
qc = QuantumCircuit(q, c) # creates a quantum circuit 
qc.measure(q, c)
qc.draw()

backend = BasicAer.get_backend('qasm_simulator')
job = execute(qc, backend, shots=1024)
job.result().get_counts(qc)






# https://medium.com/qubitco/coding-multi-qubit-circuits-in-qiskit-b445c7c53c93
# ----------------------
sv = Statevector.from_label('00')
plot_state_qsphere(sv.data).show()

sv = Statevector.from_label('11')
plot_state_qsphere(sv.data).show()


qc = QuantumCircuit(3)
for qubit in range(3):
  qc.h(qubit)


backend = Aer.get_backend('statevector_simulator')

qc.draw('mpl').show()
final_state = execute(qc,backend).result().get_statevector()

print(final_state)

plot_state_qsphere(final_state).show()