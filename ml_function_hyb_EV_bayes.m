% function ml_function_hyb_EV_bayes

function [fitparams, betas, modelfit] = ml_function_hyb_EV_bayes(data, num_it,subpls)

lb = [0 0 0]; 
ub = [60 60 60]; % parameters are wm, wp, wmult, all bound to 60

for i = 1:num_it

    x0 = [ub(1)*rand(1) ub(2)*rand(1) ub(3)*rand(1)];
    A = []; b = []; Aeq = []; beq = []; 
    options = optimoptions('fmincon', 'Display', 'off');

    [fitparams_1, modelfit_1] = fmincon(@EV_model_hyb, x0, A, b, Aeq, beq, lb, ub, [], options);
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

beta_mult_final = (fitparams(3)/(fitparams(1) + fitparams(2) + fitparams(3)));
beta_m_final = fitparams(1)/(fitparams(2) + fitparams(1));
beta_p_final = fitparams(2)/(fitparams(2) + fitparams(1));
betas = [beta_m_final beta_p_final beta_mult_final];

% second: set up model function to be minimized by fmincon

function loglikehood = EV_model_hyb(params)

% get relevant info out of data: choices, probs and magnitudes

choices = data.choice_side; 
choices = choices + 1; 

ml = data.mag_left;
mr = data.mag_right;

subprs = 1 - subpls; 

subpl = subpls'; 
subpr = subprs'; 

% define fitted parameters

wm = params(1);
wp = params(2);
wmult = params(3);

% calculate betas 

beta_mult = round(wmult/(wm + wp + wmult),4);
beta_m = round(wm/(wm + wp),4);
beta_p = round(wp/(wm + wp),4);

wsum = wm + wp + wmult; 

% compute subjective values, equations by Farashahi paper

svl = wsum * ((1-beta_mult)*(beta_m*ml + beta_p*subpl) + beta_mult*(subpl.*ml));
svr = wsum * ((1-beta_mult)*(beta_m*mr + beta_p*subpr) + beta_mult*(subpr.*mr));
              
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