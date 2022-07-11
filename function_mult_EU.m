function [fitparams, modelfit] = function_mult_EU(data, num_it)

% function script for mult EU model (magnitude, but no prob distortion)

% first: set up fmincon

lb = [0 0]; 
ub = [60 3]; % parameters are wmult and lambda

for i = 1:num_it

    x0 = [ub(1)*rand(1) ub(2)*rand(1)]; 
    A = []; b = []; Aeq = []; beq = []; 
    options = optimoptions('fmincon', 'Display', 'off');

    [fitparams_1, modelfit_1] = fmincon(@EU_model_mult, x0, A, b, Aeq, beq, lb, ub, [], options);
    modelfit_2(i) = modelfit_1;
    fitparams_2(i,:) = fitparams_1;
    
end 

minimum = min(modelfit_2); 
[x] = find(modelfit_2 == minimum); 

if length(x) > 1
    rand_idx = randi(length(x));
    x = x(rand_idx);
end 

modelfit = modelfit_2(x); 
fitparams = fitparams_2(x,:); 

% second: set up model function to be minimized by fmincon

function loglikehood = EU_model_mult(params)

% get relevant info out of data: choices, probs and magnitudes

choices = data.choice_side; 
choices = choices + 1; 

pl = data.prob_left./100; 
pr = data.prob_right./100; 
ml = data.mag_left;
mr = data.mag_right;

% turn objective into subjective values

lambda = params(2);

sml = ml.^lambda;
smr = mr.^lambda;
spl = pl;
spr = pr;

wmult = params(1);
            
svl = (wmult)*(spl.*sml);
svr = (wmult)*(spr.*smr);
 
pch = []; 
pch(:,1) = 1  ./ (  1 + exp(-(svl - svr))  ); % modeled probability for left choice
pch(:,2) = 1  ./ (  1 + exp(-(svr - svl))  ); % modeled probability for right choice


subpch = zeros(length(choices),1);
for k = 1:length(pch)
subpch(k,1) = pch(k,choices(k));
end

subpch(subpch<10^-100) = 10^-100;
loglikehood = -sum(log(subpch));

end 

end 