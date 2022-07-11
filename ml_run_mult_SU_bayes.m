% run ml_function_mult_SU_bayes
% ready to run on HPC server 

function ml_run_mult_SU_bayes(nname)

% input_filename should be set in the call
if exist('nname') == 0
  fprintf("No nname given!\n");
  exit();
end
display(nname);

vp = {'3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'; '11'; '12'; '13'; '14'; 
    '15'; '16'; '17'; '18'; '19'; '20'; '21'; '22'; '23'; '24'; '25'; '26'; 
    '27'; '28'; '29'; '30'; '33'; '34'; '35'; '36'; '37'; '38'; 
    '39'; '40'; '41'; '42'; '43'; '44'; '45'; '46'; '47'; '48'; '49'; '50';
    '51'; '52'; '53'; '54'; '55'; '56'; '57'; '58'; '59'; '60'; '61'; '62'; 
    '63'; '64'}; % exclude 1, 2, 31, 32

num_it = 1000; 

ml_mult_SU_bayes.names = {'wmult', 'lambda', 'gamma', 'modelfit', 'bic', 'aic'}; 

subps = load("optlearnprob.mat"); 

for i = 1:numel(vp)
        disp(vp{i}); 
        data = readtable(['./data/ml-',vp{i},'.csv']);
        tf = isfinite(data.choice_side); 
        data = rmmissing(data,'DataVariables',["choice_side"]); % remove nans at choice_side

        subpls = subps.optlearnprob(i,:);  
        for k = 1:length(tf)
        if tf(k) == 0 
        subpls(k) = [];
        end
        end 

        [params, modelfit] = ml_function_mult_SU_bayes(data,num_it,subpls); 
        bic = 2*modelfit + numel(params)*log(size(data,1)); 
        aic = 2*modelfit + (2*numel(params)); 
        ml_mult_SU_bayes.params(i,:) = [params, modelfit, bic, aic]; 
        
end 

    save('./ml_mult_SU_bayes', 'ml_mult_SU_bayes');


    fprintf("DONE.\n")

end 

