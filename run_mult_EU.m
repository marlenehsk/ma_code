% script to run function_mult_EU

clear all, clc; 

vp = {'3'; '4'; '5'; '6'; '7';'8'; '9'; '10'; '11'; '12'; '13'; '14'; 
    '15'; '16'; '17'; '18'; '19'; '20'; '21'; '22'; '23'; '24'; '25'; '26'; 
    '27'; '28'; '29'; '30'; '33'; '34'; '35'; '36'; '37'; '38'; 
    '39'; '40'; '41'; '42'; '43'; '44'; '45'; '46'; '47'; '48'; '49'; '50';
    '51'; '52'; '53'; '54'; '55'; '56'; '57'; '58'; '59'; '60'; '61'; '62'; 
    '63'; '64'}; % exclude 1, 2, 31, 32

num_it = 1000; 

mult_EU.names = {'wmult', 'lambda', 'modelfit', 'bic', 'aic'}; 

for i = 1:numel(vp)
        disp(vp{i}); 
        tic
        data = readtable(['//Users/marlene/Desktop/Masterarbeit/ma_code/vbm/data/vbm-',vp{i},'.csv']);
        data = rmmissing(data,'DataVariables',["choice_side"]); % remove trials with nan at choice_side
    
        [fitparams, modelfit] = function_mult_EU(data,num_it); 
        bic = 2*modelfit + numel(fitparams)*log(size(data,1)); 
        aic = 2*modelfit + (2*numel(fitparams)); 
        mult_EU.params(i,:) = [fitparams, modelfit, bic, aic]; 
        toc
end 

    save('//Users/marlene/Desktop/Masterarbeit/ma_code/vbm/results/mult_EU', 'mult_EU');



