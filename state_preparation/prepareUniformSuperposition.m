function qc = prepareUniformSuperposition(n_qubits)
    % Prepare equal superposition of all basis states
    qc = quantumCircuit(n_qubits);
    
    for i = 1:n_qubits
        qc = gate(qc, "h", i);
    end
end

