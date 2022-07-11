% volatile/stable block of ML run_function

function run_hyb_EV_volatile_last(nname)

if exist('nname') == 0
  fprintf("No nname given!\n");
  exit();
end
display(nname);

% participants with stable block first: 3, 5, 7, 9, 11, 13, 15, 17, 19, 
% 21, 23, 25, 27, 29, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 
% 57, 59, 61, 63 


vp = {'3'; '5'; '7'; '9'; '11'; '13'; '15'; '17'; '19'; '21'; '23'; '25'; 
    '27'; '29'; '35'; '37'; '39'; '41'; '43'; '45'; '47'; '49'; '51'; '53'; '55'; 
    '57'; '59'; '61'; '63'}; 

num_it = 1000; 

hyb_EV_volatile_last.names = {'wm', 'wp', 'wmult', 'beta_m', 'beta_p', 'beta_mult', 'LLE', 'bic', 'aic'}; 

sub_pls = load("optlearnprob.mat"); 

for i = 1:numel(vp)
        disp(vp{i}); 
        tic
        data = readtable(['./data/ml-',vp{i},'.csv']);
        data = data(200:end,:); 
        tf = isfinite(data.choice_side); 
       
        subpls = sub_pls.optlearnprob(i,:); 
        subpls = subpls(200:end); 
        for k = 1:length(tf)
        if tf(k) == 0 
        subpls(k) = [];
        end
        end 

        data = rmmissing(data,'DataVariables',["choice_side"]); % remove nans at choice_side

        [params, betas, modelfit] = function_hyb_EV_stable(data,num_it,subpls); % function is the same for all blocks
        bic = 2*modelfit + numel(params)*log(size(data,1)); 
        aic = 2*modelfit + (2*numel(params)); 
        hyb_EV_volatile_last.params(i,:) = [params, betas, modelfit, bic, aic]; 
        toc 
end 

    save('./hyb_EV_volatile_last', 'hyb_EV_volatile_last');


    fprintf("DONE.\n")

end 



