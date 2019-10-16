function [Ainv] = getInternalEnergyMatrix(nPoints, alpha, beta, gamma)

A_matrix = zeros(nPoints,nPoints);
A_row=zeros(1,nPoints);
A_row(1)=2*alpha + 6 *beta;
A_row(2)= -alpha - 4*beta;
A_row(3)=beta;
A_row(nPoints-1)=beta;
A_row(nPoints)=-alpha - 4*beta;

for i=1:nPoints
    A_matrix(i,:) = A_row;
    A_row= [A_row(nPoints) A_row(1:nPoints-1)];
    
end
Ainv=inv(A_matrix + gamma*eye(nPoints,nPoints)); 
end

