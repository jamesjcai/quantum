module Qubits

export qZero,
       qOne,
       qPlus,
       qMinus

function qZero()
    [1, 0]
end

function qOne()
    [0, 1]
end

function qPlus()
    [1/√2, 1/√2]
end

function qMinus()
    [1/√2, -1/√2]
end

end