% https://jqub.github.io/2020/06/29/quantumflow/Tutorial-2-QuantumFlow.pdf
x=[.3 .5; .7 .9];
a=[.2343;.3904;.5466;.7028];

x2=[0.0039 0.2118,...
0.2941 0.0275;...
0.0039 0.2784,...
0.5961 0.0667;...
0.0863 0.3176,...
0.5216 0.0588;...
0.1137 0.3608,...
0.1725 0.0039];


x2=[0.1333, 0.2980, 0.1922, 0.0118;...
         0.0980, 0.2667, 0.4941, 0.0392;...
         0.0157, 0.1922, 0.4667, 0.2471;...
         0.0353, 0.2549, 0.3216, 0.1176];

figure; imagesc(x2); colormap gray

[U,S,V] = svd(i_vec(x));

figure; 
subplot(2,2,1)
imagesc(x)
subplot(2,2,2)
imagesc(i_mat(U(:,1)))
colormap gray

figure; 
subplot(2,2,1)
imagesc(x2)
subplot(2,2,2)
imagesc(ToQuantumData(x2,false))
colormap gray



quantum_data = i_vec(ToQuantumData(x2,false));
% qantum_matrix=ToQuantumData(qantum_data,true)
quantum_matrix=ToQuantumMatrix(quantum_data);

%im = [[0.1333, 0.2980, 0.1922, 0.0118],
%         [0.0980, 0.2667, 0.4941, 0.0392],
%         [0.0157, 0.1922, 0.4667, 0.2471],
%         [0.0353, 0.2549, 0.3216, 0.1176]]

fprintf('im = [\n');
for k=1:size(quantum_matrix,1)
    fprintf('[');
    fprintf('%f,',quantum_matrix(k,1:end-1));
    fprintf('%f',quantum_matrix(k,end));
    fprintf('],\n');
end
fprintf(']\n');

