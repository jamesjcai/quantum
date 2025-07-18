function qc = prepareBellState(bell_type)
    % Prepare Bell states: 'phi+', 'phi-', 'psi+', 'psi-'
    qc = quantumCircuit(2);
    
    switch bell_type
        case 'phi+'  % (|00⟩ + |11⟩)/√2
            qc = gate(qc, "h", 1);
            qc = gate(qc, "cx", [1,2]);
            
        case 'phi-'  % (|00⟩ - |11⟩)/√2
            qc = gate(qc, "h", 1);
            qc = gate(qc, "z", 1);
            qc = gate(qc, "cx", [1,2]);
            
        case 'psi+'  % (|01⟩ + |10⟩)/√2
            qc = gate(qc, "h", 1);
            qc = gate(qc, "x", 2);
            qc = gate(qc, "cx", [1,2]);
            
        case 'psi-'  % (|01⟩ - |10⟩)/√2
            qc = gate(qc, "h", 1);
            qc = gate(qc, "z", 1);
            qc = gate(qc, "x", 2);
            qc = gate(qc, "cx", [1,2]);
    end
end