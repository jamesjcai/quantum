function qc = prepareWState(n_qubits)
    % Prepare W state: (|100...0⟩ + |010...0⟩ + ... + |000...1⟩)/√n
    qc = quantumCircuit(n_qubits);
    
    % Recursive construction of W state
    angles = zeros(1, n_qubits-1);
    for k = 1:n_qubits-1
        angles(k) = 2 * asin(sqrt(1/(n_qubits-k+1)));
    end
    
    % Apply rotation gates
    for k = 1:n_qubits-1
        qc = gate(qc, "ry", k, "RotationAngle", angles(k));
        if k < n_qubits-1
            for j = k+1:n_qubits
                qc = gate(qc, "cx", [k, j]);
            end
        end
    end
end