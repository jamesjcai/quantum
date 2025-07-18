function qc = prepareArbitraryState(target_amplitudes)
    % Prepare arbitrary quantum state using rotation decomposition
    n_qubits = log2(length(target_amplitudes));
    qc = quantumCircuit(n_qubits);
    
    % Normalize the target state
    target_amplitudes = target_amplitudes / norm(target_amplitudes);
    
    % Use recursive amplitude encoding
    qc = recursiveStatePreparation(qc, target_amplitudes, 1:n_qubits);
end

function qc = recursiveStatePreparation(qc, amplitudes, qubits)
    if length(qubits) == 1
        % Base case: single qubit
        if abs(amplitudes(2)) > 1e-10
            angle = 2 * atan2(abs(amplitudes(2)), abs(amplitudes(1)));
            qc = gate(qc, "ry", qubits(1), "RotationAngle", angle);
        end
        return;
    end
    
    % Split amplitudes into two halves
    n = length(amplitudes);
    half = n/2;
    
    left_norm = norm(amplitudes(1:half));
    right_norm = norm(amplitudes(half+1:end));
    
    if right_norm > 1e-10
        % Calculate rotation angle for current qubit
        angle = 2 * atan2(right_norm, left_norm);
        qc = gate(qc, "ry", qubits(1), "RotationAngle", angle);
        
        % Prepare controlled rotations for remaining qubits
        if left_norm > 1e-10
            left_amps = amplitudes(1:half) / left_norm;
            qc = controlledStatePreparation(qc, left_amps, qubits(1), qubits(2:end), 0);
        end
        
        if right_norm > 1e-10
            right_amps = amplitudes(half+1:end) / right_norm;
            qc = controlledStatePreparation(qc, right_amps, qubits(1), qubits(2:end), 1);
        end
    end
end