% Example 1: Prepare |101⟩ state
qc1 = prepareComputationalBasisState(3, 5); % 5 = 101 in binary
state1 = simulate(qc1);

% Example 2: Prepare Bell state
qc2 = prepareBellState('phi+');
state2 = simulate(qc2);

% Example 3: Prepare GHZ state
qc3 = prepareGHZState(3);
state3 = simulate(qc3);

% Example 4: Prepare custom superposition
amplitudes = [0.5, 0.5, 0.5, 0.5]; % Equal superposition of 2 qubits
qc4 = prepareCustomSuperposition(amplitudes);
state4 = simulate(qc4);

% Visualize the circuits
figure;
plot(qc1);
title('Computational Basis State |101⟩');

figure;
plot(qc2);
title('Bell State Φ⁺');