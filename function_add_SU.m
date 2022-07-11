function [fitparams, betas, modelfit] = function_add_SU(data, num_it)

% function script for add SU model (both distortions)

% first: set up fmincon and betas 

lb = [0 0 0 0]; 
ub = [60 60 3 3]; % parameters are wm, wp, lambda and gamma

for i = 1:num_it

    x0 = [ub(1)*rand(1) ub(2)*rand(1) ub(3)*rand(1) ub(4)*rand(1)];  
    A = []; b = []; Aeq = []; beq = []; 
    options = optimoptions('fmincon', 'Display', 'off');

    [fitparams_1, modelfit_1] = fmincon(@SU_model_add, x0, A, b, Aeq, beq, lb, ub, [], options);
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

beta_m = fitparams(1)/(fitparams(1) + fitparams(2)); 
beta_p = fitparams(2)/(fitparams(2) + fitparams(1)); 

betas = [beta_m beta_p]; 

% second: set up model function to be minimized by fmincon

function loglikehood = SU_model_add(params)

% get relevant info out of data: choices, probs and magnitudes

choices = data.choice_side; 
choices = choices + 1; 

pl = data.prob_left./100; 
pr = data.prob_right./100; 
ml = data.mag_left;
mr = data.mag_right;

% turn objective into subjective values

lambda = params(3);
gamma = params(4); 

sml = ml.^lambda;
smr = mr.^lambda;
spl = (pl .^gamma) ./ ((pl.^gamma  +  (1-pl).^gamma).^(1./gamma));
spr = (pr .^gamma) ./ ((pr.^gamma  +  (1-pr).^gamma).^(1./gamma));

wm = params(1);
wp = params(2); 
            
svl = (wm*sml)+(wp*spl);
svr = (wm*smr)+(wp*spr);
 
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