function qc = prepareComputationalBasisState(n_qubits, state_index)
    % Prepare |state_index⟩ in computational basis
    qc = quantumCircuit(n_qubits);
    
    % Convert state_index to binary and apply X gates where needed
    binary_rep = dec2bin(state_index, n_qubits) - '0';
    for i = 1:n_qubits
        if binary_rep(i) == 1
            qc = quantum.gate.SimpleGate() (qc, "x", i);
            xGate(i)
        end
    end
end