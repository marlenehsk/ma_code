% function ml_function_add_EV_bayes

function [fitparams, betas, modelfit] = ml_function_add_EV_bayes(data, num_it, subpls)

lb = [0 0]; 
ub = [60 60]; % parameters are wm, wp and alpha 

for i = 1:num_it

    x0 = [ub(1)*rand(1) ub(2)*rand(1)]; 
    A = []; b = []; Aeq = []; beq = []; 
    options = optimoptions('fmincon', 'Display', 'off');

    [fitparams_1, modelfit_1] = fmincon(@EV_model_add, x0, A, b, Aeq, beq, lb, ub, [], options);
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

function loglikehood = EV_model_add(params)

ml = data.mag_left;
mr = data.mag_right;

choices = data.choice_side; 
choices = choices + 1; 

subprs = 1 - subpls; 

subpl = subpls'; 
subpr = subprs'; 

wm = params(1); 
wp = params(2); 
           
svl =(wm*ml)+(wp*subpl);
svr =(wm*mr)+(wp*subpr);
 
pch = []; 
pch(:,1) = 1  ./ (  1 + exp(-(svl - svr))  ); % modeled probability for left choice
pch(:,2) = 1  ./ (  1 + exp(-(svr - svl))  ); % modeled probability for right choice


subpch = zeros((length(choices)),1);
for k = 1:length(pch)
subpch(k,1) = pch(k,choices(k));
end

subpch(subpch<10^-100) = 10^-100;
loglikehood = -sum(log(subpch));

end 

end 