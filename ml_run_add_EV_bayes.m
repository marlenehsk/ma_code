% run ml_function_add_EV_bayes 

clear all, clc; 

vp = {'3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'; '11'; '12'; '13'; '14'; 
   '15'; '16'; '17'; '18'; '19'; '20'; '21'; '22'; '23'; '24'; '25'; '26'; 
   '27'; '28'; '29'; '30'; '33'; '34'; '35'; '36'; '37'; '38'; 
  '39'; '40'; '41'; '42'; '43'; '44'; '45'; '46'; '47'; '48'; '49'; '50';
   '51'; '52'; '53'; '54'; '55'; '56'; '57'; '58'; '59'; '60'; '61'; '62'; 
   '63'; '64'}; 

num_it = 1000; 

subps = load("optlearnprob.mat"); 

ml_add_EV_bayes.names = {'wm', 'wp', 'beta_m', 'beta_p', 'LLE', 'bic', 'aic'}; 

for iteration = 1:numel(vp)
        disp(vp{iteration});
        tic
        data = readtable(['//Users/marlene/Desktop/Masterarbeit/ma_code/ml/data/ml-',vp{iteration},'.csv']);
        tf = isfinite(data.choice_side); 
        data = rmmissing(data,'DataVariables',["choice_side"]); 

        subpls = subps.optlearnprob(iteration,:);  
        for k = 1:length(tf)
        if tf(k) == 0 
        subpls(k) = [];
        end
        end 

        [params, betas, modelfit] = ml_function_add_EV_bayes(data,num_it, subpls); 
        bic = 2*modelfit + numel(params)*log(size(data,1)); 
        aic = 2*modelfit + (2*numel(params)); 
        ml_add_EV_bayes.params(iteration,:) = [params, betas, modelfit, bic, aic]; 
        toc
end 

    save('//Users/marlene/Desktop/Masterarbeit/ma_code/ml/results/ml_add_EV_bayes', 'ml_add_EV_bayes');

