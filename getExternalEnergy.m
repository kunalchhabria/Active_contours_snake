function [Eext] = getExternalEnergy(I,Wline,Wedge,Wterm)
Eline=double(I);

% Eedge
%[Gmag,Gdir] = imgradient(I);
%Eedge=-1*(Gmag);

[Gradient_x,Gradient_y] = gradient(I);
Eedge = -1 * sqrt ((Gradient_x .^2 + Gradient_y.^2));
% Eterm
sobelX = [1 0 -1; 2 0 -2; 1 0 -1];
sobelY = [1 2 1; 0 0 0; -1 -2 -1];
Cx=conv2(I, sobelX, 'same');
Cy=conv2(I, sobelY, 'same');
Cxx=conv2(Cx, sobelX, 'same');
Cyy=conv2(Cy, sobelY, 'same');
Cxy=conv2(Cx, sobelY, 'same');

Eterm_numerator=(Cyy.*(Cx.*Cx)) - (2.*Cxy.*(Cx.*Cy)) + (Cxx.*(Cy.*Cy)); 
Eterm_denominator= (1 + (Cx.*Cx) + (Cy.*Cy)).^1.5;
Eterm=Eterm_numerator./ Eterm_denominator;

%Eterm=double(Eterm);
Eext= Wline*Eline + Wterm*Eterm+ Wedge*Eedge;
Eext=Eext/max(Eext(:));
%Eext=normalize(Eext);
end

