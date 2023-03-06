% concroof   Calculation of the concave roof over pure state decompostions.
%            concroof(rho,func) caluclates the concave roof of func
%            for the density matrix rho, that its, it calculates
%            max_{p_k,Psi_k} sum_k p_k func(Psi_k) with the consition.
%            sum_k |Psi_k><Psi_k|=rho.
%            concroof(rho,func,d_ancilla) can set the size of the
%            ancilla. By default, it is the same as the size of the system.
%            d_ancilla must be a power of the size of rho.
%            concroof(rho,func,d_ancilla,M) can also calculate concave roofs over
%            mixed decompostions with M=1 in the d=2 and d=3 dimensional
%            case. M=0 indicates optmization over pure state decompostions.
%            concroof(rho,func,d_ancilla,M,par) can set the parameters
%            for the numerical optimization. Default is [10000,20000,0.05].
%            Here the first number is the number of random trials
%            intiailly. The second number is the number of refinement
%            steps. Delta is the size of these refinement steps.
%            concroof(rho,func,d_ancilla,M,par,V) with V=1
%            makes the output more detailed.

function supremum = concroof(rho,func,varargin)

[sy,sx]=size(rho);

% Parameters for the simulation
d_ancilla=sx;
MIXED_STATE_DECOMP_ON=0;
Delta=0.05;
Nit1=10000;
Nit2=20000;
Verbose_ON=0;

if  length(varargin)==1,
    d_ancilla=varargin{1};
elseif  length(varargin)==2,
    d_ancilla=varargin{1};
    MIXED_STATE_DECOMP_ON=varargin{2};
elseif  length(varargin)==3,
    d_ancilla=varargin{1};
    MIXED_STATE_DECOMP_ON=varargin{2};
    par=varargin{3};
    Nit1=par(1);
    Nit2=par(2);
    Delta=par(3);
elseif  length(varargin)==4,
    d_ancilla=varargin{1};
    MIXED_STATE_DECOMP_ON=varargin{2};
    par=varargin{3};
    Nit1=par(1);
    Nit2=par(2);
    Delta=par(3);
    Verbose_ON=varargin{4};
elseif length(varargin)>0
    error('Wrong number of input arguments.');
end %if

no_of_ancilla_qudits=floor(log(d_ancilla)/log(sx)+0.0000001);
if abs(log(d_ancilla)/log(sx)-no_of_ancilla_qudits)>0.001
    error('d_ancilla must be power of the size of rho.')
end

% Create a purification based on the eigendecomposition
[v,d]=eig(rho);
dd=diag(d);
purification=zeros(sx*d_ancilla,1);
for k=1:sx
    Psi_k=v(:,k);
    p_k=dd(k);
    label_k=zeros(d_ancilla,1);
    label_k(k)=1;
    purification=purification+sqrt(p_k)*kron(Psi_k,label_k);
end %for

% Initial guess
% The value corresponding to the eigendecomposition

%%%% START %%%%
% Calculate sum_k p_k func(Psi_k) from the purifcation
% Output: sumk_pk_funck
psikA=zeros(sx,d_ancilla);
pkA=zeros(d_ancilla,1);
for k=1:d_ancilla
    v=zeros(d_ancilla,1);
    v(k)=1;
    Pk=ketbra(v);
    projected_state=kron(eye(sx),Pk)*purification;
    rhok=projected_state*projected_state';
    rhok=keep_nonorm(rhok,no_of_ancilla_qudits+1,sx);
    [v,d]=eig(rhok);
    dd=diag(d);
    [Y,index]=sort(-dd);
    ii=index(1);
    psik=v(:,ii);
    % The norm is typically 1
    normpsik=sqrt(psik'*psik);
    if abs(normpsik-1)>0.001
        error('Norm is not one');
    end
    psik=psik/normpsik;
    pk=d(ii,ii)*normpsik;
    psikA(:,k)=psik;
    pkA(k)=pk;
    sumdd=sum(dd);
    difference=sumdd-pk;
%     if abs(difference)>1e-6
%         error('Not a rank-1 state!')
%     end %for
end
sumk_pk_funck=0;
for k=1:d_ancilla
    % Function of psik
    sumk_pk_funck=sumk_pk_funck+pkA(k)*func(ketbra(psikA(:,k)));
end %for

if MIXED_STATE_DECOMP_ON==1
    if d_ancilla==2
        sumk_pk_funck=max(sumk_pk_funck,func(rho));
    elseif d_ancilla==3
        % Works for d_ancilla=3
        sumk_pk_funck_save=sumk_pk_funck;
        
        % (12)(3)
        sumk_pk_funck=0;
        rho12=pkA(1)*ketbra(psikA(:,1))+pkA(2)*ketbra(psikA(:,2));
        p12=trace(rho12);
        rho12=rho12/p12;
        sumk_pk_funck=sumk_pk_funck+p12*func(rho12);
        k=3;
        sumk_pk_funck=sumk_pk_funck+pkA(k)*func(ketbra(psikA(:,k)));
        sumk_pk_funck_save=[sumk_pk_funck_save,sumk_pk_funck];
        
%         if abs(p12+pkA(k)-1)>1e-6
%             error('Sum p_k is not 1.')
%         end
        
        % (1)(23)
        sumk_pk_funck=0;
        rho23=pkA(2)*ketbra(psikA(:,2))+pkA(3)*ketbra(psikA(:,3));
        p23=trace(rho23);
        rho23=rho23/p23;
        sumk_pk_funck=sumk_pk_funck+p23*func(rho23);
        k=1;
        sumk_pk_funck=sumk_pk_funck+pkA(k)*func(ketbra(psikA(:,k)));
        sumk_pk_funck_save=[sumk_pk_funck_save,sumk_pk_funck];
        
%         if abs(p23+pkA(k)-1)>1e-6
%             error('Sum p_k is not 1.')
%         end
        
        % (2)(13)
        sumk_pk_funck=0;
        rho13=pkA(1)*ketbra(psikA(:,1))+pkA(3)*ketbra(psikA(:,3));
        p13=trace(rho13);
        rho13=rho13/p13;
        sumk_pk_funck=sumk_pk_funck+p13*func(rho13);
        k=2;
        sumk_pk_funck=sumk_pk_funck+pkA(k)*func(ketbra(psikA(:,k)));
        sumk_pk_funck_save=[sumk_pk_funck_save,sumk_pk_funck];
        
%         if abs(p13+pkA(k)-1)>1e-6
%             error('Sum p_k is not 1.')
%         end
        
        sumk_pk_funck_save=[sumk_pk_funck_save,func(rho)];
        
        sumk_pk_funck=max(sumk_pk_funck_save);
    end %if
end
%%%% END %%%%

purification0=purification;
sumk_pk_funck0=sumk_pk_funck;
if Verbose_ON==1
    sumk_pk_funck0_initial=sumk_pk_funck0
end

% First phase of the search
% random guesses

for n=1:Nit1
    u=runitary(1,d_ancilla);
    purification=kron(eye(sx),u)*purification0;
    
    %%%% START %%%%
    % Calculate sum_k p_k func(Psi_k) from the purifcation
    % Output: sumk_pk_funck
    psikA=zeros(sx,d_ancilla);
    pkA=zeros(d_ancilla,1);
    for k=1:d_ancilla
        v=zeros(d_ancilla,1);
        v(k)=1;
        Pk=ketbra(v);
        projected_state=kron(eye(sx),Pk)*purification;
        rhok=projected_state*projected_state';
        rhok=keep_nonorm(rhok,no_of_ancilla_qudits+1,sx);
        [v,d]=eig(rhok);
        dd=diag(d);
        [Y,index]=sort(-dd);
        ii=index(1);
        psik=v(:,ii);
        % The norm is typically 1
        normpsik=sqrt(psik'*psik);
        if abs(normpsik-1)>0.001
            error('Norm is not one');
        end
        psik=psik/normpsik;
        pk=d(ii,ii)*normpsik;
        psikA(:,k)=psik;
        pkA(k)=pk;
        sumdd=sum(dd);
        difference=sumdd-pk;
        if abs(difference)>1e-6
            error('Not a rank-1 state!')
        end %for
    end
    sumk_pk_funck=0;
    for k=1:d_ancilla
        % Function of psik
        sumk_pk_funck=sumk_pk_funck+pkA(k)*func(ketbra(psikA(:,k)));
    end %for
    
    if MIXED_STATE_DECOMP_ON==1
        if d_ancilla==2
            sumk_pk_funck=max(sumk_pk_funck,func(rho));
        elseif d_ancilla==3
            % Works for d_ancilla=3
            sumk_pk_funck_save=sumk_pk_funck;
            
            % (12)(3)
            sumk_pk_funck=0;
            rho12=pkA(1)*ketbra(psikA(:,1))+pkA(2)*ketbra(psikA(:,2));
            p12=trace(rho12);
            rho12=rho12/p12;
            sumk_pk_funck=sumk_pk_funck+p12*func(rho12);
            k=3;
            sumk_pk_funck=sumk_pk_funck+pkA(k)*func(ketbra(psikA(:,k)));
            sumk_pk_funck_save=[sumk_pk_funck_save,sumk_pk_funck];
                        
%             if abs(p12+pkA(k)-1)>1e-6
%                 error('Sum p_k is not 1.')
%             end
            
            % (1)(23)
            sumk_pk_funck=0;
            rho23=pkA(2)*ketbra(psikA(:,2))+pkA(3)*ketbra(psikA(:,3));
            p23=trace(rho23);
            rho23=rho23/p23;
            sumk_pk_funck=sumk_pk_funck+p23*func(rho23);
            k=1;
            sumk_pk_funck=sumk_pk_funck+pkA(k)*func(ketbra(psikA(:,k)));
            sumk_pk_funck_save=[sumk_pk_funck_save,sumk_pk_funck];
            
%             if abs(p23+pkA(k)-1)>1e-6
%                 error('Sum p_k is not 1.')
%             end
            
            % (2)(13)
            sumk_pk_funck=0;
            rho13=pkA(1)*ketbra(psikA(:,1))+pkA(3)*ketbra(psikA(:,3));
            p13=trace(rho13);
            rho13=rho13/p13;
            sumk_pk_funck=sumk_pk_funck+p13*func(rho13);
            k=2;
            sumk_pk_funck=sumk_pk_funck+pkA(k)*func(ketbra(psikA(:,k)));
            sumk_pk_funck_save=[sumk_pk_funck_save,sumk_pk_funck];
            
%             if abs(p13+pkA(k)-1)>1e-6
%                 error('Sum p_k is not 1.')
%             end
            
            sumk_pk_funck_save=[sumk_pk_funck_save,func(rho)];
            
            sumk_pk_funck=max(sumk_pk_funck_save);
        end %if
    end
    %%%% END %%%%
    
    %sumk_pk_funck
    
    if sumk_pk_funck>sumk_pk_funck0,
        if Verbose_ON==1
            sumk_pk_funck0=sumk_pk_funck
        end
        purification0=purification;
    end %if
end %for

% Second phase of the search
% small changes around the maximum
% found in the first phase
for n=1:Nit2
    
    u=(runitary(1,d_ancilla))^Delta;
    purification=kron(eye(sx),u)*purification0;
    
    %%%% START %%%%
    % Calculate sum_k p_k func(Psi_k) from the purifcation
    % Output: sumk_pk_funck
    psikA=zeros(sx,d_ancilla);
    pkA=zeros(d_ancilla,1);
    for k=1:d_ancilla
        v=zeros(d_ancilla,1);
        v(k)=1;
        Pk=ketbra(v);
        projected_state=kron(eye(sx),Pk)*purification;
        rhok=projected_state*projected_state';
        rhok=keep_nonorm(rhok,no_of_ancilla_qudits+1,sx);
        [v,d]=eig(rhok);
        dd=diag(d);
        [Y,index]=sort(-dd);
        ii=index(1);
        psik=v(:,ii);
        % The norm is typically 1
        normpsik=sqrt(psik'*psik);
        if abs(normpsik-1)>0.001
            error('Norm is not one');
        end
        psik=psik/normpsik;
        pk=d(ii,ii)*normpsik;
        psikA(:,k)=psik;
        pkA(k)=pk;
        sumdd=sum(dd);
        difference=sumdd-pk;
        if abs(difference)>1e-6
            error('Not a rank-1 state!')
        end %for
    end
    sumk_pk_funck=0;
    for k=1:d_ancilla
        % Function of psik
        sumk_pk_funck=sumk_pk_funck+pkA(k)*func(ketbra(psikA(:,k)));
    end %for
    
%     % Verify
%     r=0;
%     for k=1:d_ancilla
%         % Function of psik
%         r=r+pkA(k)*ketbra(psikA(:,k));
%     end %for
%     if norm(rho-r)>1e-6
%         save
%         error('Wrong decomposition')
%     end
    
    
    if MIXED_STATE_DECOMP_ON==1
        if d_ancilla==2
            sumk_pk_funck=max(sumk_pk_funck,func(rho));
        elseif d_ancilla==3
            % Works for d_ancilla=3
            sumk_pk_funck_save=sumk_pk_funck;
            
            % (12)(3)
            sumk_pk_funck=0;
            rho12=pkA(1)*ketbra(psikA(:,1))+pkA(2)*ketbra(psikA(:,2));
            p12=trace(rho12);
            rho12=rho12/p12;
            sumk_pk_funck=sumk_pk_funck+p12*func(rho12);
            k=3;
            sumk_pk_funck=sumk_pk_funck+pkA(k)*func(ketbra(psikA(:,k)));
            sumk_pk_funck_save=[sumk_pk_funck_save,sumk_pk_funck];
            
            %trace(rho12*ketbra(psikA(:,k)))
            
%             if abs(p12+pkA(k)-1)>1e-6
%                 error('Sum p_k is not 1.')
%             end
            
            % (1)(23)
            sumk_pk_funck=0;
            rho23=pkA(2)*ketbra(psikA(:,2))+pkA(3)*ketbra(psikA(:,3));
            p23=trace(rho23);
            rho23=rho23/p23;
            sumk_pk_funck=sumk_pk_funck+p23*func(rho23);
            k=1;
            sumk_pk_funck=sumk_pk_funck+pkA(k)*func(ketbra(psikA(:,k)));
            sumk_pk_funck_save=[sumk_pk_funck_save,sumk_pk_funck];
            
%             if abs(p23+pkA(k)-1)>1e-6
%                 error('Sum p_k is not 1.')
%             end
            
            % (2)(13)
            sumk_pk_funck=0;
            rho13=pkA(1)*ketbra(psikA(:,1))+pkA(3)*ketbra(psikA(:,3));
            p13=trace(rho13);
            rho13=rho13/p13;
            sumk_pk_funck=sumk_pk_funck+p13*func(rho13);
            k=2;
            sumk_pk_funck=sumk_pk_funck+pkA(k)*func(ketbra(psikA(:,k)));
            sumk_pk_funck_save=[sumk_pk_funck_save,sumk_pk_funck];
            
%             if abs(p13+pkA(k)-1)>1e-6
%                 error('Sum p_k is not 1.')
%             end
            
            sumk_pk_funck_save=[sumk_pk_funck_save,func(rho)];
            
            sumk_pk_funck=max(sumk_pk_funck_save);
        end %if
    end
    %%%% END %%%%
    
    %sumk_pk_funck
    
    if sumk_pk_funck>sumk_pk_funck0,
        if Verbose_ON==1
            sumk_pk_funck0=sumk_pk_funck
        end
        purification0=purification;
    end %if
end %for

supremum=sumk_pk_funck0;






