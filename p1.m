%% Problem 1
% Jean-Christophe Perrin
% 2018 February 28

clear all;
clc;

%% Part C
% Approximate the following function using the following function using a
% composite Simpson's rule over $N+1$ possible unevenly spaced points.
% 
% $$ \int_0^1 \sin (4\pi x^2) dx $$

toApproximate = @(x) sin(4*pi*x.^2);

lowerBound = 0;
upperBound = 1;

%%
% Implement this approximation using
% $$ N=16 $$

N = 16;

%% Evenly Spaced Points
% From the lecture notes, we know that the area given by using Simpson's
% rule over constantly space subintervals is given by the following
% function:
% $$ \int p = \frac{h}{3}(f_0 + 4\sum f_{odd} + 2\sum f_{even} + f_n) $$

abscissae = linspace(lowerBound, upperBound, N+1);
fnEvals = toApproximate(abscissae);

h = (upperBound-lowerBound)/N;

interiorPoints = fnEvals(2:end-1);
oddInteriorPoints = interiorPoints(1:2:end);
evenInteriorPoints = interiorPoints(2:2:end);

intConst = h/3*(fnEvals(1) + 4*sum(oddInteriorPoints) ...
                + 2*sum(evenInteriorPoints) + fnEvals(end));

fprintf(' Integral (const width): %.4f\n', intConst);

%% Unevenly Spaced Points
% The spacing of our abscissae is given by the following equation.

abscissae = sqrt(linspace(lowerBound, upperBound, N+1));
fnEvals = toApproximate(abscissae);

%% 
% I will vectorize the spacing between points to make my life easier at
% later points in the problem.

h = abscissae(2:end) - abscissae(1:end-1);

%%
% The linear combination that we calculated over the homework problem set
% will be useful here. Over the interval $x_{i-1)<x<x_{i+1}$ the apprximate
% integral is given by:
%
% $$ \int p' = $$
%

integralVarh = 0;

for firstIndex = 1:2:length(abscissae)-2
    theseYs = fnEvals(firstIndex:firstIndex+2)';
    thisH0 = h(firstIndex);
    thisH1 = h(firstIndex+1);
    thisInterval = thisH0+thisH1;

    weight1 = thisInterval^2 /3/thisH0 ;
    weight1 = weight1 - (2*thisH0+thisH1)/2*thisInterval/thisH0;
    weight1 = weight1 + thisInterval;

    weight2 = -thisInterval^3/6/thisH0/thisH1;

    weight3 = thisInterval^2/3/thisH1 - thisInterval/2;
    
    integralVarh = integralVarh + [weight1 weight2 weight3]*theseYs;
end % loop over all panes

fprintf(' Integral (variable width): %.5f\n', integralVarh);

%% Accuracy of Both Methods
% Let's compare both of these methods to MatLab's built-in quadrature
% method quad.

mlQuad = quad(toApproximate, lowerBound, upperBound);

%%
% Now to compare the relative accuracy of my two solutions.

deviation = ([intConst, integralVarh] - mlQuad) ./ mlQuad;
fprintf('\n Variation for h  = c: %.2e \n', deviation(1));
fprintf(' Variation for h != c: %.2e \n', deviation(2));


