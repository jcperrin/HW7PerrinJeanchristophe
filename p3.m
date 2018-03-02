%% Problem 3
% Jean-Christophe Perrin
% 2018 February 26

clear all;
clc;

%% Given
% How long does it take to climb a mountain? Let
% $$ z(x, y) = -0.1e^{y-(x-1)^2}sin(3\pi y/_2) $$

z_formula = @(x, y) -0.1.*exp(y-(x-1).^2).*sin(3*pi/2.*y);

%%
% The X and Y values of the different steps are given in the file
% hiking_trail.mat.

load hiking_trail.mat

%%
% Assume that your velocity is given by 
% $$ v = e^{-m} $$
% where $m$ is the slope.

vel = @(m) exp(-m);

%% Solve
% Assume that the travel time is given by:
% $$ t = \Sigma \frac{\sqrt{\Delta x^2+\Delta y^2 + \Delta z^2}}{e^{-m}} $$
% First thing to do is to solve for the z values at any $(x, y)$ pair.

Z = z_formula(X, Y);

%%
% Now we can calculate the finite differences of X, Y, and Z.

stepX = X(2:end)- X(1:end-1);
stepY = Y(2:end)- Y(1:end-1);
stepZ = Z(2:end)- Z(1:end-1);

%%
% Once we have the finite differences in each of the vectors we can
% calculate a linear approximation of the slop at each step.
%
% $$ m = \frac{rise}{run} = \frac{\Delta z}{\sqrt{\Delta X^2 + \Delta y^2}}
% $$

stepS = sqrt(stepX.^2 + stepY.^2);  % chord length at each step
stepSlope = stepZ ./ stepS;

%%
% Now that we have the slope we can calculate the velocity at each step.

stepVelocity = exp(-stepSlope);

%%
% The total distance traveled on each step is the 3D pythagorean theorum.

stepDistance = sqrt(stepX.^2+stepY.^2+stepZ.^2);

%%
% The velocity of a point is defined as:
% $$ v = \frac{dist}{time} $$
% Rearranging:
% $$ t = \Sigma \frac{\Delta X}{\Delta v} $$

stepTime = stepDistance ./ stepVelocity;
time = sum(stepTime);

display(time);

%%
% Unfortunately, because we are not given any units for this problem we
% can't verify if this generally makes sense as an answer. Instead, let's
% make some pretty pictures.

%% Bird's Eye View
plot(X, Y);
title('Birds Eye view of the trail');

%% 3D Plot
plot3(X, Y, Z);
title('Hiking Trail in 3D');

