function success = verifyStatePreparation(qc, target_state, tolerance)
    % Verify if the prepared state matches the target
    if nargin < 3
        tolerance = 1e-10;
    end
    
    prepared_state = simulate(qc);
    
    % Check fidelity
    fidelity = abs(target_state' * prepared_state)^2;
    success = fidelity > (1 - tolerance);
    
    fprintf('State preparation fidelity: %.6f\n', fidelity);
end