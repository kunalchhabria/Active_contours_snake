function [newX, newY] = iterate(Ainv, x, y, Eext, gamma, kappa,fx,fy)

newX=Ainv*( gamma*x - kappa*interp2(fx,x,y));
newY=Ainv* (gamma*y - kappa*interp2(fy,x,y));
% Clamp to image size
max_x=max(x);
max_y=max(y);
newY(newY<1)=1;
newY(newY>max_y)=max_y;
newX(newX<1)=1;
newX(newX>max_x)=max_x;
end

