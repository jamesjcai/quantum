module Gates

using LinearAlgebra

export xGate, yGate, zGate, hGate, iGate, cPhaseShifGate, cNotGate
export swapGate, rxGate, ryGate, rzGate

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

function cNotGate(rev=false)
    if rev
        [1.0 0.0 0.0 0.0;
        0.0 0.0 0.0 1.0;
        0.0 0.0 1.0 0.0;
        0.0 1.0 0.0 0.0]
    else
        [1.0 0.0 0.0 0.0;
        0.0 1.0 0.0 0.0;
        0.0 0.0 0.0 1.0;
        0.0 0.0 1.0 0.0]        
    end   
end

function swapGate()
    [1.0 0.0 0.0 0.0;
     0.0 0.0 1.0 0.0;
     0.0 1.0 0.0 0.0;
     0.0 0.0 0.0 1.0]
end

function rxGate(θ=pi)
    [cos(θ/2) -1im*sin(θ/2); 1im*sin(θ/2) cos(θ/2)]
end

function ryGate(θ=pi)
    [cos(θ/2) -sin(θ/2); sin(θ/2) cos(θ/2)]
end

function rzGate(ϕ=pi)
    [1.0 0.0; 0.0 exp(1im*ϕ)]
end

end