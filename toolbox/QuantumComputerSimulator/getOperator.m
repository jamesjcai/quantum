function op = getOperator(opName, theta, phi, lambda)  
%The code returns matrix for requested single q-bit operator.
%EXP operator - matrix in exponent has to be defined as a global variable A
    global A;
    
    switch opName
        case 'I' 
            op = [1 0; 0 1];
        case 'X' 
            op = [0 1; 1 0];
        case 'Y'
            op = [0 -1i; 1i 0];
        case 'Z'
            op = [1 0; 0 -1];
        case 'H'    
            op = (1/sqrt(2))*[1 1; 1 -1];
        case 'S'
            op = [1 0; 0 1i];
        case 'T'
            op = [1 0; 0 exp(1i*pi/4)];
        case 'DS'
            op = [1 0; 0 -1i];
        case 'DT'
            op = [1 0; 0 exp(-1i*pi/4)];
        case 'U1'
            op = [1 0; 0 exp(1i*theta)];
        case 'U2'
            op = (1/sqrt(2))*[1 -exp(1i*theta); exp(1i*phi) exp(1i*(theta + phi))];
        case 'U3'
            op = [cos(theta/2) -exp(1i*lambda)*sin(theta/2); exp(1i*phi)*sin(theta/2) exp(1i*(lambda + phi))*cos(theta/2)];
        case 'RX'
            op = [cos(theta/2) -1i*sin(theta/2); -1i*sin(theta/2) cos(theta/2)];
        case 'RY'
            op = [cos(theta/2) -sin(theta/2); sin(theta/2) cos(theta/2)];
        case 'RZ'
            op = [exp(-1i*theta/2) 0; 0 exp(1i*theta/2)];
        case 'EXP'            
            op = expm(theta*A);
        otherwise
            error 'Uknown operator!'
    end
end