% run ml_function_mult_EV_bayes
% ready to run on HPC server 

vp = {'3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'; '11'; '12'; '13'; '14'; 
   '15'; '16'; '17'; '18'; '19'; '20'; '21'; '22'; '23'; '24'; '25'; '26'; 
   '27'; '28'; '29'; '30'; '33'; '34'; '35'; '36'; '37'; '38'; 
   '39'; '40'; '41'; '42'; '43'; '44'; '45'; '46'; '47'; '48'; '49'; '50';
   '51'; '52'; '53'; '54'; '55'; '56'; '57'; '58'; '59'; '60'; '61'; '62'; 
   '63'; '64'}; 

num_it = 1000; 

ml_mult_EV_bayes.names = {'params', 'fitval', 'bic', 'aic'}; 

subps = load("optlearnprob.mat"); 

for i = 1:numel(vp)
        disp(vp{i}); 
        tic
        data = readtable(['//Users/marlene/Desktop/Masterarbeit/ma_code/ml/data/ml-',vp{i},'.csv']);
        tf = isfinite(data.choice_side); 
        data = rmmissing(data,'DataVariables',["choice_side"]); % remove nans at choice_side

        subpls = subps.optlearnprob(i,:);  
        for k = 1:length(tf)
        if tf(k) == 0 
        subpls(k) = [];
        end
        end 
       
        [params, fitval] = ml_function_mult_EV_bayes(data,num_it,subpls); 
        bic = 2*fitval + numel(params)*log(size(data,1)); 
        aic = 2*fitval + (2*numel(params)); 
        ml_mult_EV_bayes.params(i,:) = [params, fitval, bic, aic]; 
        toc
end 

    save('//Users/marlene/Desktop/Masterarbeit/ma_code/ml/results/ml_mult_EV_bayes', 'ml_mult_EV_bayes');


