function qc = prepareGHZState(n_qubits)
    % Prepare GHZ state: (|00...0⟩ + |11...1⟩)/√2
    qc = quantumCircuit(n_qubits);
    
    % Apply Hadamard to first qubit
    qc = gate(qc, "h", 1);
    
    % Apply CNOT gates to create entanglement
    for i = 2:n_qubits
        qc = gate(qc, "cx", [1, i]);
    end
end