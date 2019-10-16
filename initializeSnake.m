function [x, y] = initializeSnake(I)
% Show figure
fig = figure;
imshow(I);
max_len=max(size(I))-1;
% Get initial points
axis([0 1 0 1]);
imshow(I);

[x,y] = getpts();
hold on;
x=transpose(x);
y=transpose(y);
%disp(x);
x=[x,x(1)];
y=[y,y(1)];
knots=[x;y];
num_of_pts=length(x);
distance_pts=1:num_of_pts;
final_distance_pts=1:0.05:num_of_pts;
closed_curve=spline(distance_pts,knots,final_distance_pts);
closed_curve(closed_curve<1)=1;
closed_curve(closed_curve>max_len)=max_len;
xnew=closed_curve(1,:);
ynew=closed_curve(2,:);
plot(x,y,'o',xnew,ynew,'--');
x=xnew;
y=ynew;
hold on;


end
