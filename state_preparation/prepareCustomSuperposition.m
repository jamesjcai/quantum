function qc = prepareCustomSuperposition(amplitudes)
    % Prepare arbitrary superposition state
    n_qubits = log2(length(amplitudes));
    
    if mod(n_qubits, 1) ~= 0
        error('Number of amplitudes must be a power of 2');
    end
    
    qc = quantumCircuit(n_qubits);
    
    % Normalize amplitudes
    amplitudes = amplitudes / norm(amplitudes);
    
    % Use custom amplitude encoding implementation
    qc = amplitudeEncodingCustom(qc, amplitudes, 1:n_qubits);
end

function qc = amplitudeEncodingCustom(qc, amplitudes, qubits)
    % Custom implementation of amplitude encoding
    if isempty(qubits)
        return;
    end
    
    if isscalar(qubits)
        % Single qubit case
        if length(amplitudes) == 2
            % Calculate rotation angle from amplitudes
            if abs(amplitudes(1)) < 1e-12
                angle = pi;
            elseif abs(amplitudes(2)) < 1e-12
                angle = 0;
            else
                angle = 2 * atan2(abs(amplitudes(2)), abs(amplitudes(1)));
            end
            
            qc = gate(qc, "ry", qubits(1), "RotationAngle", angle);
            
            % Handle phase
            if length(amplitudes) == 2 && imag(amplitudes(2)) ~= 0
                phase = angle(amplitudes(2)) - angle(amplitudes(1));
                if abs(phase) > 1e-12
                    qc = gate(qc, "rz", qubits(1), "RotationAngle", phase);
                end
            end
        end
        return;
    end
    
    % Multi-qubit case - recursive decomposition
    n = length(amplitudes);
    half = n/2;
    
    % Split amplitudes
    left_amps = amplitudes(1:half);
    right_amps = amplitudes(half+1:end);
    
    % Calculate norms
    left_norm = norm(left_amps);
    right_norm = norm(right_amps);
    
    % Calculate rotation angle for the first qubit
    if left_norm < 1e-12 && right_norm < 1e-12
        return;
    elseif left_norm < 1e-12
        angle = pi;
    elseif right_norm < 1e-12
        angle = 0;
    else
        angle = 2 * atan2(right_norm, left_norm);
    end
    
    % Apply rotation to first qubit
    qc = gate(qc, "ry", qubits(1), "RotationAngle", angle);
    
    % Recursively encode sub-amplitudes with controlled operations
    if left_norm > 1e-12
        normalized_left = left_amps / left_norm;
        qc = controlledAmplitudeEncoding(qc, normalized_left, qubits(1), qubits(2:end), 0);
    end
    
    if right_norm > 1e-12
        normalized_right = right_amps / right_norm;
        qc = controlledAmplitudeEncoding(qc, normalized_right, qubits(1), qubits(2:end), 1);
    end
end

function qc = controlledAmplitudeEncoding(qc, amplitudes, control_qubit, target_qubits, control_state)
    % Apply controlled amplitude encoding
    if isempty(target_qubits)
        return;
    end
    
    % Create temporary circuit for the operation we want to control
    temp_qc = quantumCircuit(length(target_qubits));
    temp_qc = amplitudeEncodingCustom(temp_qc, amplitudes, 1:length(target_qubits));
    
    % Convert to controlled operations (simplified approach)
    % For each gate in temp_qc, make it controlled
    % This is a simplified version - in practice, you'd need to decompose
    % the temp circuit and make each elementary gate controlled
    
    if control_state == 0
        % Apply X gate to flip control, apply controlled ops, then flip back
        qc = gate(qc, "x", control_qubit);
    end
    
    % Apply controlled rotations based on the amplitudes
    % This is a simplified implementation
    qc = applyControlledRotations(qc, amplitudes, control_qubit, target_qubits);
    
    if control_state == 0
        qc = gate(qc, "x", control_qubit);
    end
end

function qc = applyControlledRotations(qc, amplitudes, control_qubit, target_qubits)
    % Simplified controlled rotation application
    if isscalar(target_qubits) && length(amplitudes) == 2
        if abs(amplitudes(2)) > 1e-12
            angle = 2 * atan2(abs(amplitudes(2)), abs(amplitudes(1)));
            qc = gate(qc, "cry", [control_qubit, target_qubits(1)], "RotationAngle", angle);
        end
    else
        % For multi-qubit case, apply simplified decomposition
        qc = amplitudeEncodingCustom(qc, amplitudes, target_qubits);
    end
end