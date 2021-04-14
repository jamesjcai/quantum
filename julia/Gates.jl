module Gates

export xGate,
       yGate

function xGate()
    [0.0 1.0; 1.0 0.0]
end

function yGate()
    [0.0 -1im; 1im 0.0]
end

function zGate()
    [1.0 0.0; 0.0 -1.0]
end

function hGate()
    [1/√2 1/√2; 1/√2 -1/√2]
end

function iGate()
    Matrix(1.0I, 2, 2)
end

function cPhaseShifGate()
    [1.0 0.0 0.0 0.0;
     0.0 1.0 0.0 0.0;
     0.0 0.0 1.0 0.0;
     0.0 0.0 0.0 -1.0]
end

function cNotGate()
    [1.0 0.0 0.0 0.0;
     0.0 1.0 0.0 0.0;
     0.0 0.0 0.0 1.0;
     0.0 0.0 1.0 0.0]
end

function swapGate()
    [1.0 0.0 0.0 0.0;
     0.0 0.0 1.0 0.0;
     0.0 1.0 0.0 0.0;
     0.0 0.0 0.0 1.0]
end

end