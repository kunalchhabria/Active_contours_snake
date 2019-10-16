clear all;
% beta stiffness
% alpha  contract more
% more gamma less change
% kappa 
N = 500;
alpha = 0.2; 
beta = 0.05;
gamma = 0.2;
kappa = 0.15;
Wline = 02.5;
Wedge = 4.0;
Wterm = 03.5;
sigma = 0.5;


% Load image
I = imread('images/circle.jpg');
if (ndims(I) == 3)
    I = rgb2gray(I);
end

% Initialize the snake
[x, y] = initializeSnake(I);

% Calculate external energy
I_smooth = double(imgaussfilt(I, sigma));
Eext = getExternalEnergy(I_smooth,Wline,Wedge,Wterm);

% Calculate matrix A^-1 for the iteration
Ainv = getInternalEnergyMatrixBonus(size(x,2), alpha, beta, gamma);
x=x';
y=y';
sobelX = [1 0 -1; 2 0 -2; 1 0 -1];
sobelY = [1 2 1; 0 0 0; -1 -2 -1];
fx=conv2(Eext, sobelX, 'same');
fy=conv2(Eext, sobelY, 'same');
% Iterate and update positions
displaySteps = floor(N/30);
for i=1:N
    % Iterate
    [x,y] = iterate(Ainv, x, y, Eext, gamma, kappa,fx,fy);

    % Plot intermediate result
    imshow(I); 
    hold on;
    plot(x, y , 'r');
        
    % Display step
    if(mod(i,displaySteps)==0)
        fprintf('%d/%d iterations\n',i,N);
    end
    
    pause(0.0001)
end
 
if(displaySteps ~= N)
    fprintf('%d/%d iterations\n',N,N);
end