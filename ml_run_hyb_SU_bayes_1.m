% run ml_function_hyb_SU_bayes 3/3 of participants
% ready to run on HPC server 

function ml_run_hyb_SU_bayes_1(nname)

% input_filename should be set in the call
if exist('nname') == 0
  fprintf("No nname given!\n");
  exit();
end
display(nname);

warning('off','all')
warning


vp = {'3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'; '11'; '12'; '13'; '14'; 
    '15'; '16'; '17'; '18'; '19'; '20'}; % exclude 1, 2, 31, 32

num_it = 1000; 

ml_hyb_SU_bayes_1.names = {'wm', 'wp', 'wmult', 'lambda', 'gamma', 'modelfit', 'LLE', 'bic'}; 

subps = load("optlearnprob.mat"); 

for i = 1:numel(vp)
        disp(vp{i}); 
        tic 
        data = readtable(['./data/ml-',vp{i},'.csv']);
        tf = isfinite(data.choice_side); 
        data = rmmissing(data,'DataVariables',["choice_side"]); % remove nans at choice_side

        subpls = subps.optlearnprob(i,:);  
        for k = 1:length(tf)
        if tf(k) == 0 
        subpls(k) = [];
        end
        end 

        [params, betas, modelfit] = ml_function_hyb_SU_bayes(data,num_it,subpls); 
        bic = 2*modelfit + numel(params)*log(size(data,1)); 
        aic = 2*modelfit + (2*numel(params)); 
        ml_hyb_SU_bayes_1.params(i,:) = [params, betas, modelfit, bic, aic];
        toc
        
end 

    save('./ml_hyb_SU_bayes_1', 'ml_hyb_SU_bayes_1');


    fprintf("DONE.\n")

end 


