%% Problem 2
% Jean-Christophe Perrin
% 2018 February 26

clear all
clc

%% Deterimining the Weights
% If our method exactly integrates up to a 2nd degree polynomial, then we
% know that at %g(x)=1%, %g(x)=x%, and %g(x)=x^2% that 
% $$\Sigma w_i g_i = \int \frac{g(x)}{\sqrt{1-x^2}} $$.
% Further we are given the final values for the three analytic
% integrals listed above.

analyticIntegrals = [pi; 0; pi/2];
sumFnEvals = [1 1 1; -1 0 1; 1 0 1]; % linear comb of weighted evals
disp(sumFnEvals);

%%
% We can take the inverse of the matrix of function evals to find the
% weights.

weights = sumFnEvals\analyticIntegrals;
disp(weights);

%% Approximate Integral
% 
