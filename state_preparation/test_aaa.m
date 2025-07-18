% Ensure the Quantum Computing support package is installed:
% Install via Add-On Explorer: "Quantum Computing"

% Step 1: Create initialization gate to prepare a target state
% Example: prepare a 3-qubit state |ψ> = α|000> + β|011> + γ|101>, with specified amplitudes:
amp = [1; 0; 0; 1; 0; 1; 0; 0];  % unnormalized amplitudes vector
cg = initGate(1:3, amp);         % creates CompositeGate to initialize qubits 1–3 :contentReference[oaicite:1]{index=1}

% Step 2: Build quantum circuit and simulate
qc = quantumCircuit(cg);         % initialize circuit with the gate
s = simulate(qc);                % simulate starting from |000>

% Step 3: Inspect the prepared state
disp(formula(s));                % display state formula :contentReference[oaicite:2]{index=2}
histogram(s);                    % visualize probabilities over basis states
p = probability(s, [1 2 3]);     % compute total probability (should be 1) :contentReference[oaicite:3]{index=3}

% Step 4: Optional—initialize from basis string
% e.g., prepare |+−0> state:
cg2 = initGate(1:3, "+-0");      % basis string initialization :contentReference[oaicite:4]{index=4}
s2 = simulate(quantumCircuit(cg2));
disp(formula(s2, Basis="X"));    % show in X-basis if desired
